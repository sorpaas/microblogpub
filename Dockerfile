FROM python:3.7

# Create the microblogpub user
ARG UID=6995
ARG GID=6995
RUN apt update && \
  echo "Etc/UTC" > /etc/localtime && \
  ln -s /opt/jemalloc/lib/* /usr/lib/ && \
  apt install -y whois wget && \
  addgroup --gid $GID microblogpub && \
  useradd -m -u $UID -g $GID -d /opt/microblogpub microblogpub && \
  echo "microblogpub:`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 24 | mkpasswd -s -m sha-256`" | chpasswd

COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
ADD . /app
ENV FLASK_APP=app.py

USER microblogpub
CMD ["./run.sh"]
