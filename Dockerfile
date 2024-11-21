FROM node:23-alpine AS build-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build


FROM nginx:alpine AS production-stage

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build-stage /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


# FROM node:23-alpine AS build-stage

# WORKDIR /app/

# COPY package*.json .

# RUN npm install

# COPY . .

# FROM node:23-slim AS final-stage

# #WORKDIR /app/

# COPY --from=build-stage /app/ .

# EXPOSE 3000

# CMD ["npm","start"]
 
