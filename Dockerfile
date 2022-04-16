FROM ubuntu:21.10
LABEL maintainer="pandurx <internalfire5@live.com>"

#USER root

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
#RUN apt-get install -y tzdata

#export DEBIAN_FRONTEND=noninteractive
#RUN DEBIAN_FRONTEND=noninteractive TZ=America/New_York apt-get -y install tzdata


RUN apt-get -qq update && apt-get install -y \
build-essential \
libssl-dev \
libffi-dev \
python3-dev \
python3-pip \
libsasl2-dev \
libldap2-dev \
default-libmysqlclient-dev \
wget \
unzip \
lsof \
nano \
tar \
cron \
zip \
unzip \
bash

RUN pip install MarkupSafe==2.0.1

RUN pip install apache-superset --upgrade
RUN superset db upgrade

RUN superset fab create-admin \
--username admin \
--firstname admin \
--lastname admin \
--email admin@fab.com \
--password admin

RUN superset load_examples
RUN superset init

EXPOSE 8088
#CMD superset run -h 192.168.2.48 -p 8088
CMD superset run -p 8088 --with-threads --reload --debugger
#ENTRYPOINT [ "/superset-init.sh" ]
