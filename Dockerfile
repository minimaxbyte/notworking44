FROM python:3.9.2-slim-buster
RUN mkdir /bot && chmod 777 /bot
WORKDIR /bot
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -qq update && apt -qq install -y git wget pv jq python3-dev ffmpeg mediainfo
RUN apt-get install libfdk-aac-dev
RUN apt-get install libmp3lame-dev
RUN apt-get install yasm
COPY . .
RUN pip3 install -r requirements.txt
CMD ["bash","run.sh"]
