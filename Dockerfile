FROM node:18-alpine
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev git > /dev/null 2>&1

ENV NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn global add node-gyp
RUN yarn config set network-timeout 600000 -g && yarn install --production
ENV PATH=/app/node_modules/.bin:$PATH

COPY . .
RUN yarn build

RUN chown -R node:node /app
USER node
EXPOSE 1337

# Run the run.sh script as root
CMD ["yarn", "start"]