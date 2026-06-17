# Container image that runs your code
FROM alpine:3.24.1
ENV QBEE_CLI_VERSION="v1.2026.26"
ENV QBEE_CLI_CHECKSUM="5ebef67de8bedf9752366c4735fa06c5accb901ed9be01443295dadb576fef39"

ADD https://github.com/qbee-io/qbee-cli/releases/download/${QBEE_CLI_VERSION}/qbee-cli_linux_amd64.tar.gz /tmp/qbee-cli_linux_amd64.tar.gz

RUN echo "${QBEE_CLI_CHECKSUM} /tmp/qbee-cli_linux_amd64.tar.gz" | sha256sum -c - && \
    tar -xzf /tmp/qbee-cli_linux_amd64.tar.gz -C /usr/local/bin/ && \
    rm /tmp/qbee-cli_linux_amd64.tar.gz && \
    chmod +x /usr/local/bin/qbee-cli

COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["sh", "/entrypoint.sh"]
