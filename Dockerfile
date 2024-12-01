# Use an official Node.js image as the base
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Use a lightweight server to serve the React build
FROM nginx:alpine
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80 for the server
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
