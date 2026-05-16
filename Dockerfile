# Desarrollo Angular
FROM node:20-alpine AS builder

WORKDIR /app

# Copiar package files
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar proyecto
COPY . .

# Build producción Angular
RUN npm run build

# Etapa 2: Runtime
FROM nginxinc/nginx-unprivileged:1.27-alpine AS runtime

# Copiar build Angular
COPY --from=builder --chown=nginx:nginx /app/dist/casino-frontend/browser /usr/share/nginx/html

# Copiar configuración Nginx
COPY --chown=nginx:nginx nginx.conf /etc/nginx/templates/default.conf.template

# Usuario no root
USER nginx

# Puerto nginx-unprivileged
EXPOSE 8080