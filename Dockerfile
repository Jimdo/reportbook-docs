FROM alpine

ENV GOST_VERSION v0.1.1
ENV GOST_HASH 9b42b1ac521ea9287274eb5b38bb34e75dc6f855

ADD https://gobuilder.me/get/github.com/golang-id/gost/gost_v0.1.1_linux-386 /gost
RUN echo "${GOST_HASH}  gost" | sha1sum -c \
 && chmod +x gost

ADD ./site /site

EXPOSE 80

ENTRYPOINT ["/gost"]
CMD ["-port=80", "-path=/site"]