#!/bin/sh
set -eu

# Open bastion tunnel
echo Installing prerequisites...
# python3 -m pip install --upgrade pip --user
az login
az extension add --name bastion

echo Opening tunnel...
AZURE_PORT=50022
AZURE_IP=127.0.0.1

az network bastion tunnel --name $INPUT_BASTION_NAME --resource-group $INPUT_RESOURCE_GROUP --target-resource-id $INPUT_RESOURCE_ID --resource-port 22 --port $AZURE_PORT &
az network bastion wait --created --name $INPUT_BASTION_NAME --resource-group $INPUT_RESOURCE_GROUP
echo Azure Bastion tunnel established.

# Set up SSH key
echo Setting up SSH key...
mkdir -p ~/.ssh
echo "$INPUT_SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

# Args for artifact deploy
echo Uploading artifacts...
for ARTIFACT_PATH in "${INPUT_ARTIFACT_PATHS[@]}"; do
    echo Uploading artifact $ARTIFACT_PATH...
    rsync -avh --delete -e 'ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no -p $AZURE_PORT' $GITHUB_WORKSPACE/$ARTIFACT_PATH $INPUT_USERNAME@$AZURE_IP:$INPUT_ARTIFACT_DESTINATION
done
echo All artifacts have been uploaded.

# Run deploy script
echo Running internal deploy script...
ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no -p $AZURE_PORT $INPUT_USERNAME@$AZURE_IP << EOF
    $INPUT_SCRIPT
EOF

echo Deployment complete!
