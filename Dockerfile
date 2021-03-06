FROM python:3.8

WORKDIR /usr/src/app

RUN apt-get -yqq update && apt-get -yqq install ffmpeg awscli postgresql-client \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY start_bot ./start_bot

HEALTHCHECK CMD discordhealthcheck || exit 1

ENV s3_bucket makumistake

CMD ./start_bot
