#!/bin/bash

# Check if the .env file exists
if [ ! -f ".env" ]; then
    echo "Error: .env file not found."
    exit 1
fi

# Read the .env file line by line
while IFS= read -r line; do
    # Remove leading and trailing whitespaces
    trimmed_line=$(echo "$line" | awk '{$1=$1};1')

    # Check if the line is not empty
    if [ -n "$trimmed_line" ]; then
        # Extract the variable name and value
        variable_name=$(echo "$trimmed_line" | cut -d'=' -f1)
        variable_value=$(echo "$trimmed_line" | cut -d'=' -f2-)

        # Export the environment variable
        export "$variable_name"="$variable_value"

        # Print the export statement
        echo "export $variable_name=\"$variable_value\""
    fi
done < .env

# initializes and apply terraform
terraform init
terraform apply -auto-approve

#starts the provisioned VM
gcloud compute instances start bg3
