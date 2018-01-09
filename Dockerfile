FROM alpine

ENV GOST_VERSION 0.1.1
ENV GOST_HASH f4d0b42294889e14f6b03d76c7e8cc42a4ce9dd8

ADD https://github.com/golang-id/gost/releases/download/v${GOST_VERSION}/gost_${GOST_VERSION}-snapshot_linux_amd64.tar.gz /gost_${GOST_VERSION}-snapshot_linux_amd64.tar.gz
RUN tar xvfz /gost_${GOST_VERSION}-snapshot_linux_amd64.tar.gz -C /

RUN echo "${GOST_HASH}  /gost" | sha1sum -c

ADD ./site /site

EXPOSE 80

ENTRYPOINT ["/gost"]
CMD ["-port=80", "-path=/site"]