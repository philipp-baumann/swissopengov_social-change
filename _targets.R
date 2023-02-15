library("targets")
library("tarchetypes")
library("R.utils")

sourceDirectory("R")

source("packages.R")

tar_option_set(format = "qs")
tar_option_set(debug = "spc_tbl")

## Define the pipeline =========================================================

## Each target list defines distinct but related task sets of
## the pipeline. Each list includes targets, R objects, and a recipe
## how to build them using functions (either low-level one in package
## or a workflow-specific functions contained in .R files in the
## folder ./R)

pip_fetch_pxweb <- list(
  tar_target(
    dat_in_social_welfare,
    get_pxweb_social_welfare()
  ),
  #tar_target(
  #  meta_social_welfare,
  #  get_pxweb_meta_social_welfare()
  #),
  tar_target(
    meta_pxweb_social_welfare,
    get_pxweb_pkg_meta()
  )
)

list(
  pip_fetch_pxweb
)