# alsoRAN - Create your own version of CRAN

Another tool to build an R Archive Network.

Command line utility to build and maintain your own CRAN.

[Click here for official packaged releases](https://github.com/sellorm/alsoran/releases)

## CRAN - The Comprehensive R Archive Network

The real [CRAN](https://cran.r-project.org/) is amazing. Over 10 thousand additional packages for R published and available for free to the community.

The public CRAN system relies on a specific directory structure and the presence of PACKAGES files. These PACKAGES files contain a list of all the available packages in the repo, and are used by R's `install.packages()` function to check whether a package is available and what dependencies it might have.

## So why do we need alsoRAN?

alsoRAN is a tool the helps you build and maintain your own repo of R packages, but why is that needed? Well, if you're working inside a large organisation it's possible that you don't have access to the actual CRAN. Now, you could host a local mirror within the firewall, you could use a proxy solution that connects you to the real CRAN, or you could build and maintain your own!

Chances are you don't need access to all 10 thousand packages available on CRAN. Maybe your company has "blessed" a number of packages that are allowed to be used for business continuity purposes. Or maybe you just want to host a repo that contains just the packages that have been built internally. Either way, alsoRAN can help.

## Why isn't it an R Package? And what about things like drat and miniCRAN?

R packages are for R users and many people charged with the ongoing maintenance of these types of systems are **not** R users. The system administrator should not need to know anything about running R in order to maintain a CRAN-like repository. `alsoran` therefore provides a familiar command line interface in order to fit more comfortably into the sys-admin/DevOps ecosystem.

## Usage

```
usage: ./src/usr/bin/alsoran [--] [--help] [--opts OPTS] [--repo REPO] [--file FILE] command

A tool to create your own R package repo like CRAN

positional arguments:
  command			One of 'init', 'add', 'update', 'serve' or 'version'

flags:
  -h, --help			show this help message and exit

optional arguments:
  -x, --opts OPTS			RDS file containing argument values
  -r, --repo REPO			CRAN repo directory path [default: .]
  -f, --file FILE			CRAN repo directory path
```

So to create a new alsoRAN repo in the current directory:

```
mkdir local-cran
cd local-cran
alsoran init
```

Or to initialise a new repo in a different directory.

```
alsoran init -r /path/to/repo
```

You can copy source package files into the correct location in the repo with:

```
alsoran add -f /path/to/package.tar.csv -r /path/to/repo
```

This will also update the PACKAGES files.

Alternatively, you can copy the source packages in by hand and then call the following to updates the PACKAGES files:

```
alsoran update -r /path/to/repo
```

alsoRAN aso features a built in server for serving the repo over the network.

This can be started using:

```
alsoran serve -r /path/to/repo
```

Please be aware that 'alsoran serve' just serves the specified directory. If you run this in the wrong place you could end up serving files that you do not intend to. Use with caution!

## Publishing your alsoRAN repo

The directory structure used by alsoRAN is easy to publish on a network such as your organisations internal network, using apache or nginx.

## Installing packages from an alsoRAN repo

Installing packages from your custom alsoRAN repo is really simple for end users.

```
install.packages("PackageName", repos="https://yourLocalCranURL")
```

## Advanced Usage

On linux based systems, it is possible to watch for activity on a directory tree, such as the creation of a new file in that tree, and then use that event to trigger a script. We can leverage this system to watch for changes to our alsoRAN repo, and rebuild the PACKAGES files each time there's a change.

To do this we need to install `inotify-tools`.

on Ubuntu Linux:

```
sudo apt install -y inotify-tools
```

On CentOS/RedHat:

```
sudo yum install -y inotify-tools
```

Then modify and run the following script.

```
#!/usr/bin/env bash
while true
  do
    inotifywait -e create,delete -r /path/to/your/repo && \
      alsoran update -r /path/to/your/repo
  done
```

There are monitoring and daemonisation flags for `inotifywait` ('-m' and '-d' respectively) but they just print messages out to the console and don't trigger an action.

## Building RPM and deb packages

Run the following to build with docker:

```
build docker all
```
