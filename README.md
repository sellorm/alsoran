# alsoRAN - Create your own version of CRAN

Command line utility to build and maintain your own CRAN.

## CRAN - The Comprehensive R Archive Network

The real [CRAN](https://cran.r-project.org/) is amazing. Over 10 thousand additional packages for R published and available for free to the community.

## So why do we need alsoRAN?

alsoRAN is a tool the helps you build and maintain your own repo of R packages, but why is that needed? Well, if you're working inside a large organisation it's possible that you don't have access to the actual CRAN. Now, you could host a local mirror within the firewall, you could use a proxy solution that connects you to the real CRAN, or you could build and maintain your own!

Chances are you don't need access to all 10 thousand packages available on CRAN. Maybe your company has "blessed" a number of packages that are allowed to be used for business continuity purposes. Or maybe you just want to host a repo that contains just the packages that have been built internally. Either way, alsoRAN can help.

## Why isn't it an R Package? And what about things like miniCRAN?

R packages are for R users and many people charged with the ongoing maintenance of these types of systems are not R users. The system administrator should not need to know anything about running R in order to maintain a CRAN-like repository. `alsoran` therefore provides a familiar command line interface in order to fit more comfortably into the sys-admin/DevOps ecosystem.