FROM rocker/verse 
RUN Rscript --no-restore --no-save -e "update.packages(ask = FALSE)"
RUN Rscript --no-restore --no-save -e "install.packages('ggplot2')"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c('amsmath','iftex','pdftexcmds','infwarerr'))"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c('kvoptions','epstopdf-pkg'))"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c('etoolbox','xcolor','geometry'))"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c('booktabs','mdwtools'))"