FROM pytorch/pytorch

ADD setup/ /tmp/

ARG username=leici
ARG password=98543021

RUN cd /tmp && \
  bash run_all.sh --username ${username} --password ${password} \
  --python2 0 --python3 0 \
  --nvim 0 --lvim 0 \
  --nvm 0 \
  --xray 0 \ 
  --none_root_conda 1 && \
  rm -r ./* 

USER ${username}
ENV TERM xterm-256color
WORKDIR /home/${username}

CMD ["zsh"]
