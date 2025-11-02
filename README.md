# Lavalink Server for Railway Deployment

This repository contains everything needed to deploy a Lavalink v4 server on Railway. Deploy this as a separate Railway service to avoid public server rate-limiting issues.

## What's Included

- **Lavalink.jar** - The Lavalink server executable (download from [GitHub Releases](https://github.com/lavalink-devs/Lavalink/releases) if not included)
- **application.yml** - Pre-configured for Railway deployment

## Quick Start - Railway Deployment

### Step 1: Deploy to Railway

1. **Create new Railway service:**
   - Go to Railway dashboard
   - Create new project or add to existing project
   - Click "New Service" → "Deploy from GitHub repo"
   - Select this repository

2. **Configure service:**
   - Railway will now use the `Dockerfile` for deployment
   - No manual configuration needed - the Dockerfile handles everything!
   - The service will automatically build and start
   
   **Note:** If you need to override the start command:
   - Go to **Settings** → **Deploy**
   - **Start Command**: Leave as default (Dockerfile handles it) OR set to `java -jar Lavalink.jar`

3. **Set environment variables:**
   - `JAVA_OPTS=-Xmx512M` - Adjust memory (Railway free tier supports ~256-512M)
   - `JAVA_OPTS=-Xmx256M` - For lower memory usage (recommended for free tier)

### Step 2: Get Service URL

1. Wait for deployment to complete
2. Go to **Settings** → **Networking**
3. Copy the **Public Domain** URL
   - Example: `lavalink-production.up.railway.app`

### Step 3: Connect Your Bot

In your bot's Railway service, update environment variables:

**Option A: Public Domain (Works across Railway projects)**
```env
LAVALINK_URL=lavalink-production.up.railway.app:443
LAVALINK_PASSWORD=youshallnotpass
LAVALINK_SECURE=true
LAVALINK_NAME=railway-lavalink
```

**Option B: Internal Networking (Same Railway project - faster and more secure)**
```env
LAVALINK_URL=lavalink:2333
LAVALINK_PASSWORD=youshallnotpass
LAVALINK_SECURE=false
LAVALINK_NAME=railway-lavalink
```
*Replace `lavalink` with your actual service name*

## Configuration

The `application.yml` is pre-configured for Railway:

```yaml
server:
  port: 2333          # Railway handles port mapping automatically
  address: 0.0.0.0    # Required for Railway - binds to all interfaces

lavalink:
  server:
    password: "youshallnotpass"  # ⚠️ CHANGE THIS in production!
    sources:
      youtube: true
      spotify: true
    plugins:
      lavasrc:
        sources:
          spotify: true
        spotify:
          clientId: "${SPOTIFY_CLIENT_ID}"
          clientSecret: "${SPOTIFY_CLIENT_SECRET}"
          countryCode: "US"
```

**For Spotify Support:**
- The `lavasrc` plugin is automatically downloaded during Docker build
- You MUST set `SPOTIFY_CLIENT_ID` and `SPOTIFY_CLIENT_SECRET` environment variables
- Get your Spotify API credentials from: https://developer.spotify.com/dashboard
- Create a new app, then copy the Client ID and Client Secret

### Customization

You can modify `application.yml` before deploying:
- Change password for security
- Enable/disable audio sources
- Configure IP rotation for YouTube (if needed)
- Adjust memory settings

## Security

⚠️ **IMPORTANT**: Before deploying to production:
1. Change the password in `application.yml` to something secure
2. Update the password in your bot's environment variables to match
3. Consider using Railway's internal networking instead of public domain

## Troubleshooting

### Service won't start
- Check Railway logs for Java errors
- Verify `JAVA_OPTS` memory setting isn't too high
- Ensure `Lavalink.jar` is in the root of the repository

### Bot can't connect
- Verify Lavalink service is running (check logs)
- Ensure password matches in both services
- Check the URL is correct (include port if using public domain)
- For internal networking: verify both services are in same Railway project

### Connection issues after Railway restart
- This is normal - both services will restart
- Bot will automatically reconnect once Lavalink is ready
- Wait 10-30 seconds after Railway restart before testing

### High memory usage
- Reduce `JAVA_OPTS` to `-Xmx256M` or lower
- Consider upgrading Railway plan if needed
- Monitor usage in Railway dashboard

## Railway Internal Networking (Recommended)

If your bot and Lavalink are in the **same Railway project**:

**Benefits:**
- ✅ Faster connections (internal network)
- ✅ More secure (not publicly exposed)
- ✅ No SSL needed
- ✅ Lower latency

**Setup:**
- Use service name instead of public domain
- Format: `<service-name>:2333`
- Example: `lavalink:2333`

## Cost Estimate

**Railway Free Tier:**
- $5 free credit per month
- Lavalink service: ~$1-2/month
- Bot service: ~$2-3/month
- **Total: Usually covered by free credit!**

## Monitoring

Check service health:
1. Railway dashboard → Your Lavalink service
2. View logs for: `Started Launcher in X seconds`
3. Check Metrics tab for CPU/Memory usage

## Support

- **Lavalink Documentation**: https://lavalink.dev
- **Railway Documentation**: https://docs.railway.app
- **Lavalink GitHub**: https://github.com/lavalink-devs/Lavalink

## Files in This Repository

- `Lavalink.jar` - Server executable (download if missing)
- `application.yml` - Configuration file
- `README.md` - This file

---

**Ready to deploy?** Push this repo to GitHub and deploy on Railway! 🚀
