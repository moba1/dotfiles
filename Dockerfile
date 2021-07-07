FROM fedora:34

RUN dnf install -y sudo curl golang glibc-locale-source glibc-langpack-ja

RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

RUN useradd -ms /bin/bash moba \
  && echo "%moba    ALL=(ALL)    NOPASSWD:    ALL" >> /etc/sudoers.d/moba
USER moba
VOLUME /home/moba/.setup
WORKDIR /home/moba/.setup
ENTRYPOINT ["/bin/bash"]
