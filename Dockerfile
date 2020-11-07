FROM python:3.7

# Create the microblogpub user
ARG UID=6995
ARG GID=6995
RUN addgroup --gid $GID microblogpub && \
  useradd -m -u $UID -g $GID -d /opt/microblogpub microblogpub

COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
ADD . /app
ENV FLASK_APP=app.py

USER microblogpub
CMD [ "gunicorn", "-b", "127.0.0.1:5005", "-w", "5", "-t", "600", "--log-level", "debug", "app:app" ]
