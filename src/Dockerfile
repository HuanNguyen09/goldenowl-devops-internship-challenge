# Select base image node:16-alpine
FROM node:16-alpine

# Set user node
USER node

# Create directory /home/node/app
RUN mkdir /home/node/app

# Set working directory /home/node/app
WORKDIR /home/node/app

# Copy and change the owner and group all files from current directory to /home/node/app
COPY --chown=node:node . .

# Install all dependences for App
RUN npm install

# Expose port for App
EXPOSE 3000

# Run the command "npm start" every time run App
CMD ["npm", "start"]
