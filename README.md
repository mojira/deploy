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

- **project_folder** - _string_ - The folder name for this project on the Mojira VPS. Use a different one for each project to avoid conflicts!

- **artifact_paths** - _string_ - Paths to artifacts (folders or files) to upload. String with exactly one path per line, and an empty line at the end.

- **artifact_destination** - _string_ - Target folder for artifact upload.

- **rsync_args** - _string_ - Arguments for uploading artifacts via rsync. **Default:** `-avhW --delete`

- **script** - _string_ - Script to run after uploading of artifacts. **Default:** (empty)
