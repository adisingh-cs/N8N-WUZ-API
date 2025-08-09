FROM node:18-alpine

# Install Wuzapi
RUN npm install -g wuzapi

# Create app directory
WORKDIR /app

# Expose the port
EXPOSE 8080

# Run Wuzapi
CMD ["wuzapi", "start", "--host", "0.0.0.0", "--port", "8080"]
