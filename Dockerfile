FROM node:16

# Install build dependencies
RUN apt-get update && apt-get install -y make gcc g++ python3

ENV NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn global add node-gyp
RUN yarn config set network-timeout 600000 -g && yarn install --production
ENV PATH=/app/node_modules/.bin:$PATH

COPY . .
RUN yarn build

EXPOSE 1337

# Run the application as root
CMD ["yarn", "start"]