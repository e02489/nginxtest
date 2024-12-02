# Use the official NGINX image from the Docker Hub
FROM nginx:latest

# Copy your website's content (e.g., HTML files) into the NGINX container
# Assuming you have a local directory 'html/' containing your website files


# Optional: Copy a custom NGINX configuration file (default.conf)
# This will replace the default NGINX configuration file inside the container
# COPY ./nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for HTTP
EXPOSE 80

# Run NGINX in the foreground (this is the default in the base NGINX image)
CMD ["nginx", "-g", "daemon off;"]
