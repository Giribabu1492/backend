FROM node:20.18.3-alpine3.21

RUN addgroup -S expense && adduser -S expense -G expense && \
    mkdir -p /opt/backend && \
    chown -R expense:expense /opt/backend

WORKDIR /opt/backend

ENV DB_HOST=mysql

COPY package*.json ./
RUN npm install

COPY *.js ./

USER expense

CMD ["node", "index.js"]