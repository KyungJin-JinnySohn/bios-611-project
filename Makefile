.PHONY: clean
.PHONY: d3-vis
.PHONY: visualization

clean:
	rm -rf figures
	rm -rf derived_data
	rm -rf .created-dirs
	rm -f BIOS611_Final_Report_KyungjinSohn.pdf

.created-dirs:
	mkdir -p figures
	mkdir -p derived_data
	touch .created-dirs

# Recipe for cleaning data
derived_data/cardio_clean.csv: .created-dirs\
 source_data/cardio_train.csv\
 01_Clean_Data.R
	Rscript 01_Clean_Data.R

# Recipe for EDA
figures/dist_age.png figures/dist_bmi.png figures/box_ap.png figures/bar_cate.png: derived_data/cardio_clean.csv\
 02_EDA.R
	Rscript 02_EDA.R

# Recipe for implementing models
derived_data/test_summary.csv figures/rf_important.png: derived_data/cardio_clean.csv\
 03_Models.R
	Rscript 03_Models.R

# Recipe for summarizing models' AUC
derived_data/rates_summary.csv figures/roc_LDA.png figures/roc_QDA.png figures/roc_KNN.png figures/roc_Logistic.png figures/roc_RandomForest.png: derived_data/test_summary.csv\
 04_Summary.R
	Rscript 04_Summary.R

# Recipe to build final report
BIOS611_Final_Report_KyungjinSohn.pdf: BIOS611_Final_Report_KyungjinSohn.Rmd\
 figures/dist_age.png\
 figures/dist_bmi.png\
 figures/box_ap.png\
 derived_data/rates_summary.csv
	Rscript -e "rmarkdown::render('BIOS611_Final_Report_KyungjinSohn.Rmd', output_format='pdf_document')";