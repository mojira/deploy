# Mojira Deploy GitHub Action
GitHub Action for deploying Mojira community bots to Azure.

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
        azure_client_id: ${{ secrets.AZURE_CLIENT_ID }}
        azure_tenant_id: ${{ secrets.AZURE_TENANT_ID }}
        azure_subscription_id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
        bastion_name: ${{ secrets.BASTION_NAME }}
        resource_group: ${{ secrets.RESOURCE_GROUP }}
        resource_id: ${{ secrets.RESOURCE_ID }}
        ssh_private_key: ${{ secrets.SSH_PRIVATE_KEY }}
        username: example
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

- **azure_client_id** - _string_ - Client ID for Azure.

- **azure_tenant_id** - _string_ - Tenant ID for Azure.

- **azure_subscription_id** - _string_ - Subscription ID for Azure.

- **bastion_name** - _string_ - Name of the Bastion to deploy to.

- **bastion_ip** - _string_ - IP of the Bastion tunnel. **Default:** `localhost`

- **bastion_port** - _integer_ - Port number of the Bastion tunnel. **Default:** `50022`

- **resource_group** - _string_ - Resource group to deploy to.

- **resource_id** - _string_ - Resource ID to deploy to.

- **resource_id** - _string_ - Resource ID to deploy to.

- **ssh_private_key** - _string_ - Private SSH key to use for connecting.

- **username** - _string_ - Username for authentication.

- **artifact_paths** - _string_ - Paths to artifacts (folders or files) to upload. String with exactly one path per line, and an empty line at the end.

- **artifact_destination** - _string_ - Target folder for artifact upload.

- **script** - _string_ - Script to run after uploading of artifacts. **Default:** (empty)
