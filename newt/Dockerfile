# Wrap the official upstream image so version-tracking is one line.
# Docker resolves :latest to the correct arch automatically (the upstream image
# is multi-arch: amd64, aarch64, armv7). To pin/bump Newt, change the tag below.
FROM fosrl/newt:latest

# The upstream image is alpine-based. We only need bash + jq to read the add-on
# options (config.yaml -> /data/options.json). No bashio dependency.
RUN apk add --no-cache bash jq

COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Override the upstream entrypoint; our run.sh reads HA options then execs newt.
ENTRYPOINT []
CMD [ "/run.sh" ]
