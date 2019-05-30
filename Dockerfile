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
COPY --from=builder /app/build /usr/share/nginx/html
# this copies to where nginx needs the html to be
# don't need to explicitly run cmd, as nginx image does it