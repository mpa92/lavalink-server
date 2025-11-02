FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Install wget for downloading plugin
RUN apk add --no-cache wget

# Copy Lavalink files
COPY Lavalink.jar .
COPY application.yml .

# Copy plugins directory (contains lavasrc.jar)
COPY plugins/ plugins/

# Expose Lavalink port
EXPOSE 2333

# Run Lavalink with plugins directory
CMD ["java", "-jar", "Lavalink.jar"]

