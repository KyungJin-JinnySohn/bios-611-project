# BIOS611 Project

Blood tests to identify and characterize patients' blood samples are performed for disease diagnosis, especially blood-based disease diagnosis. This is because blood cells are easily accessible groups where morphology, biochemistry, and ecology can provide clues to general information about the patient. Blood consists of multiple cells, and each blood cell consists of erythrocytes, platelets, and leukocytes or white blood cells. These cells have a normal range, and if they are outside the normal range, the patient may have some problems. Furthermore, a suspected disease depends on which component is abnormal. Therefore, creating a deep learning model that automatically distinguishes cells in blood cell images is expected to help patients quickly find and treat suspected diseases.

## Data
The data is from a Kaggle dataset named 'Blood Cell Images' (https://www.kaggle.com/datasets/paultimothymooney/blood-cells). The dataset has four groups of blood cell images: Eosinophil, Lymphocyte, Monocyte, and Neutrophil. I plan to use images in the folder 'dataset2-master', which contains 2,500 augmented images with subtype labels. 

## Goal
With this data, I will try various deep learning models including VGG, ResNet, and YOLO. In particular, I hope this project will be a good exercise in creating a model that predicts not just one component per image but multiple components.

## Reference
* http://medcell.med.yale.edu/systems_cell_biology/blood_lab.php
* https://opg.optica.org/osac/fulltext.cfm?uri=osac-4-2-323&id=446861

## License
[MIT](https://choosealicense.com/licenses/mit/)
