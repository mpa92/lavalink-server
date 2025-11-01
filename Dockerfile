FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy Lavalink files
COPY Lavalink.jar .
COPY application.yml .

# Expose Lavalink port
EXPOSE 2333

# Run Lavalink
CMD ["java", "-jar", "Lavalink.jar"]

