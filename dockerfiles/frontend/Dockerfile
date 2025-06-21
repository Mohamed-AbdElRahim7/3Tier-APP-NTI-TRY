FROM node:18 AS build

WORKDIR /app
COPY . .

# ✅ أضف السطر ده قبل build
ENV NODE_OPTIONS=--openssl-legacy-provider

RUN npm install && npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
