# Build Phase

FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build 
# use RUN instead of CMD

# Run Phase

FROM nginx

EXPOSE 80
# supposed to be for us to read
# AWS Elastic Beanstalk will look at this and use as port that gets mapped for incoming traffic

COPY --from=builder /app/build /usr/share/nginx/html
# this copies to where nginx needs the html to be
# don't need to explicitly run cmd, as nginx image does it