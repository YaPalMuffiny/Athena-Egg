# Base image: Debian with MongoDB pre-installed
FROM        --platform=$TARGETOS/$TARGETARCH mongo:7-jammy

# --- METADATA ---
# Customize these labels for your project
LABEL       org.opencontainers.image.authors="YaPalMuffiny"
LABEL       org.opencontainers.image.source="https://github.com/yapalmuffiny/athenabot-egg"
LABEL       org.opencontainers.image.description="Custom Docker image for my Athena Bot egg :D"

# --- SYSTEM SETUP & DEPENDENCIES ---
# Install essential packages for a Node.js bot
RUN         apt-get update && apt-get -y upgrade && \
            apt-get -y install --no-install-recommends \
                build-essential \
                ca-certificates \
                curl \
                git \
                gnupg \
                iproute2 \
                netcat \
                python3 \
                tini \
                tzdata && \
            apt-get clean && rm -rf /var/lib/apt/lists/*

# --- NODE.JS SETUP ---
# Install Node.js, npm, and yarn
RUN         curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
            echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
            curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
            echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
            apt-get update && \
            apt-get install -y nodejs yarn && \
            apt-get clean && rm -rf /var/lib/apt/lists/*

# Update npm to the latest version and install global packages if needed
RUN         npm install npm@latest -g && \
            npm install typescript ts-node --location=global

# --- ENVIRONMENT SETUP ---
# Set up a non-root user and working directory
RUN         useradd -m -d /home/container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

# --- STARTUP CONFIGURATION ---
# Set the default stop signal
STOPSIGNAL SIGINT

# Copy the entrypoint script and make it executable
COPY        entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

# Set the entrypoint to run the startup script
ENTRYPOINT  ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
