# Use NodeJS base image
FROM node:13.14 as base_node

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

# Install dependencies
#RUN npm install
RUN npm ci --only=production

ENV POSTGRES_USERNAME {$POSTGRES_USERNAME}
ENV POSTGRES_PASSWORD {$POSTGRES_PASSWORD}
ENV POSTGRES_DB {$POSTGRES_DB}
ENV POSTGRES_HOST {$POSTGRES_HOST}
ENV AWS_REGION {$AWS_REGION}
ENV AWS_PROFILE {$AWS_PROFILE}
ENV AWS_BUCKET {$AWS_BUCKET}
ENV URL {$URL}
ENV JWT_SECRET {$JWT_SECRET}

# Copy app source
COPY ./www .

# Bind the port that the image will run on
EXPOSE 8080

# Define the Docker image's behavior at runtime
CMD ["node", "server.js"]