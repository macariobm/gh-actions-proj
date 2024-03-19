#syntax=docker/dockerfile:1

FROM python:alpine3.18

RUN useradd --create-home appdev
USER appdev
WORKDIR /app
RUN apk update && apk install --no-install-recommends vim curl git python3 -y \
&& rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip install -r requirements.txt 

EXPOSE 8080
CMD ["bash", "-c"]
