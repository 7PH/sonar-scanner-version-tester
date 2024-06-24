FROM debian:12.5-slim
ENTRYPOINT ["/app/run.sh"]

# Use default scanner version using environment variable
ARG SCANNER_VERSION

# User to use within the container (should match the host)
ARG DOCKER_USER
ARG DOCKER_UID
ARG DOCKER_GID

# Install java
RUN apt-get update \
    && apt-get install -y openjdk-17-jre \
    && apt-get clean

RUN apt-get install -y wget unzip sudo  \
    && apt-get clean

WORKDIR /opt

# Install sonar-scanner-cli
RUN wget -q "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SCANNER_VERSION-linux.zip" \
    && unzip "sonar-scanner-cli-$SCANNER_VERSION-linux.zip" \
    && rm "sonar-scanner-cli-$SCANNER_VERSION-linux.zip"

# Add sonar-scanner-cli to PATH
ENV PATH="/opt/sonar-scanner-$SCANNER_VERSION-linux/bin:${PATH}"

# Create run file
COPY *.sh *.properties /app/
RUN chmod +x /app/*.sh

WORKDIR /app

# Setup user
RUN groupadd -g "$DOCKER_GID" "$DOCKER_USER" && \
    useradd -u "$DOCKER_UID" -g "$DOCKER_USER" -m "$DOCKER_USER" && \
    chown -R "$DOCKER_USER:$DOCKER_USER" .

# Allow the user to use sudo without a password
RUN echo "$DOCKER_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$DOCKER_USER

USER $DOCKER_USER
