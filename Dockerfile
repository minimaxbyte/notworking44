FROM python:3.9.2-slim-buster
RUN mkdir /bot && chmod 777 /bot
WORKDIR /bot
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -qq update && apt -qq install -y git wget pv jq python3-dev mediainfo
RUN apt -qq update && apt -qq install ffmpeg 4.4 && \
rm ffmpeg-4.4 && \
cd ffmpeg-4.4  && \
./configure --disable-static --disable-stripping --enable-avisynth --enable-chromaprint --enable-frei0r --enable-gmp --enable-gnutls --enable-gpl --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libdrm --enable-libfdk-aac --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libiec61883 --enable-libjack --enable-libmodplug --enable-libmp3lame --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librsvg --enable-librtmp --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtesseract --enable-libtheora --enable-libtwolame --enable-libv4l2 --enable-libvo-amrwbenc --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx264 --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-nonfree --enable-openal --enable-opencl --enable-opengl --enable-sdl2 --enable-shared --enable-small --enable-version3 --extra-version=0+deb11u2 --incdir=/usr/include/x86_64-linux-gnu --libdir=/usr/lib/x86_64-linux-gnu --toolchain=hardened  && \
make  && \
make -j8  && \
make install  && \
cp ffmpeg /usr/bin/  && \
make distclean  && \
hash -r  && \
ffmpeg 2>&1 | head -n1
COPY . .
RUN pip3 install -r requirements.txt
CMD ["bash","run.sh"]
