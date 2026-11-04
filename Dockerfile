FROM node:24-alpine AS dependencies

WORKDIR /app

COPY app/package*.json ./
RUN npm ci --omit=dev


FROM node:24-alpine

WORKDIR /app

RUN rm -rf /usr/local/lib/node_modules/npm \
    /usr/local/bin/npm \
    /usr/local/bin/npx

COPY --from=dependencies /app/node_modules ./node_modules

COPY app/ ./

EXPOSE 3000

CMD ["node", "server.js"]
