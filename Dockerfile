FROM golang:1.13-alpine as BUILDER

WORKDIR /build
RUN apk add git
RUN git clone --branch 2.6.11 https://github.com/adnanh/webhook
WORKDIR /build/webhook

# because webhook doesn't yet have go-module support
RUN go mod init github.com/adannh/webhook

RUN go build .

FROM puppet/r10k:3.3.3

COPY --from=BUILDER /build/webhook/webhook /usr/local/bin/webhook

WORKDIR /webhook
ADD entrypoint.sh hooks.json run-r10k.sh /webhook/
ENTRYPOINT [ "/webhook/entrypoint.sh" ]
CMD [ ]
