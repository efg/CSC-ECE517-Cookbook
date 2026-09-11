# Cookbook (newer Ruby/Rails version)

This guide provides instructions to setup the Cookbook application using Docker.

## Prerequisites:
1. VSCode
2. Git
3. Docker
    - Windows users install Docker Desktop
4. Clone this repo

## Getting up and running

### Open VSCode and clone this repo

- CTRL + SHIFT + P will open the VSCode command pallete
- Type Git: Clone in the pallete window
- Press enter to select it and then paste the git url for the repo
- You will be asked to save the repo to a local directory
- After selecting the repository destination, you can have it open in the current window or a new window of VSCode

### Ensure that Docker is running

>NOTE:
>
>Windows users can run the `BuildTools/scripts/install_docker.ps1` script which will ensure that it's installed and is running

Open this project in VSCode

Copy BuildTools/example.env to BuildTools/.env

You should not need to change these settings. Note that `.env` only holds Node/coverage flags; the OS and Ruby versions are set as Docker build args in `BuildTools/ruby/dockerfile` (`RUBY_VERSION`, `RUBY_OS`), not in `.env`.

Open your terminal in VSCode,  CTRL + SHIFT + `

Launch the docker compose stack/application

>NOTE: Windows powershell users can use the `BuildTools/scripts/compose_project.ps1` script

```pwsh
docker compose -f BuildTools/docker-compose.yml up -d
```

The docker compose stack will run the rails server on port 3003.  You can access it on [http://localhost:3003](http://localhost:3003)

> NOTE:
> 
> The SQLite file under cookbook/db will get generated when the container starts up.
> 
> If a sqlite3 file already exists when doing docker compose up -d or stopping/starting the container it will not overwrite the development.sqlite3 file
> 
> To get a fresh sqlite3 file:
>
> - using the command line
>   ```pwsh
>   docker exec -it ruby_cookbook /bin/bash -c "rm /app/db/development.sqlite3; rails db:migrate"
>    ```
>
> - using vscode/docker:
>   - in vscode navigate to cookbook/db
>   - delete the development.sqlite3 file
>   - restart the docker container called ruby_cookbook
>     - this can be done via docker desktop using the restart icon
>     - via the command line
>       ```pwsh
>       docker compose -f BuildTools/docker-compose.yml restart ruby
>       ```


In case of any issues, don't hesitate to post on Piazza for assistance, or open an issue on GitHub

> NOTE:
> 
> Alternative instructions can be found on the [Google Drive](https://docs.google.com/document/d/1hsa23-vL33alJoUZcxoniq_zXaVrPfQ_oiu-M-2Pdx8/edit?tab=t.0#heading=h.ra1gu0kdz5ut)
