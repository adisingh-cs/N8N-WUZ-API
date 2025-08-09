FROM golang:1.23-alpine AS builder

# Install Git
RUN apk add --no-cache git

# Clone the WuzAPI repo
RUN git clone https://github.com/asternic/wuzapi.git /app

WORKDIR /app

# Build the Go app
RUN go build -o wuzapi .

# ----------------------------
FROM alpine:3.18

COPY --from=builder /app/wuzapi /usr/local/bin/wuzapi
COPY --from=builder /app/.env.sample /app/.env.sample

WORKDIR /app

ENV PORT=8080 \
    WUZAPI_ADMIN_PASS=lolstr7@LOL \
    WUZAPI_ADMIN_TOKEN=lolstr7@LOLTOKEN \
    WUZAPI_ADMIN_USER=admin \
    WUZAPI_API_URL=https://n8n-wuz-api.onrender.com

EXPOSE 8080

CMD ["wuzapi"]
