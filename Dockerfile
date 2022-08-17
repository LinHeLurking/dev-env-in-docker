FROM nvidia/cuda:11.4.0-cudnn8-devel-ubuntu20.04

ADD setup/ /tmp/

ARG username=
ARG password=

RUN cd /tmp && \
  bash run_all.sh --username ${username} --password ${password} \
  rm -r ./* 

USER ${username}
ENV TERM xterm-256color
WORKDIR /home/${username}

CMD ["bash"]
