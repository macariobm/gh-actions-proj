#syntax=docker/dockerfile:1

FROM ubuntu
RUN sudo apt update && apt install vim curl git -y
RUN mkdir -p /home/app
CMD ["bash", "-c"]
