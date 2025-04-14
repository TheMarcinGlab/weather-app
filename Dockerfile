# Etap 1: Build z minimalną sensowną liczbą warstw
FROM node:20-alpine AS builder

LABEL org.opencontainers.image.authors="Marcin Głąb (https://github.com/TheMarcinGlab)"

WORKDIR /app

COPY *.json ./
RUN npm ci --omit=dev

COPY . .

# Etap 2: Runtime, używam użytkownika z mniejszymi uprawnieniami niż root
FROM node:20-alpine

ARG VERSION=1.0.0

LABEL org.opencontainers.image.title="weather-app" \
      org.opencontainers.image.description="Zaliczenie laboratorium: Programowanie aplikacji w chmurze obliczeniowej" \
      org.opencontainers.image.authors="Marcin Głąb (https://github.com/TheMarcinGlab)" \
      org.opencontainers.image.source="https://github.com/TheMarcinGlab/weather-app" \
      org.opencontainers.image.version=$VERSION

ENV NODE_ENV=production

# Tworzenie użytkownika z mniejszymi uprawnieniami niż root ( nie-root )
RUN addgroup -S MarcinGlab && adduser -S MarcinGlab -G MarcinGlab

# Instalacja curl, który jest wymagany do healthcheck
RUN apk add --no-cache curl

WORKDIR /app

COPY --from=builder /app /app

USER MarcinGlab

# Healthcheck do monitorowania działania aplikacji
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl --fail --silent http://localhost:3000/ || exit 1

EXPOSE 3000
CMD ["node", "bin/www"]
