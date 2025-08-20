FROM ubuntu:rolling

COPY binaries/* /usr/bin

RUN <<EOF
useradd -m saprouter
apt update
apt install -y iputils-ping curl dnsutils
apt autoremove -y 
apt autoclean
rm -rf /var/lib/apt/lists/*
EOF

USER saprouter

WORKDIR /home/saprouter
COPY saprouttab /home/saprouter/saprouttab
COPY startrouter /home/saprouter/startrouter
EXPOSE 3299
CMD ./startrouter