# Mojira Deploy GitHub Action
GitHub Action for deploying Mojira community bots to the Mojira VPS.

## Example workflow

```yml
name: Build and deploy

jobs:
  build:
    steps:
    - name: Build
      # ...
    - name: Deploy
      uses: mojira/deploy@main
      with:
        vps_host: ${{ secrets.VPS_HOST }}
        vps_user: ${{ secrets.VPS_USER }}
        vps_ssh_key: ${{ secrets.VPS_SSH_KEY }}
        vps_known_hosts: ${{ secrets.VPS_KNOWN_HOSTS }}
        project_folder: example
        artifact_paths: |
          build/lib
          build/bin
          config.yml
        artifact_destination: /home/example/app
        script: |
          ./start.sh
          echo Successfully deployed!
```

## Options

All options without a default are required.

- **vps_host** - _string_ - The VPS host's IP address or domain name.

- **vps_user** - _string_ - User name for authentication.

- **vps_ssh_key** - _string_ - Private SSH key to use for connecting.

- **vps_known_hosts** - _string_ - Known Hosts file to use for connecting with SSH.

- **project_folder** - _string_ - The folder name for this project on the Mojira VPS. Use a different one for each project to avoid conflicts!

- **artifact_paths** - _string_ - Paths to artifacts (folders or files) to upload. String with exactly one path per line, and an empty line at the end.

- **artifact_destination** - _string_ - Target folder for artifact upload.

- **rsync_args** - _string_ - Arguments for uploading artifacts via rsync. **Default:** `-avhW --delete`

- **script** - _string_ - Script to run after uploading of artifacts. **Default:** (empty)
