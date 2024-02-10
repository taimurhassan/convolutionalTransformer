# Incremental Convolutional Transformer for Baggage Threat Instance Segmentation
<p align="justify">
This repository contains the source code (developed using <b>TensorFlow 2.2.0</b> and <b>Keras</b>) and also some additional results of the proposed incremental convolutional transformer model.
</p>

## "Important" Models architectures are available in 'model_summary.txt', and the training folders hierarchy is given below:
![folders](/images/hierarchy2.png)

## Demo Videos and Additional Results -> [Google Drive](https://drive.google.com/file/d/1ksZ7zva-htZAcuJAbARP-vKVJZg0J7pY/view?usp=sharing)
## Installation and Configuration
<p align="justify">
   
1) Platform: Anaconda and MATLAB R2020a (with deep learning, image processing and computer vision toolbox).
2) Install required packages from the provided ‘environment.yml’ file or alternatively you can install following packages yourself:
   - Python 3.7.4 or above
   - TensorFlow 2.2.0 or above 
   - Keras 2.0.0 or above
   - OpenCV 4.2 or above
   - imgaug 0.2.9 or above
   - tqdm   
3) Download the desired dataset:
   - GDXray [URL](https://domingomery.ing.puc.cl/material/gdxray/)
   - SIXray [URL](https://github.com/MeioJane/SIXray)
   - OPIXray [URL](https://github.com/OPIXray-author/OPIXray)
   - COCO-2017 [URL](https://cocodataset.org/#download)
4) Create the two folders named as 'trainingDataset' and 'testingDataset'.
5) Put training images of SIXray, OPIXray, or GDXray dataset in '…\trainingDataset\trainImages_K' folder where 'K' represents the iteration or model instance.
6) Put training annotation in '…\trainingDataset\trainGT_K' folder.
7) Put validation images in '…\trainingDataset\valImages_K' folder.
8) Put validation annotations in '…\trainingDataset\valGT_K' folder.
9) Put the training instances generated through 'instancePatchGenerator.m' in '…\trainingDataset\instances\train\' to train the regressor.
10) Put test images in '…\testingDataset\test_images' folder and their annotations in '…\testingDataset\test_annotations' folder.
    - Note: the images and annotations should have same name and extension (preferably png).
11) For training and testing the regression model, the instance patches should be placed in 'trainingDataset\instances\train' and 'testingDataset\instances\test' folders, respectively.
12) Apart from this, the 'segmentation_resultsK' folder in 'testingDataset' will contains the segmented results.
13) Provide training configurations in ‘config.py’ file.
14) We also provided the summary of the proposed segmentation model in 'model_summary.txt'.

</p>

## Steps
<p align="justify">
   
1) Use 'trainer.py' to incrementally train the segmentation network. The following script will also save the model instances in the h5 file.
2) Afterwards, use 'regressor.m' file to train the regression model. This script will also save the trained regression model in a mat file.
3) Use 'tester.py' file to extract segmentation results for each model (the model results will be saved in 'segmentation_resultsK' folder.
4) Use highlighter files to visualize instance segmentation results on GDXray, OPIXray and SIXray datasets, respectively.
5) We have also provided some converter scripts to convert e.g. original SIXray XML annotations into MATLAB structures, to port TF keras models into MATLAB etc.
6) Apart from this, the ‘results’ folder in this package contains some additional results obtained by the proposed framework.

</p>

## Contact
Please feel free to contact us in case of any query at: taimur.hassan@ku.ac.ae
