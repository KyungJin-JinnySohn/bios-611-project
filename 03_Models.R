##########################
# 03_Models              #
# Writer: Kyungjin Sohn  #
# Date: 12/01/2022       #
##########################

# 0. Call libraries
library(dplyr)
library(MASS) # LDA, QDA
library(caret) # KNN
library(randomForest, quietly = TRUE) # Random Forest
library(glmnet) # logistic
library(pROC) # ROC

# 1. Read cleaned data
cardio.df <- read.csv("./derived_data/cardio_clean.csv", header = TRUE)
cardio.df <- cardio.df %>% 
        mutate(across(cholesterol:cardio, as.factor)) %>% 
        dplyr::select(-c(height, weight))
#str(cardio.df)

# 2. Split train and test data
set.seed(611) # set seed to make partition reproducible 
# 75% of the sample size
train_ind <- sample(seq_len(nrow(cardio.df)), 
                    size = floor(0.75 * nrow(cardio.df)))
# split the data
train.data <-  cardio.df[train_ind,]
test.data <- cardio.df[-train_ind,]

# 3. Models
test.summary <- NULL

# 1) LDA
lda.fit <- lda(cardio ~ ., data = train.data)
lda.pred <- predict(lda.fit, test.data, type = "response")$posterior[,2]
test.summary <- cbind(test.summary, lda.pred)
auc(test.data$cardio, lda.pred) # 0.7869

# 2) QDA
qda.fit <- qda(cardio ~ ., data = train.data)
qda.pred <- predict(qda.fit, test.data, type = "response")$posterior[,2]
test.summary <- cbind(test.summary, qda.pred)
auc(test.data$cardio, qda.pred) # 0.7536

# 3) KNN
k.opt <- round(sqrt(nrow(train.data)))
knn.fit <- knn3(cardio ~ ., data = train.data, k = k.opt)
knn.pred <- predict(knn.fit, test.data, type = "prob")[,2]
test.summary <- cbind(test.summary, knn.pred)
auc(test.data$cardio, knn.pred) # 0.7828

# 4) Random Forest
set.seed(611)
m <- floor(sqrt(ncol(train.data) - 1))
rf.fit <- randomForest(cardio ~ ., data = train.data,
                       mtry = m, importance = TRUE, ntree = 500)
rf.pred <- predict(rf.fit, test.data, type = "prob")[,2]
test.summary <- cbind(test.summary, rf.pred)
auc(test.data$cardio, rf.pred) # 0.7722

## Calculate the importance of each predictor
importance(rf.fit)
## Plot these importance measures
png(filename = "./figures/rf_important.png")
varImpPlot(rf.fit)
dev.off()

# 5) Logistic
log.fit <- glm(cardio ~ ., data = train.data, family = "binomial")
log.pred <- predict(log.fit, test.data, type = "response")
test.summary <- cbind(test.summary, log.pred)
auc(test.data$cardio, log.pred) # 0.7874

# 4. Save the test summary
colnames(test.summary) <- c("LDA", "QDA", "KNN", "RandomForest", "Logistic")
test.summary <- data.frame(test.summary, 
                           Actual = test.data$cardio)
write.csv(test.summary, "./derived_data/test_summary.csv", row.names = FALSE)
