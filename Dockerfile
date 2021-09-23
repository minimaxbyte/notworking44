FROM python:3.9.2-slim-buster
RUN mkdir /bot && chmod 777 /bot
WORKDIR /bot
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -qq update && apt -qq install -y git wget pv jq python3-dev ffmpeg mediainfo
./configure --enable-gpl --enable-nonfree --enable-libfdk-aac  && \
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
