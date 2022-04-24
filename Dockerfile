FROM ubuntu:20.04

ADD setup/ tmp/

RUN cd /tmp && \
  bash run_all.sh --username dev --password 123456 && \
  rm -r ./*

USER dev 
ENV TERM xterm-256color
WORKDIR /home/dev

CMD ["zsh"]
