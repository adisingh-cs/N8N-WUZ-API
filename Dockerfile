FROM golang:1.23-alpine AS builder

RUN apk add --no-cache git

# Clone official WuzAPI repo to get source and static files
RUN git clone https://github.com/asternic/wuzapi.git /app
WORKDIR /app

# Build the Go binary
RUN go build -o wuzapi .

FROM alpine:3.18

# Copy the binary
COPY --from=builder /app/wuzapi /usr/local/bin/wuzapi

# Copy the .env.sample (optional)
COPY --from=builder /app/.env.sample /app/.env.sample

# Copy static files to serve Swagger UI
COPY --from=builder /app/static /app/static

WORKDIR /app
EXPOSE 8080

CMD ["wuzapi"]
