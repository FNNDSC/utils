FROM docker.io/library/alpine:3.20.2

RUN --mount=type=cache,target=/var/cache/apk,sharing=locked apk add tar curl make parallel fd bash jq yq-go

RUN curl -sfL "https://github.com/FNNDSC/chrs/releases/download/v0.3.1/chrs-$(uname -m)-unknown-linux-musl-v0.3.1.tar.gz" \
    | tar xz -C /usr/local/bin

COPY --from=docker.io/peakcom/s5cmd:v2.2.2 --chmod=555 /s5cmd /usr/local/bin/s5cmd

CMD ["make"]
