FROM node:20-bookworm-slim

USER root

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    tini \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g n8n@latest

WORKDIR /home/node
USER node

ENV NODE_ENV=production
EXPOSE 5679  # broker port

ENTRYPOINT ["tini", "--"]
CMD ["n8n", "task-runner", "python", "--broker-host", "0.0.0.0", "--broker-port", "5679", "--auth-token", "super-secret-token"]
