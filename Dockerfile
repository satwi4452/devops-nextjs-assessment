  FROM node:18-alpine as builder

WORKDIR /app

COPY package.json yarn.lock* ./
RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

FROM node:18-alpine as runner

WORKDIR /app

COPY --from=builder /app/package.json ./
RUN yarn install --frozen-lockfile --production=true

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/next.config.ts ./next.config.ts
COPY --from=builder /app/package.json ./package.json

ENV HOST 0.0.0.0

EXPOSE 3000

CMD ["yarn", "start"]