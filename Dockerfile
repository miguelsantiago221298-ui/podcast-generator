FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install Python, venv support, pip, git and ca-certificates for HTTPS
RUN apt-get update && apt-get install -y \
  python3 \
  python3-venv \
  python3-pip \
  git \
  ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Create a virtual environment and ensure the venv's bin is first in PATH
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip in the venv and install runtime requirements into the venv
RUN pip install --upgrade pip && \
    pip install PyYAML

# Copy application files
COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# Ensure entrypoint is executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]