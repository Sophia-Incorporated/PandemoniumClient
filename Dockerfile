FROM debian:12 AS base

LABEL clientname="PandemoniumClient"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm

# Install Angular CLI globally
RUN npm install -g @angular/cli

WORKDIR /app/PandemoniumClient

COPY package*.json ./

FROM base AS init_builder
RUN npm install
COPY src/ src/
COPY angular.json tsconfig.json tsconfig.app.json ./
RUN npm run build

# Expose any required ports (if necessary)
EXPOSE 4200

# Define the default command to run your application (if necessary)
CMD ["ng", "serve", "--host", "0.0.0.0"]
