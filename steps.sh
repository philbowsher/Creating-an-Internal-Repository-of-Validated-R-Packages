# ---------------------------------------------------
# run RSPM in Docker
# ---------------------------------------------------
# mkdir -p ./rstudio-pm-demo/
# docker run --privileged -it --rm --name=rstudio-pm -v $(pwd)/rstudio-pm-demo:/data/ -p 4242:4242 -e RSPM_LICENSE ghcr.io/rstudio/rstudio-package-manager:latest

# important! in another shell
# docker exec -it rstudio-pm bash

# to install on linux, as of 2022-05-01
# sudo apt update
# sudo apt install gdebi-core
# wget https://cdn.rstudio.com/package-manager/ubuntu/amd64/rstudio-pm_2022.04.0-7_amd64.deb
# sudo gdebi rstudio-pm_2022.04.0-7_amd64.deb

# ---------------------------------------------------
# configure RSPM
# ---------------------------------------------------

# check groups

id

# pull in cran state
# We do this for workshop attendees now behind the scenes
# rspm sync

# create a "source"
# a "source" is a collection of packages
# this is a "placeholder" / empty bucket for us to put packages in
rspm create source --name=validated --type=curated-cran

# look at the source created
# note Curated CRAN date
rspm list sources

# it has no packages in it

# ---------------------------------------------------
# example with a few packages
# ---------------------------------------------------

rspm add --source=validated --include-suggests --csv-out example.csv --packages=tidyverse,tidymodels,gt,shiny,rmarkdown

# Created a file named example.csv that lists the packages that will be added by this action.
# To complete this operation, execute this command with the --commit and --snapshot=2022-05-18 flags.

more example.csv

# To complete run something like this, note date, this usually day of workshop
# rspm add --source=validated --include-suggests --csv-out example.csv --packages=tidyverse,tidymodels,gt,shiny,rmarkdown --commit --snapshot=2023-11-13

# ---------------------------------------------------
# example with many packages
# ---------------------------------------------------

# rspm add --source=validated --include-suggests --csv-out example.csv --packages=tidyverse,tidymodels,gt,lintr,xml2,pak,usethis,processx,httr,httr2,styler,desc,pillar,rlang,downlit,devtools,rprojroot,roxygen2,here,testthat,cachem,tidyselect,cpp11,cli,vctrs,pkgdown,R6,waldo,ps,remotes,pkgdepends,gh,scales,ymlthis,filelock,callr,withr,gert,fs,crayon,gert,backports,pkgcache,whoami,zip,sessioninfo,pkgbuild,brio,progress,pkgload,bench,gitcreds,rcmdcheck,commonmark,later,lifecycle,covr,gargle,clock,memoise,conflicted,fastmap,meltr,jose,rematch2,lobstr

# Created a file named example.csv that lists the packages that will be added by this action.
# To complete this operation, execute this command with the --commit and --snapshot=2022-05-18 flags.

# ---------------------------------------------------
# NEXT STEPS:
# create repo, change snapshot, read docs, etc.
# ---------------------------------------------------

rspm create repo --name=Validated

rspm subscribe --repo=Validated --source=validated

# now packages are exposed in the UI


# ---------------------------------------------------
# Install the packages into the user/system library
# ---------------------------------------------------

# user
# you will need to update the link below with the new link of the workshop Validated PPM repo. Be sure to grab link for Linux OS used, like jammy
# Make sure you update R version to latest in PTT

# /opt/R/4.0.2/bin/R -e 'install.packages(c("tidyverse","tidymodels","gt","shiny","rmarkdown"), repos = "http://ec2-3-144-73-13.us-east-2.compute.amazonaws.com/rspm/Validated/__linux__/bionic/latest")'

# root won't work in PTT workshop space
# root / system / all users
# sudo /opt/R/4.0.2/bin/R -e 'install.packages(c("tidyverse","tidymodels","gt","shiny","rmarkdown"), repos = "http://ec2-3-144-73-13.us-east-2.compute.amazonaws.com/rspm/Validated/__linux__/bionic/latest")'

# ---------------------------------------------------
# Set the system "default repo"
# ---------------------------------------------------

# Append to the Rprofile.site
# 
# export R_HOME=/opt/R/4.0.2
# echo 'options("repos" = c("RSPM" = "https://colorado.rstudio.com/rspm/classroom/__linux__/bionic/5478112"))' >> $R_HOME/lib/R/etc/Rprofile.site

cat /opt/R/4.0.2/lib/R/etc/Rprofile.site

# to block access to anything else - must use network restrictions
# i.e. block outbound access to GitHub, CRAN, etc. with a firewall
#
# IT is familiar with these types of restrictions
