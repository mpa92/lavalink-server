# Lavalink Performance Optimization

## Configuration Optimizations

The `application.yml` has been optimized with the following latency-reducing settings:

### Current Settings:
- **bufferDurationMs: 400** - Audio buffer duration (lower = faster start, but may stutter)
- **frameBufferDurationMs: 5000** - Frame buffer for smooth playback
- **playerUpdateInterval: 5** - Player state updates (lower = more responsive)
- **resamplingQuality: HIGH** - Audio quality setting

### JVM Performance Flags

For local development, you can optimize the Java Virtual Machine with these flags:

**Windows (PowerShell):**
```powershell
java -Xmx2G -Xms2G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -jar Lavalink.jar
```

**Linux/Mac:**
```bash
java -Xmx2G -Xms2G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -jar Lavalink.jar
```

### Flag Explanations:
- **-Xmx2G -Xms2G** - Allocate 2GB RAM (adjust based on your system)
- **-XX:+UseG1GC** - Use G1 Garbage Collector (better for low latency)
- **-XX:+ParallelRefProcEnabled** - Parallel reference processing
- **-XX:MaxGCPauseMillis=200** - Target max GC pause time (200ms)
- **-XX:+UnlockExperimentalVMOptions** - Enable experimental JVM options
- **-XX:+DisableExplicitGC** - Disable explicit GC calls
- **-XX:+AlwaysPreTouch** - Pre-touch memory pages (faster allocation)

### Railway/Docker Deployment

For Railway, set these environment variables:
```env
JAVA_OPTS=-Xmx512M -Xms512M -XX:+UseG1GC -XX:MaxGCPauseMillis=200
```

### Further Optimizations

1. **Network Location**: Host Lavalink geographically close to your Discord bot users
2. **Bandwidth**: Ensure sufficient bandwidth for multiple concurrent streams
3. **CPU**: Use a CPU with good single-threaded performance
4. **Memory**: Allocate enough RAM (512M minimum, 1-2GB recommended)

### Testing Latency

After applying optimizations:
1. Restart Lavalink server
2. Test with: `mm!play <song>`
3. Monitor response time and audio quality
4. Adjust `bufferDurationMs` if experiencing stuttering (increase to 600-800ms)

### Trade-offs

**Lower Latency:**
- Faster response times
- Quicker track starts
- More responsive controls

**Potential Issues:**
- May cause audio stuttering if too low
- Higher CPU usage
- More frequent network requests

**Recommended Settings:**
- For most users: **400ms buffer** (current)
- If experiencing stuttering: Increase to **600-800ms**
- For maximum performance: Can go as low as **200ms** (may stutter)

