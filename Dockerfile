FROM node:18

# Install git so we can clone
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Clone Wuzapi source
RUN git clone https://github.com/adiwajshing/wuzapi.git /app
WORKDIR /app

# Install dependencies
RUN npm install

# Set environment variables
ENV WUZAPI_ADMIN_USER=admin
ENV WUZAPI_ADMIN_PASS=lolstr7@LOL
ENV PORT=8080

EXPOSE 8080

CMD ["npm", "start"]
