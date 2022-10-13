# Install the Labo PC

## Basic Installation

The first step is the installation of a Linux distribution. Usually I prefer a Debian distro (stable or testing).

It is possible to download a net iso from the Debian webpage and put it on a USB stick (using for axample "dd")

At the end of the installation I usually choose in addition to the proposed software the XFCE4 window manager and the SSH-Server option.

After reboot of the PC we have to perform the following tasks:

```
$ su   (+root password)
$ apt-get install sudo
$ apt-get install linux-image-rt-amd64
$ apt-get install linux-headers-rt-amd64
$ apt-get install make
$ /usr/bin/addgroup <user> sudo
$ reboot
```

Now it is possible to install all the additional packages using the provided Makefile

## Install the additional files for Python and pysimCoder

**Attention:** Some operations require the user password.

```
$ mkdir Develop
$ cd Develop
$ make packages
```

## Install pysimCoder

```
$ make pysimcoder
```

## Install SHV

```
$ make Shv
```

The next step is to compile the Linux files with the SHV add-ons

```
$ cd pysimCoder/CodeGen/LinuxRT/devices
$ make SHV=1
```

## Install NuttX and configure the files for pysimCoder and the nucleo-F746ZG board

```
$ make nuttx
$ make f7
```

The last command creates a tar.gz file in the NUTTX/nuttx folder.

```
$ cd pysimCoder/CodeGen/nuttx
$ tar xvfz ~/Develop/NUTTX(nuttx/nuttx-export-0.0.0.tar.gz
$ mv nuttx-export-0.0.0 nuttx-export
$ cd devices
$ make SHV=1
```






