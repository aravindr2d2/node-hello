# Stage 1: Build the application
FROM node:14 AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Create the production image
FROM node:14-alpine AS production

WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app ./

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]
