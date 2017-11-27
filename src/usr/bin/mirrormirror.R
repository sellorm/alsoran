#!/usr/bin/env Rscript --vanilla --no-save

# set root cran repo name
cran_mirror <- "https://cran.microsoft.com/snapshot/2017-10-15/"

# Check the dl directory
if (!dir.exists("./dl/src")){
  dir.create("./dl/src", recursive = TRUE)
}
if (!dir.exists("./dl/winbin")){
  dir.create("./dl/winbin", recursive = TRUE)
}

# read in the list of packages to be downloaded
pkgs <- readLines("./r-pkgs.txt")

# figure out the dependencies of the required packages
pkg_deps <- tools::package_dependencies(pkgs, recursive = TRUE)

# combine the two lists and flatten
pkgs_all <- unlist(c(pkgs, pkg_deps))

# remove duplicates
pkgs_unique <- unique(pkgs_all)

# strip packages that are part of base
pkgs_base <- installed.packages(priority= "base")[,"Package"]
pkgs_to_download <- setdiff(pkgs_unique, pkgs_base)

# Check what will be downloaded
pkgs_to_download
setNames(object = pkgs_to_download, pkgs_to_download)

# check against the available packages from the server
pkgs_available <- available.packages(repos=cran_mirror)[,"Package"]
pkg_check_result <- pkgs_to_download %in% pkgs_available
setNames(pkg_check_result, pkgs_to_download)
if ( FALSE %in% pkg_check_result){
  cat("Error in package name\n")
  if (interactive()){
    stop("Problem with package name")
  } else {}
    q('no', 1)
}


# download them all
# starting with source
download.packages(pkgs_to_download, destdir = "./dl/src", type = "source", repos = cran_mirror)

# then windows
download.packages(pkgs_to_download, destdir = "./dl/winbin", type = "win.binary", repos = cran_mirror)
