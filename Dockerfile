# Desarrollo Angular
FROM node:20-alpine

WORKDIR /app

# Copiar package files
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Angular CLI 
RUN npm install -g @angular/cli

# Copiar proyecto
COPY . .

# Puerto Angular
EXPOSE 4200

# Ejecutar Angular
CMD ["ng", "serve", "--host", "0.0.0.0"]