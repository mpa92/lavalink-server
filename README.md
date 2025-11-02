# Lavalink Server

Lavalink v4.1.1 server with Spotify, YouTube, and SoundCloud support.

## 📦 What's Included

- **Lavalink.jar** - Lavalink 4.1.1 server
- **application.yml** - Pre-configured with performance optimizations
- **Plugins:**
  - `lavasrc-plugin-4.8.1.jar` - Spotify support via Deezer/SoundCloud mirroring
  - `youtube-plugin-1.13.5.jar` - YouTube support (replaces deprecated built-in source)

## 🚀 Quick Start - Local Development

### 1. Start Lavalink Server

**Windows (PowerShell):**
```powershell
cd lavalink-server
java -jar Lavalink.jar
```

**Linux/Mac:**
```bash
cd lavalink-server
java -jar Lavalink.jar
```

### 2. Verify Connection

Look for these messages in the logs:
- `✅ Lavalink node "Mufflins-Lavalink" connected and ready`
- `Lavalink is ready to accept connections`

## ⚙️ Configuration

### Current Settings

The `application.yml` is optimized for low latency:

```yaml
lavalink:
  server:
    bufferDurationMs: 400        # Fast response time
    frameBufferDurationMs: 5000 # Smooth playback
    playerUpdateInterval: 5     # Responsive controls
    resamplingQuality: "HIGH"   # Audio quality
```

### Supported Sources

- ✅ **Spotify** - Via LavaSrc plugin (mirrors to Deezer/SoundCloud)
- ✅ **YouTube** - Via YouTube Source Plugin (v1.13.5)
- ✅ **SoundCloud** - Direct support
- ✅ **Deezer** - Used for Spotify mirroring
- ✅ **Bandcamp, Twitch, Vimeo, HTTP** - Also enabled

### Performance Optimization

See `PERFORMANCE.md` for:
- JVM optimization flags
- Buffer tuning recommendations
- Latency optimization tips

## 🔧 Plugin Configuration

### LavaSrc Plugin (Spotify)

**Configuration:**
- Loaded via Maven dependency (auto-downloads)
- Spotify credentials configured in `application.yml`
- Mirrors Spotify tracks to Deezer/SoundCloud (no YouTube fallback)

**Provider Priority:**
1. Deezer ISRC matching (best quality)
2. Deezer search
3. SoundCloud search (fallback)

### YouTube Plugin

**Configuration:**
- Uses local JAR file (`youtube-plugin-1.13.5.jar`)
- Automatically loaded from `plugins/` folder
- Replaces deprecated built-in YouTube source
- Supports videos, playlists, and YouTube Music

## 🚂 Railway Deployment

### Step 1: Deploy to Railway

1. Create new Railway service
2. Deploy from GitHub repo
3. Set environment variable:
   ```env
   JAVA_OPTS=-Xmx512M -Xms512M -XX:+UseG1GC -XX:MaxGCPauseMillis=200
   ```

### Step 2: Get Service URL

1. Go to **Settings** → **Networking**
2. Copy the **Public Domain** URL

### Step 3: Connect Your Bot

In your bot's Railway service, set:
```env
LAVALINK_HOST=your-lavalink-service.up.railway.app
LAVALINK_PORT=443
LAVALINK_PASSWORD=youshallnotpass
LAVALINK_SECURE=true
```

**For Internal Networking (same Railway project):**
```env
LAVALINK_HOST=lavalink  # Service name
LAVALINK_PORT=2333
LAVALINK_SECURE=false
```

## 🔒 Security

⚠️ **Before production deployment:**
1. Change password in `application.yml`
2. Update password in bot's environment variables
3. Use Railway internal networking when possible

## 🐛 Troubleshooting

### Server won't start
- Check Java version: `java -version` (need Java 17+)
- Verify `Lavalink.jar` exists in directory
- Check logs for plugin loading errors

### Plugins not loading
- **LavaSrc:** Downloads automatically via Maven (check internet connection)
- **YouTube:** Ensure `youtube-plugin-1.13.5.jar` is in `plugins/` folder

### High latency
- See `PERFORMANCE.md` for optimization tips
- Adjust `bufferDurationMs` if experiencing stuttering (try 600-800ms)
- Use JVM optimization flags for local development

### Bot can't connect
- Verify Lavalink is running (check logs)
- Ensure password matches in bot config
- Check firewall/network settings

## 📚 Documentation

- **Lavalink Docs**: https://lavalink.dev
- **LavaSrc Plugin**: https://github.com/topi314/LavaSrc
- **YouTube Plugin**: https://github.com/lavalink-devs/youtube-source

## 📁 Files

- `Lavalink.jar` - Server executable
- `application.yml` - Configuration file
- `plugins/` - Plugin JAR files
- `PERFORMANCE.md` - Performance optimization guide
- `README.md` - This file

---

**Ready to use!** Start the server and connect your bot. 🎵
