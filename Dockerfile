FROM node:22-alpine
WORKDIR /app
COPY package.json ./
COPY server.js index.html ./
ENV NODE_ENV=production
EXPOSE 8080
CMD ["npm", "start"]
