FROM ubuntu:jammy

RUN apt-get update \
    && apt-get install --yes --no-install-recommends monit \
    && apt clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY entrypoint /usr/bin/entrypoint

ENTRYPOINT ["entrypoint"]
CMD ["monit", "-I", "-d", "15"]
