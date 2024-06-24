FROM debian:12.5-slim
ENTRYPOINT ["/app/run.sh"]

# Use default scanner version using environment variable
ARG SCANNER_VERSION

# Install java
RUN apt-get update \
    && apt-get install -y openjdk-17-jre \
    && apt-get clean

# Install git and clone sonar-scanner-azdo
RUN apt-get install -y wget unzip \
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
