# Use Node 18 as the base image
FROM node:18

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
# We do this separately to cache the 'npm install' layer
COPY package.json package-lock.json* ./

# Install dependencies
# Using 'npm ci' is preferred for production/automated builds
RUN npm install

# Copy the rest of your application code
COPY . .

# Expose the port your app runs on
ENV PORT=8080
EXPOSE 8080

# Use the built-in non-root 'node' user for security
# Ensure the user has permissions to the app directory
RUN chown -R node:node /usr/src/app
USER node

# Define the command to start your application
CMD [ "node", "index.js" ]