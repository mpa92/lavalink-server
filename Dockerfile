FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Install wget and required libraries for native code
RUN apk add --no-cache wget libgcc gcompat

# Copy Lavalink files
COPY Lavalink.jar .
COPY application.yml .

# Copy plugins directory (contains lavasrc.jar)
COPY plugins/ plugins/

# Download YouTube source plugin (required for lavasrc YouTube support)
# Latest version: https://maven.lavalink.dev/releases/dev/lavalink/youtube/youtube-plugin/
RUN wget -O plugins/youtube-plugin.jar https://maven.lavalink.dev/releases/dev/lavalink/youtube/youtube-plugin/1.13.5/youtube-plugin-1.13.5.jar || \
    (echo "Warning: Failed to download YouTube plugin. Check: https://maven.lavalink.dev/releases/dev/lavalink/youtube/youtube-plugin/" && \
     echo "You may need to download it manually and add it to the plugins folder.")

# Expose Lavalink port
EXPOSE 2333

# Run Lavalink with plugins directory
CMD ["java", "-jar", "Lavalink.jar"]

