FROM resin/rpi-raspbian
FROM python:3.7

RUN apt-get update

RUN apt-get install -y alsa-utils build-essential
RUN apt-get install -y libblas-dev liblapack-dev gfortran build-essential llvm python3-pip python3-scipy
WORKDIR /home/pi/github/kidcry

RUN pip3 install llvmlite==0.28.0
RUN pip3 install numpy
RUN pip3 install numba==0.42.1
RUN pip3 install librosa==0.4.3
RUN pip3 install pandas
RUN pip3 install sklearn
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553
RUN apt-get install -y python-dill
#RUN pip install pickle
RUN pip3 install simplejson

RUN pip3 install pydub
#RUN apt-get install python-numpy python-librosa
RUN apt-get install -y ffmpeg

ADD http://ftp.osuosl.org/pub/blfs/conglomeration/alsa-utils/alsa-utils-1.1.3.tar.bz2 /alsa/alsa-utils-1.1.3.tar.bz2
#ADD ftp://ftp.alsa-project.org/pub/utils/alsa-utils-1.1.3.tar.bz2 /alsa/alsa.tar.bz2
WORKDIR /alsa
RUN tar xvjf alsa-utils-1.1.3.tar.bz2
WORKDIR /alsa/alsa-utils-1.1.3
RUN apt-get -y install libncursesw5-dev libasound2-dev
RUN ./configure --disable-alsaconf --disable-bat --disable-xmlto --with-curses=ncursesw
RUN make
RUN make install

COPY ./baby_cry_detection/ ./baby_cry_detection/
RUN mkdir ./output
RUN mkdir ./recording
RUN mkdir ./output/model
RUN mkdir ./output/dataset
RUN mkdir ./output/prediction
