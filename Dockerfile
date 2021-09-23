FROM python:3.9.2-slim-buster
RUN mkdir /bot && chmod 777 /bot
WORKDIR /bot
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -qq update && apt -qq install -y git wget pv jq python3-dev mediainfo
RUN apt -qq update && apt -qq install ffmpeg 4.4
cd ffmpeg
./configure --enable-libfdk-aac --enable-gpl --enable-version3 --enable-nonfree --enable-w32threads --enable-memalign-hack
make -j4
COPY . .
RUN pip3 install -r requirements.txt
CMD ["bash","run.sh"]
