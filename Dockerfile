FROM python:3.9.2-slim-buster
RUN mkdir /bot && chmod 777 /bot
WORKDIR /bot
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -qq update && apt -qq install -y git wget pv jq python3-dev mediainfo
# Change repo 
RUN echo deb http://http.us.debian.org/debian/ testing non-free contrib main > /etc/apt/sources.list && \
    apt -qq update
# Install other dependencies
RUN apt-get install libcrypt1 -y
# Install AOM
RUN apt-get install libaom-dev -y
# Compile and install fresh ffmpeg from sources:
# See: https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
RUN apt-get -y install build-essential autoconf automake cmake libtool git checkinstall nasm yasm libass-dev libfreetype6-dev libsdl2-dev p11-kit libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo wget zlib1g-dev libchromaprint-dev frei0r-plugins-dev gnutls-dev ladspa-sdk libcaca-dev libcdio-paranoia-dev libcodec2-dev libfontconfig1-dev libfreetype6-dev libfribidi-dev libgme-dev libgsm1-dev libjack-dev libmodplug-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenjp2-7-dev libopenmpt-dev libopus-dev libpulse-dev librsvg2-dev librubberband-dev librtmp-dev libshine-dev libsmbclient-dev libsnappy-dev libsoxr-dev libspeex-dev libssh-dev libtesseract-dev libtheora-dev libtwolame-dev libv4l-dev libvo-amrwbenc-dev libvorbis-dev libvpx-dev libwavpack-dev libwebp-dev libx264-dev libx265-dev libxvidcore-dev libxml2-dev libzmq3-dev libzvbi-dev liblilv-dev libopenal-dev opencl-dev libjack-dev libavc1394-0 libavc1394-dev libiec61883-0 libiec61883-dev libbluray-dev libfdk-aac-dev libbs2b-dev libbs2b0 
RUN apt-get install build-essential curl tar libass-dev libtheora-dev libvorbis-dev libtool cmake automake autoconf -y && \
COPY . .
RUN pip3 install -r requirements.txt
CMD ["bash","run.sh"]
