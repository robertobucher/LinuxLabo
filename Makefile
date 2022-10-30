all: packages pysimcoder shv nuttx f7

# Install sudo
# /usr/sbin/addgroup <user> sudo
# Install real-time kernel and corresponding header files
#     linux-image-rt-amd64
#     linux-headers-rt-amd64
# Installe make

BINDIR = /usr/local/bin
CURDIR = $(shell pwd)
PYCTL = export PYSUPSICTRL=$(CURDIR)

export PYSUPSICTRL=$(shell pwd)

packages:
	sudo apt-get install \
		gcc \
		gfortran \
		git \
		cmake \
		binutils \
		emacs \
		python3 \
		python3-numpy \
		python3-scipy \
		python3-sympy \
		python3-matplotlib \
		python3-pip \
		jupyter-qtconsole \
		python3-lxml \
		python3-pyqtgraph \
		libopenblas-dev \
		liblapack-dev \
		libxml2-dev \
		libcomedi-dev \
		python3-pyqt5

pysimcoder:
	sudo rm -rf pysimCoder
	git clone https://github.com/robertobucher/pysimCoder
	cd pysimCoder; sudo make addfiles
	cd pysimCoder; sudo make modules
	cd pysimCoder; sudo make fmu
	cd pysimCoder; sudo make driver
	cd pysimCoder; sudo make link
	cd pysimCoder; make user; make alias

Shv:
	sudo rm -rf SHV
	mkdir -p SHV

	sudo apt-get install \
		qtbase5-dev \
		qt5-qmake \
		libqt5webkit5-dev \
		libqt5serialport5-dev \
		libqt5websockets5-dev \
		libqt5svg5-dev \
		liblua5.4-dev

	git clone https://github.com/silicon-heaven/shvapp SHV/shvapp
	git clone https://github.com/silicon-heaven/shvspy SHV/shvspy
	cd SHV/shvapp; git submodule update --init --recursive
	cd SHV/shvspy; git submodule update --init --recursive
	cd SHV/shvapp; mkdir build;cd build; cmake -DCMAKE_INSTALL_PREFIX=.. ..; make; make install
	cd SHV/shvspy; mkdir build;cd build; cmake -DCMAKE_INSTALL_PREFIX=.. ..; make; make install

nuttx:
	sudo apt-get install \
		tio \
		kconfig-frontends \
		openocd  \
		binutils-arm-none-eabi \
		gcc-arm-none-eabi

	sudo rm -rf NUTTX
	mkdir -p NUTTX
	git clone https://github.com/apache/incubator-nuttx.git NUTTX/nuttx
	git clone https://github.com/apache/incubator-nuttx-apps NUTTX/apps

f7:
	cd NUTTX/nuttx; make distclean
	cd NUTTX/nuttx; ./tools/configure.sh nucleo-144:f746-pysim; make; make export
	cd pysimCoder/CodeGen/nuttx; tar xvfz ../../../NUTTX/nuttx/nuttx-export-11.0.0.tar.gz; \
	mv nuttx-export-11.0.0 nuttx-export
