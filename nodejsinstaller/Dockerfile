# Use a slim, secure, and up-to-date base image
FROM        --platform=$TARGETOS/$TARGETARCH node:22-bookworm-slim

# --- METADATA ---
# Update these labels for your project
LABEL       org.opencontainers.image.authors="YaPalMuffiny"
LABEL       org.opencontainers.image.source="https://github.com/yapalmuffiny/athena-egg"
LABEL       org.opencontainers.image.description="Node.js Installer"

# --- SYSTEM SETUP & DEPENDENCIES ---
# Combine all apt-get commands into a single RUN layer to reduce image size.
# Packages are sorted alphabetically for readability.
RUN         apt-get update && apt-get -y upgrade && \
            apt-get -y install --no-install-recommends \
                autoconf \
                automake \
                build-essential \
                ca-certificates \
                chromium \
                curl \
                dnsutils \
                ffmpeg \
                file \
                fonts-liberation \
                g++ \
                gcc \
                git \
                git-lfs \
                gnupg2 \
                iproute2 \
                iputils-ping \
                jq \
                libasound2 \
                libatk-bridge2.0-0 \
                libatk1.0-0 \
                libc6 \
                libcairo2 \
                libcups2 \
                libdbus-1-3 \
                libexpat1 \
                libfontconfig1 \
                libgbm1 \
                libgcc1 \
                libglib2.0-0 \
                libgtk-3-0 \
                libnspr4 \
                libnss3 \
                libpango-1.0-0 \
                libpangocairo-1.0-0 \
                libsqlite3-dev \
                libstdc++6 \
                libtool \
                libx11-6 \
                libx11-xcb1 \
                libxcb1 \
                libxcomposite1 \
                libxcursor1 \
                libxdamage1 \
                libxext6 \
                libxfixes3 \
                libxi6 \
                libxrandr2 \
                libxrender1 \
                libxss1 \
                libxtst6 \
                lsb-release \
                make \
                python3 \
                python3-dev \
                sqlite3 \
                tzdata \
                unzip \
                wget \
                xdg-utils \
                zip \
            # Clean up apt cache to save space
            && rm -rf /var/lib/apt/lists/*

# --- NODE.JS & YARN SETUP ---
# Combine npm and yarn global installs into a single layer
RUN         npm install npm@latest -g && \
            npm install tsc typescript ts-node @types/node --location=global && \
            yarn global add itchio-downloader

# --- USER & DIRECTORY SETUP ---
# Standard setup for Pterodactyl eggs
RUN         useradd -m -d /home/container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

# --- STARTUP CONFIGURATION ---
COPY        --chown=container:container entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT  ["/entrypoint.sh"]
