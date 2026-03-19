# Docker Management Strategies

## Why Docker?
Docker provides a lightweight way to package and run applications in isolated environments (containers) that share the host machine's kernel.

### Key Concepts
- **Images**: Read-only templates used to create containers.
- **Containers**: Running instances of images.
- **Layers**: Images are built in layers to share data and reduce disk usage.

## Best Practices
1. **Rebuild vs. Update**:
   - **Bad**: Entering a running container and running `apt update`. These changes are lost if the container is restarted.
   - **Good**: Update the `Dockerfile` and rebuild the image. This ensures reproducibility and security.
2. **Base Images**: Use small, secure base images (like `alpine` or `distroless`).
3. **Security Scanning**: Regularly scan images for vulnerabilities using tools like **Trivy**.
   - Command: `trivy image my-image:latest`

## Docker Commands
- **Build an image**: `docker build -t my-app:1.0 .`
- **Run a container**: `docker run -d -p 8080:80 my-app:1.0`
- **List running containers**: `docker ps`
- **Remove a container**: `docker rm -f container_id`
- **Clean up unused data**: `docker system prune -a`
