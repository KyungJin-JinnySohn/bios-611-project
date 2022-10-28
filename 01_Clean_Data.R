##########################
# 01_Clean_Data          #
# Writer: Kyungjin Sohn  #
# Date: 10/26/2022       #
##########################

# 0. Call libraries
library(dplyr)
library(ggplot2)

# 1. Read file
cardio <- read.csv("./source_data/cardio_train.csv", header = TRUE, sep = ";")
#str(cardio)
num.rows <- nrow(cardio)

# 2. Remove duplicate rows after removing the first column (just row number)
cardio.prep <- cardio %>% 
        select(-c(id)) %>%
        distinct(.keep_all = TRUE)
summary(cardio.prep)
num.rows <- c(num.rows, nrow(cardio.prep))

# 3. Modify age & gender and change categorical variable into factor type
## Age is recorded in days, so need to change into age variable.
## Gender is 1 for female and 2 for male
cardio.prep <- cardio.prep %>% 
        mutate(age = round(age/365.25),
               is_male = ifelse(gender == 2, 1, 0)) %>%
        select(-c(gender)) %>%
        relocate(cardio, .after = last_col()) %>%
        mutate(across(cholesterol:cardio, as.factor))
num.rows <- c(num.rows, nrow(cardio.prep))

# 4. Remove outliers from height and weight 
## Rather than looking at height and weight itself, 
## it is more appropriate to remove extreme cases according to the two correlations.a
## So, we created new column called BMI = weight(kg)/height(m)^2
cardio.prep <- cardio.prep %>%
        mutate(bmi = round(weight/((height/100)^2), 2)) %>% 
        filter(bmi >= 12 & bmi <= 50) %>% 
        relocate(bmi, .after = weight)
num.rows <- c(num.rows, nrow(cardio.prep))

# 5. Remove outliers from ap_hi and ap_lo
## ap_hi and ap_lo cannot be negative and 
## ap_hi has to be bigger than ap_lo
## If a person is ap_hi > 180 or ap_lo > 120, there are in hypertensive condition. 
## However, some values are significantly larger than this number.
## Thus, we'll remove rows that are ap_hi > 250 or ap_lo > 200 or ap_hi < 40 or ap_lo < 40
cardio.prep <- cardio.prep %>% 
        filter(ap_hi >= 40 & ap_lo >= 40 &
                       ap_hi > ap_lo &
                       ap_hi < 250 & ap_lo < 200)
num.rows <- c(num.rows, nrow(cardio.prep))

# 6. Remove na and duplicated rows
cardio.prep <- cardio.prep %>% 
        na.omit() %>% 
        distinct(.keep_all = TRUE)
num.rows <- c(num.rows, nrow(cardio.prep))

# 7. Print output
clean.summary <- data.frame(Step = c("Raw", "Remove duplicates", 
                                     "Modify age and gender", "Remove outliers from BMI", 
                                     "Remove outliers from blood pressure", "Remove NA"),
                            TotalRows = num.rows)
clean.summary

# 8. Save the cleaned data
write.csv(cardio.prep, "./derived_data/cardio_clean.csv", row.names = FALSE)
