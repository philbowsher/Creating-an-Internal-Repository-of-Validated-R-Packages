# ---------------------------------------------------
# run RSPM
# ---------------------------------------------------
mkdir -p ./rstudio-pm-demo/
docker run --privileged -it --rm --name=rstudio-pm -v $(pwd)/rstudio-pm-demo:/data/ -p 4242:4242 -e RSPM_LICENSE ghcr.io/rstudio/rstudio-package-manager:latest

# ---------------------------------------------------
# important!
# in another shell
# ---------------------------------------------------

docker exec -it rstudio-pm bash


# pull in cran state
rspm sync

# create a "source"
# a "source" is a collection of packages
# this is a "placeholder" / empty bucket for us to put packages in
rspm create source --name=validated --type=curated-cran

# look at the source created
rspm list sources

# it has no packages in it


# ---------------------------------------------------
# example with a few packages
# ---------------------------------------------------

rspm add --source=validated --include-suggests --csv-out example.csv --packages=tidyverse,tidymodels,gt,shiny,rmarkdown

# Created a file named example.csv that lists the packages that will be added by this action.
# To complete this operation, execute this command with the --commit and --snapshot=2022-05-18 flags.

more example.csv



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
/opt/R/4.0.2/bin/R -e 'install.packages(c("tidyverse","tidymodels","gt","shiny","rmarkdown"), repos = "http://ec2-3-144-73-13.us-east-2.compute.amazonaws.com/rspm/Validated/__linux__/bionic/latest")'

# root / system / all users
# sudo /opt/R/4.0.2/bin/R -e 'install.packages(c("tidyverse","tidymodels","gt","shiny","rmarkdown"), repos = "http://ec2-3-144-73-13.us-east-2.compute.amazonaws.com/rspm/Validated/__linux__/bionic/latest")'

