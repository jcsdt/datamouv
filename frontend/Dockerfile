FROM node:8 as build

WORKDIR /opt/app

COPY package.json .
COPY package-lock.json .
COPY public/ ./public
COPY src/ ./src

RUN npm install --silent
RUN npm install react-scripts@1.1.1 -g --silent
RUN npm run build

FROM nginx:alpine
COPY --from=build /opt/app/build /usr/share/nginx/html

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
