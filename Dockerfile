# FROM gets a base image to create your image from. In this case we are getting a node base image from docker hub for our node app
# specify the node base image with your desired version node:<version> ( https://hub.docker.com/_/node )
FROM node:12

# Creating the working directory in the server and cd'ing into it
WORKDIR /app

# Copying over local package json file to the /app directory in the server enviroment (which we are already in)
COPY package*.json ./

# The RUN command will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the Dockerfile.
RUN npm install # This is RUN in shell form

# We have copied the the package.json and installed them because docker will attempt to CACHE LAYERS if nothing has changed
# That way we don't have to install node modules everytime we change something in the source code and re build the container

# Here we copy all of our local files to the working directory
COPY . .

# However notice that if you have run "npm install" locally you will have the node_modules copied over as well (which we don't want)
# Solution is to add a .dockerignore file and include "node_modules" just as you would in a .gitignore file

# Set the enviroment variable in the docker container to be passed into the node app which uses the variable for it's port
ENV PORT=8080

# Here we use the EXPOSE command to expose to containers port that it will listen on at runtime
EXPOSE 8080

# Tells the conatiner how to run the application (this command only appears once in a dockerfile)
# Starts a process to server the express app in this case
CMD ["npm", "start"]

# to build the docker image you can run: docker build -t some-tag-for-your-image
# where -t is the flag to add a tag to your image which is easier to remember than the image id
