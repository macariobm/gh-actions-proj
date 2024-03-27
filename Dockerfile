# syntax=docker/dockerfile:1

FROM ubuntu:latest

RUN apt update && apt upgrade --no-install-recommends vim curl git python3 python3-pip -y \
&& rm -rf /var/lib/apt/lists/*
RUN useradd --create-home appdev
USER appdev
WORKDIR /app
EXPOSE 8080
ENTRYPOINT ["/bin/ping"]
CMD ["localhost"]
