FROM golang:1.21-alpine AS builder

# Install Git
RUN apk add --no-cache git

# Clone the WuzAPI repo
RUN git clone https://github.com/asternic/wuzapi.git /app

WORKDIR /app

# Build the Go app
RUN go build -o wuzapi .

FROM alpine:3.18

# Copy the binary
COPY --from=builder /app/wuzapi /usr/local/bin/wuzapi

# Include optional .env sample if needed
COPY --from=builder /app/.env.sample /app/.env.sample

WORKDIR /app

# Set environment variables (customize as needed)
ENV WUZAPI_ADMIN_TOKEN=admin-token-here \
    TZ=UTC \
    PORT=8080

EXPOSE 8080

CMD ["wuzapi"]
