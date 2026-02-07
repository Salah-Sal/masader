FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# System deps
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    python3-pip \
    jq \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20 (needed for Claude Code)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code
RUN npm install -g @anthropic-ai/claude-code

# Install Python data tools
RUN pip3 install --no-cache-dir datasets huggingface-hub

# Create non-root user
RUN useradd -m -s /bin/bash assessor
RUN mkdir -p /input /output /home/assessor/.claude && chown -R assessor:assessor /input /output /home/assessor/.claude

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER assessor
WORKDIR /home/assessor

ENTRYPOINT ["entrypoint.sh", "claude"]
CMD ["-p"]
