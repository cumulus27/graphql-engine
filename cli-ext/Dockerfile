FROM node:22-bookworm

WORKDIR /app

COPY . .

RUN npm install

RUN npm install -g pkg

RUN npm run build

CMD ["cp", "bin/cli-ext-linux-arm64", "/output/cli-ext-linux-arm64"]