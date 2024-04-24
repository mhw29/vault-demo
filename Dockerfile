# Use a base image with the desired OS and version
FROM ubuntu:latest

ENV VAULT_ADDR='http://127.0.0.1:8200'

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip

# Download and install Vault
RUN curl -LO https://releases.hashicorp.com/vault/1.16.2/vault_1.16.2_linux_amd64.zip \
    && unzip vault_1.16.2_linux_amd64.zip \
    && mv vault /usr/local/bin/ \
    && rm vault_1.16.2_linux_amd64.zip

# Set the working directory
WORKDIR /app

# Copy the Vault configuration file
COPY config.hcl /app/config.hcl

# Expose the Vault server port
EXPOSE 8200

# Start the Vault server
CMD ["vault", "server", "-config=config.hcl"]