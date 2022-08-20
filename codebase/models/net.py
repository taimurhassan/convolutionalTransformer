import numpy as np
import keras
from keras.models import *
from keras.models import Model
from keras.layers import *
import keras.backend as K
 
from keras import optimizers
from keras.preprocessing.image import ImageDataGenerator
from keras import layers

import tensorflow as tf

from .model_utils import get_segmentation_model, resize_image

batch_size = 4
image_size = 72  # We'll resize input images to this size
patch_size = 6  # Size of the patches to be extract from the input images
num_patches = (image_size // patch_size) ** 2
projection_dim = 64
aggregation = False
num_heads = 4
transformer_units = [
    projection_dim * 2,
    projection_dim,
]  # Size of the transformer layers
transformer_layers = 3
mlp_head_units = [2048, 1024]  # Size of the dense layers of the final classifier

class Patches(layers.Layer):
    def __init__(self, patch_size):
        super(Patches, self).__init__()
        self.patch_size = patch_size

    def call(self, images):
        batch_size = tf.shape(images)[0]
        patches = tf.image.extract_patches(
            images=images,
            sizes=[1, self.patch_size, self.patch_size, 1],
            strides=[1, self.patch_size, self.patch_size, 1],
            rates=[1, 1, 1, 1],
            padding="VALID",
        )
        patch_dims = patches.shape[-1]
        patches = tf.reshape(patches, [batch_size, -1, patch_dims])
        return patches


class PatchEncoder(layers.Layer):
    def __init__(self, num_patches, projection_dim):
        super(PatchEncoder, self).__init__()
        self.num_patches = num_patches
        self.projection = layers.Dense(units=projection_dim)
        self.position_embedding = layers.Embedding(
            input_dim=num_patches, output_dim=projection_dim
        )

    def call(self, patch):
        positions = tf.range(start=0, limit=self.num_patches, delta=1)
        print(self.projection(patch))
        encoded = self.projection(patch) + self.position_embedding(positions)
        return encoded
        
def mlp(x, hidden_units, dropout_rate):
    for units in hidden_units:
        x = layers.Dense(units, activation=tf.nn.gelu)(x)
        x = layers.Dropout(dropout_rate)(x)
    return x
  
def get_segmentor(classes, height=384, width=576, addActivation = False):

    assert height % 192 == 0
    assert width % 192 == 0

    inputLayer, features = encoder(height=height,  width=width)
        
    o = decoder(features, classes)
	
    modelSegmentor = get_segmentation_model(inputLayer, o)
    return modelSegmentor

def transformer(height,  width):
    from .config import IMAGE_ORDERING as order
    
    assert height > 0 == 0
    assert width > 0 == 0

    if order == 'channels_first':
        inputLayer = Input(shape=(3, height, width))
    elif order == 'channels_last':
        inputLayer = Input(shape=(height, width, 3))
    
    patches = Patches(patch_size)(inputLayer)
    print('###############',patches,'###############')
    print('############### Patches Per Image: ',num_patches,'###############')
    encoded_patches = PatchEncoder(num_patches, projection_dim)(patches)
    
    # Create multiple layers of the Transformer block.
    for _ in range(transformer_layers):
        # Layer normalization 1.
        x1 = layers.LayerNormalization(epsilon=1e-6)(encoded_patches)
        # Create a multi-head attention layer.
        attention_output = layers.MultiHeadAttention(
            num_heads=num_heads, key_dim=projection_dim, dropout=0.1
        )(x1, x1)
        # Skip connection 1.
        x2 = layers.Add()([attention_output, encoded_patches])
        # Layer normalization 2.
        x3 = layers.LayerNormalization(epsilon=1e-6)(x2)
        # MLP.
        x3 = mlp(x3, hidden_units=transformer_units, dropout_rate=0.1)
        # Skip connection 2.
        encoded_patches = layers.Add()([x3, x2])

    representation = layers.LayerNormalization(epsilon=1e-6)(encoded_patches)
    representation = layers.Flatten()(representation)
    representation = layers.Dropout(0.5)(representation)
    
    features = mlp(representation, hidden_units=mlp_head_units, dropout_rate=0.5)
    
    return features
    
def net(n_classes,  height=384, width=576, addActivation = False):

    modelSegmentor = get_segmentor(n_classes, height=height, width=width, addActivation = addActivation)
    modelSegmentor.model_name = "segmentor"
	
    return modelSegmentor
    
def encoder(height,  width):
    from .config import IMAGE_ORDERING as order
    
    assert height > 0 == 0
    assert width > 0 == 0

    if order == 'channels_first':
        inputLayer = Input(shape=(3, height, width))
    elif order == 'channels_last':
        inputLayer = Input(shape=(height, width, 3))

    if order == 'channels_last':
        bn_axis = 3
    else:
        bn_axis = 1

    kernel_size = 3
    
    x = ZeroPadding2D((3, 3), data_format=order)(inputLayer)
    x = Conv2D(64, (7, 7), data_format=order, strides=(2, 2))(x)
    s1 = x 
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = MaxPooling2D((3, 3), data_format=order, strides=(2, 2))(x)
    x_i = x
    x = Conv2D(64, (1, 1), data_format=order, strides=(1, 1))(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(64, kernel_size, data_format=order,padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(256, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    sc = Conv2D(256, (1, 1), data_format=order,strides=(1, 1))(x_i)
    sc = BatchNormalization(axis=bn_axis)(sc)
    x = layers.add([x, sc])
    x = Activation('relu')(x)
    x_i = x
    x = Conv2D(64, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(64, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(256, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    x_i = x
    x = Conv2D(64, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(64, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(256, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    s2 = ZeroPadding2D((1, 1), data_format=order)(x)
    if order == 'channels_first':
        s2 = Lambda(lambda s2: s2[:, :, :-1, :-1])(s2)
    elif order == 'channels_last':
        s2 = Lambda(lambda s2: s2[:, :-1, :-1, :])(s2)
    x_i = x
    x = Conv2D(128, (1, 1), data_format=order, strides=(2, 2))(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(128, kernel_size, data_format=order,padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(512, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    sc = Conv2D(512, (1, 1), data_format=order,strides=(2, 2))(x_i)
    sc = BatchNormalization(axis=bn_axis)(sc)
    x = layers.add([x, sc])
    x = Activation('relu')(x)    
    x_i = x
    x = Conv2D(128, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(128, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(512, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    x_i = x
    x = Conv2D(128, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(128, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(512, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    x_i = x
    x = Conv2D(128, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(128, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(512, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    s3 = x
    x_i = x
    x = Conv2D(256, (1, 1), data_format=order, strides=(2, 2))(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(256, kernel_size, data_format=order,padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(1024, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    sc = Conv2D(1024, (1, 1), data_format=order,strides=(2, 2))(x_i)
    sc = BatchNormalization(axis=bn_axis)(sc)
    x = layers.add([x, sc])
    x = Activation('relu')(x)
    x_i = x
    x = Conv2D(256, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(256, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(1024, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    x_i = x
    x = Conv2D(256, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(256, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(1024, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    x_i = x
    x = Conv2D(256, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(256, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(1024, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    x_i = x
    x = Conv2D(256, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(256, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(1024, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    x_i = x
    x = Conv2D(256, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(256, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(1024, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    s4 = x
    x_i = x
    x = Conv2D(512, (1, 1), data_format=order, strides=(2, 2))(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(512, kernel_size, data_format=order,padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(2048, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    sc = Conv2D(2048, (1, 1), data_format=order,strides=(2, 2))(x_i)
    sc = BatchNormalization(axis=bn_axis)(sc)
    x = layers.add([x, sc])
    x = Activation('relu')(x)
    x_i = x
    x = Conv2D(512, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(512, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(2048, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    x_i = x
    x = Conv2D(512, (1, 1), data_format=order)(x_i)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(512, kernel_size, data_format=order, padding='same')(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)
    x = Conv2D(2048, (1, 1), data_format=order)(x)
    x = BatchNormalization(axis=bn_axis)(x)
    x = layers.add([x, x_i])
    x = Activation('relu')(x)
    s5 = x
    
    features = [s1, s2, s3, s4, s5]
    if aggregation:         
        transformerFeatures = transformer(height=num_patches,  width=3)
        features = tf.nn.convolution(features, transformerFeatures)
        
    return inputLayer, features
    

def decoder(features, classes):
    from .config import IMAGE_ORDERING as order

    [first, second, third, forth, lastFeatures] = features
    pool_factors = [1, 2, 3, 6]
    list = [lastFeatures]
	
    for p in pool_factors:
        if order == 'channels_first':
            h = K.int_shape(lastFeatures)[2]
            w = K.int_shape(lastFeatures)[3]
        elif order == 'channels_last':
            h = K.int_shape(lastFeatures)[1]
            w = K.int_shape(lastFeatures)[2]

        pool_size = strides = [
            int(np.round(float(h) / p)),
            int(np.round(float(w) / p))]

        pooledResult = AveragePooling2D(pool_size, data_format=order,
                         strides=strides, padding='same')(lastFeatures)
        pooledResult = Conv2D(512, (1, 1), data_format=order,
               padding='same', use_bias=False)(pooledResult)
        pooledResult = BatchNormalization()(pooledResult)
        pooledResult = Activation('relu')(pooledResult)

        pooledResult = resize_image(pooledResult, strides, data_format=order)
        list.append(pooledResult)
		
    if order == 'channels_first':
        lastFeatures = Concatenate(axis=1)(list)
    elif order == 'channels_last':
        lastFeatures = Concatenate(axis=-1)(list)

    lastFeatures = Conv2D(512, (1, 1), data_format=order, use_bias=False)(lastFeatures)
    lastFeatures = BatchNormalization()(lastFeatures)
    lastFeatures = Activation('relu')(lastFeatures)
    
    f1 = Conv2D(1024, (1, 1), data_format=order, use_bias=False, padding='same')(lastFeatures)
    f1 = resize_image(f1, (2, 2), data_format=order)
    f1 = layers.add([f1, forth])
    f1 = Conv2D(512, (1, 1), data_format=order, use_bias=False)(f1)
    f1 = BatchNormalization()(f1)
    f1 = Activation('relu')(f1)
    
    f2 = resize_image(f1, (2, 2), data_format=order)
    f2 = layers.add([f2, third])
    f2 = Conv2D(512, (1, 1), data_format=order, use_bias=False)(f2)
    f2 = BatchNormalization()(f2)
    f2 = Activation('relu')(f2)
    
    f3 = Conv2D(256, (1, 1), data_format=order, use_bias=False, padding='same')(f2)
    f3 = resize_image(f3, (2, 2), data_format=order)
    f3 = layers.add([f3, second])
    f3 = Conv2D(512, (1, 1), data_format=order, use_bias=False)(f3)
    f3 = BatchNormalization()(f3)
    f3 = Activation('relu')(f3)    
    lastFeatures = f3
 
    lastFeatures = Conv2D(classes, (3, 3), data_format=order, padding='same')(lastFeatures)        
    lastFeatures = resize_image(lastFeatures, (2, 2), data_format=order)
        
    return lastFeatures