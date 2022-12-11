##########################
# 04_Summary             #
# Writer: Kyungjin Sohn  #
# Date: 12/01/2022       #
##########################

# 0. Call libraries
library(tidyverse)
library(pROC) # ROC

# 1. Function to calculate rates
rates <- function(actual, predicted){
     positive_ii <- which(!!actual);
     negative_ii <- which(!actual);
     
     true_positive <- sum(predicted[positive_ii])/length(positive_ii);
     false_positive <- sum(predicted[negative_ii])/length(negative_ii);
     
     true_negative <- sum(!predicted[negative_ii])/length(negative_ii);
     false_negative <- sum(!predicted[positive_ii])/length(positive_ii);
     tibble(true_positive=true_positive,
            false_positive=false_positive,
            false_negative=false_negative,
            true_negative=true_negative,
            accuracy=sum(actual==predicted)/length(actual));
}

# 2. Read test summary
test.summary <- read.csv("./derived_data/test_summary.csv", header = TRUE)

# 3. Draw ROC curve and calculate rates
rates.summary <- NULL
for (i in 1:(ncol(test.summary)-1)) {
     actual.label <- test.summary[,ncol(test.summary)]
     model.prob <- test.summary[,i]
     # ROC
     png(filename = paste0("./figures/roc_", colnames(test.summary)[i], ".png"))
     roc(actual.label, model.prob, plot = TRUE, print.auc = TRUE)
     dev.off()
     # Rates
     rates.summary <- rbind(rates.summary, 
                            round(rates(actual.label, 1*(model.prob > 0.5)), 4))
}
row.names(rates.summary) <- colnames(test.summary)[-ncol(test.summary)]
write.csv(rates.summary, "./derived_data/rates_summary.csv", row.names = TRUE)