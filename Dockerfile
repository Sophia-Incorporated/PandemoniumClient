FROM debian:12

LABEL clientname="PandemoniumClient"

ENV DEBIAN_FRONTEND=noninteractive

COPY package*.json ./

FROM base AS init_builder
RUN npm install
COPY src/ src/
COPY angular.json tsconfig.json tsconfig.app.json ./
RUN npm run build

FROM base
COPY --from=init_builder /apps/server/dist/ ./server/dist/
COPY server/ ./server/
WORKDIR /apps/server/
RUN npm install
