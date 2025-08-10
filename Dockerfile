# Build stage
FROM golang:1.23-alpine AS builder

RUN apk add --no-cache git

RUN git clone https://github.com/asternic/wuzapi.git /app
WORKDIR /app

RUN go build -o wuzapi .

# Final stage
FROM alpine:3.18

RUN apk add --no-cache busybox-extras

COPY --from=builder /app/wuzapi /usr/local/bin/wuzapi
COPY --from=builder /app/.env.sample /app/.env.sample
COPY --from=builder /app/static /app/static

WORKDIR /app
EXPOSE 8080 8081

CMD sh -c "wuzapi & httpd -f -p 8081 -h /app/static/api"
