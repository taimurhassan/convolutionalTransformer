clc
clear all
close all

% change the paths accordingly as per your system location
pn = 'C:\tcsvt\trainingDataset\instances\train\';
pn2 = 'C:\tcsvt\testingDataset\instances\test\';

imagefiles = dir([pn '*.png']);

nfiles = length(imagefiles);    % Number of files found

r = 224;
c = 224;
ch = 3;

trainingImages = zeros(224,224,3,nfiles);
trainingValue = [];

for ii=1:1:nfiles
    fn = imagefiles(ii).name;
    img = imread([pn fn]);
    
    if ismatrix(img)
        img = cat(3,img,img,img);
    end
    
    trainingImages(:,:,:,ii) = imresize(img,[r,c],'bilinear');
    
    value = str2double(fn(1:2)); 
    if isnan(value)
        value = str2double(fn(1));
    end
    
    trainingValue = [trainingValue; value];
end

imagefiles = dir([pn2 '*.png']);

nfiles = length(imagefiles);    % Number of files found

testingImages = zeros(224,224,3,nfiles);
testingValue = [];
for ii=1:1:nfiles
    fn = imagefiles(ii).name;
    img = imread([pn2 fn]);
    
    if ismatrix(img)
        img = cat(3,img,img,img);
    end
    
    testingImages(:,:,:,ii) = imresize(img,[r,c],'bilinear');
    
    value = str2double(fn(1:2)); 
    if isnan(value)
        value = str2double(fn(1));
    end
    
    testingValue = [testingValue; value];
end

% training of a regressor should be very quick ~ 36 seconds
% turn the doTraining flag off (false) to avoid it if you have the trained
% model.
doTraining = true;

if doTraining
    layers = [
        imageInputLayer([r c ch])

        convolution2dLayer(3,8,'Padding','same')
        batchNormalizationLayer
        reluLayer

        averagePooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,16,'Padding','same')
        batchNormalizationLayer
        reluLayer

        averagePooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,32,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(3,32,'Padding','same')
        batchNormalizationLayer
        reluLayer

        dropoutLayer(0.2)
        fullyConnectedLayer(1)
        regressionLayer];

    miniBatchSize  = 128;
    validationFrequency = floor(numel(trainingValue)/miniBatchSize);
%    options = trainingOptions('sgdm', ...
%        'InitialLearnRate',1e-3, ...
%        'LearnRateSchedule','piecewise', ...
%        'LearnRateDropFactor',0.1, ...
%        'LearnRateDropPeriod',2, ...
%        'MiniBatchSize',miniBatchSize, ...
%        'MaxEpochs',5, ...
%        'Shuffle','every-epoch', ...
%        'ValidationData',{testingImages,testingValue}, ...
%        'ValidationFrequency',validationFrequency, ...
%        'Plots','training-progress'); 
%    Recommended settings
    options = trainingOptions('adam', ...
         'MiniBatchSize',miniBatchSize, ...
         'MaxEpochs',120, ...
         'Shuffle','every-epoch', ...
         'ValidationData',{testingImages,testingValue}, ...
         'ValidationFrequency',validationFrequency, ...
         'Plots','training-progress');

    net = trainNetwork(trainingImages,trainingValue,layers,options);
    save('regressor.mat','net');
else 
    load regressor.mat % load the trained regressor model
end

YPredicted = predict(net,testingImages);
YPredicted = round(YPredicted);
predictionError = testingValue - YPredicted;

squares = predictionError.^2;
rmse = sqrt(mean(squares))