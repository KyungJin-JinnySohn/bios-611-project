# BIOS611 Project

Cardiovascular diseases, such as heart attacks, are usually acute events caused by a blockage that prevents blood from flowing to the heart. These are major causes of death and, according to the CDC, one person dies of cardiovascular disease every 34 seconds. In addition, one in five people died from heart disease in the United States in 2020. Since it is a disease directly related to life, it is very important to identify the presence of the disease as soon as possible and prevent the effects in advance. Therefore, we will create a machine learning model to determine the presence or absence of cardiovascular disease from the given data and compare the accuracy of the models.

## Data
The data is from a Kaggle dataset named the 'Cardiovascular Disease dataset' (https://www.kaggle.com/datasets/sulianova/cardiovascular-disease-dataset). The dataset has 11 features available as predictors (id, age, gender, height, weight, ap_hi, ap_lo, cholesterol, gluc, smoke, alco, active) and one response variable, cardio. More specifically, in the table below, the first 10 rows are independent variables and the last row is response variables.
| Full Name | Column Name | Feature Type | Detail |
| :-----: | :----: | ------ | ----------- |
| Age | age | Objective Feature | int (days) |
| Height | height | Objective Feature | int (cm) |
| Weight | weight | Objective Feature | float (kg) |
| Gender | gender | Objective Feature | categorical code |
| Systolic blood pressure | ap_hi | Examination Feature | int |
| Diastolic blood pressure | ap_lo | Examination Feature | int |
| Cholesterol | cholesterol | Examination Feature | 1: normal, 2: above normal, 3: well above normal |
| Glucose | gluc | Examination Feature | 1: normal, 2: above normal, 3: well above normal |
| Smoking | smoke | Subjective Feature | binary |
| Alcohol intake | alco | Subjective Feature | binary |
| Physical activity | active | Subjective Feature | binary |
| Presence or absence of cardiovascular disease | cardio | Target Variable | binary |

The objective feature is factual information, the examination feature is the result of the medical examination, and the subjective feature is the information provided by the patient.

## Goal
With this data, I will create multiple classification models that distinguish patients with cardiovascular disease.  In particular, I hope this project will be a good study for applying various machine learning models and further ensemble modeling.

## Reference
* https://www.who.int/news-room/fact-sheets/detail/cardiovascular-diseases-(cvds)
* https://www.cdc.gov/heartdisease/facts.htm
