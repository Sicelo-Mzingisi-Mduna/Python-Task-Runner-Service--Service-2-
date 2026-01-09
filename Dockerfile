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
EXPOSE 5679

ENTRYPOINT ["tini", "--"]
CMD ["sh", "-c", "n8n task-runner start --type python --broker-host 0.0.0.0 --broker-port 5679 --auth-token \"$N8N_RUNNERS_AUTH_TOKEN\""]


