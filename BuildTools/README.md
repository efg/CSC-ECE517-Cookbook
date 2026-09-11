# Docker App Setup

Docker Compose setup for the Cookbook application (a Ruby on Rails app backed by SQLite).
Starts a single service: the `ruby` container that runs the Rails server.

## Prerequisites

- Windows 10/11 with PowerShell (the helper scripts target Windows)
- Docker Desktop with the WSL2 backend (install it with the script below if needed)
- Internet access for the first image pulls

## Quick Start

1. **Install or start Docker Desktop** (no-op if already running):

   ```powershell
   .\BuildTools\scripts\install_docker.ps1
   ```

2. **Create `BuildTools\.env` in VS Code**:
   - In the Explorer, open `BuildTools/example.env`, then select all (Ctrl+A) and copy (Ctrl+C).
   - In the `BuildTools/` folder, right-click → *New File…*, name it `.env`, and paste (Ctrl+V).
   
3. **Build and start the stack**:

   ```powershell
   .\BuildTools\scripts\compose_project.ps1 -Start
   ```

4. **Open the Cookbook app** in your browser: `http://localhost:3003`

5. **Stop the stack** when done:

   ```powershell
   .\BuildTools\scripts\compose_project.ps1 -Stop
   ```

## Docker Installation Script

`scripts\install_docker.ps1` — installs or starts Docker Desktop on Windows (WSL2 backend).

- Docker already running → prints a message and exits.
- Docker installed but stopped → prompts to start Docker Desktop (default: yes) and waits up to 5 minutes for the daemon.
- Docker not installed → must be run from an **elevated (Administrator)** prompt; enables the WSL feature if missing (reboot + re-run in that case), downloads the Docker Desktop installer to `%USERPROFILE%\Downloads`, and launches it.

```powershell
.\BuildTools\scripts\install_docker.ps1 [-DockerPath <path>] [-Help]
```

## Project Startup Script

`scripts\compose_project.ps1` — starts or stops the Docker Compose project (manages `BuildTools\docker-compose.yml` by default).

- `-Start` → `docker compose up -d`, then prints service status. The image is built automatically if it is missing or stale.
- `-Stop` → `docker compose down --remove-orphans`; unless `-RemoveVolumes` / `-RemoveImages` are passed, it prompts about cleaning up volumes and images. `-RemoveVolumes` removes the project's named `gem_cache` volume (which holds the installed gems, so the next start reinstalls them); `-RemoveImages` removes the images, forcing a full rebuild the next start.
- `-ComposeFile <path>` → manage a different compose file.
- `-Help` → usage.

```powershell
.\BuildTools\scripts\compose_project.ps1 -Start
.\BuildTools\scripts\compose_project.ps1 -Stop
.\BuildTools\scripts\compose_project.ps1 -Stop -RemoveVolumes -RemoveImages
```

### Service overview

| Service | Container | Host port | Notes |
| --- | --- | --- | --- |
| ruby | `ruby_cookbook` | 3003 | `cookbook/` is bind-mounted at `/app`; `CMD` is `rails server` |
