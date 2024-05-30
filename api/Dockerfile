FROM node:lts
WORKDIR /app
COPY ./package*.json /app/
RUN npm install
EXPOSE 3001
CMD ["npm", "start"]