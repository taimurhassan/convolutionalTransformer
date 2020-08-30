# Note: please modify these parameters as per your application need. 
# number of iterations 
K = 3
folderPath = "testingDataset/test_images/"
resultsPath = "testingDataset/segmentation_results"
# By default, we are adding 6 classes in first iteration, 
# 4 more classes in 2nd iteration in the second iteration (total: 10) 
# and 6 more classes in the 3rd iteration (making a total of 16 classes). Modify these settings as per your choice.
newClasses = [6, 4, 6] 
imgHeight = 576
imgWidth = 768