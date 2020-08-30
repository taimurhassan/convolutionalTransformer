# Incremental Instance Segmentation Framework for Recognizing Extremely Cluttered Baggage Threats

## Code Documentation
This repository contains the source code as well as some additional results of our proposed incremental instance segmentation framework as illustrated in a block diagram below:

![Block-Diagram](/images/BD.png) 
<p align="center"> Block Diagram of the Proposed Framework</p>

## Installation and Configuration

1) Please download and install Anaconda (also install MATLAB R2020a with deep learning, image processing and computer vision toolbox)
2) Install required packages from the provided ‘environment.yml’ file or alternatively you can install following packages yourself:
   - Python 3.7.4
   - TensorFlow 2.2.0 
   - Keras 2.0.0 or above
   - OpenCV 4.2
   - imgaug 0.2.9 or above
   - tqdm   
3) Download the desired dataset
   - GDXray [URL](https://domingomery.ing.puc.cl/material/gdxray/)
   - SIXray [URL](https://github.com/MeioJane/SIXray)
   - COCO-2017 [URL](https://cocodataset.org/#download)
4) Create the two folders named as 'trainingDataset' and 'testingDataset'
5) Put training images of SIXray or GDXray dataset in '…\trainingDataset\trainImages_K' folder where 'K' represents the iteration or model instance.
6) Put training annotation in '…\trainingDataset\trainGT_K' folder.
7) Put validation images in '…\trainingDataset\valImages_K' folder.
8) Put validation annotations in '…\trainingDataset\valGT_K' folder.
9) Put the training instances generated through 'instancePatchGenerator.m' in '…\trainingDataset\instances\train\' to train the regressor.
10) Put test images in '…\testingDataset\test_images' folder and their annotations in '…\testingDataset\test_annotations' folder.
    - Note: the images and annotations should have same name and extension (preferably png).
11) For training and testing the regression model, the instance patches should be placed in 'trainingDataset\instances\train' and 'testingDataset\instances\test' folders, respectively.
12) Apart from this, the 'segmentation_resultsK' folder in 'testingDataset' will contains the segmented results.
13) Provide training configurations in ‘config.py’ file.

## Procedure

1) Use 'trainer.py' to incrementally train the segmentation network. The following script will also save the model instances in the h5 file.
2) Afterwards, use 'regressor.m' file to train the regression model. This script will also save the trained regression model in a mat file.
3) Use 'tester.py' file to extract segmentation results for each model (the model results will be saved in 'segmentation_resultsK' folder.
4) Use 'highlighterGDXray.m' or 'highlighterSIXray.m' files to visualize instance segmentation results on GDXray and SIXray datasets, respectively.
5) We have also provided some converter scripts to convert e.g. original SIXray XML annotations into MATLAB structures, to port TF keras models into MATLAB etc.
6) Apart from this, the ‘results’ folder in this package contains some additional results obtained by the proposed framework.

## Contact
Please feel free to contact us in case of any query at: taimur.hassan@ku.ac.ae
