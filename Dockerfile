FROM debian:jessie
RUN apt-get update && \
    apt-get -y install wget zsh-common zsh && \
    wget "http://ftp.jp.debian.org/debian/pool/main/z/zsh/zsh-static_5.0.7-5_amd64.deb" && \
    dpkg -i zsh-static_5.0.7-5_amd64.deb

RUN echo '#!/bin/sh\n\
if mountpoint -q /target; then\n\
    echo "Installing zsh to /target"\n\
    cp /bin/zsh5-static /target/zsh\n\
else\n\
    echo "/target is not a mountpoint."\n\
    echo "- re-run this with -v /opt/bin:/target"\n\
fi\n\
' > /install.sh && \
    chmod +x /install.sh

CMD /install.sh
