#syntax=docker/dockerfile:1

FROM ubuntu
RUN mkdir -p /home/app
RUN sudo apt update
RUN apt install curl -y \
apt install vim -y \

CMD ["bash", "-c"]
