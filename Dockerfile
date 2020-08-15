FROM debian
MAINTAINER Alexander Reitzel
ADD script/docker/provision.sh /root/provision.sh
RUN chmod +x /root/provision.sh
RUN /root/provision.sh
ADD . /gnu-privacy-guard-tools
ENTRYPOINT ["/gnu-privacy-guard-tools/bin/gpgt"]
