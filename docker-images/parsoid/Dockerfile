FROM node:6.14.4-alpine

RUN apk add --no-cache python git tar bash make
ENV PARSOID_HOME=/var/lib/parsoid \
    PARSOID_USER=parsoid

ENV PARSOID_VERSION=v0.10.0

RUN set -x; \
    adduser -D -S -s /bin/bash $PARSOID_USER \
    && mkdir -p PARSOID_HOME \
    && git clone \
        --branch ${PARSOID_VERSION} \
        --single-branch \
        --depth 1 \
        --quiet \
        https://github.com/wikimedia/parsoid \
        $PARSOID_HOME \
    && cd $PARSOID_HOME \
    && npm install

COPY run-parsoid.sh /run-parsoid.sh
RUN chmod -v +x /run-parsoid.sh

expose 8000
CMD ["/run-parsoid.sh"]
