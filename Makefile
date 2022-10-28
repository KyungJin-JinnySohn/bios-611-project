.PHONY: clean
.PHONY: d3-vis
.PHONY: visualization

clean:
	rm -rf models
	rm -rf figures
	rm -rf derived_data
	rm -rf .created-dirs
	rm -f BIOS611_Final_Report_KyungjinSohn.pdf

.created-dirs:
	mkdir -p models
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
	
# Recipe to build final report
BIOS611_Final_Report_KyungjinSohn.pdf: BIOS611_Final_Report_KyungjinSohn.Rmd\
 figures/dist_age.png\
 figures/dist_bmi.png\
 figures/box_ap.png
	Rscript -e "rmarkdown::render('BIOS611_Final_Report_KyungjinSohn.Rmd', output_format='pdf_document')";