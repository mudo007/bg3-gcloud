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

# Selects the deployment ID and then asks for the vault root token
# Choose GPU: T4, P4 or P100
# T4: nvidia-tesla-t4-vws us-central1-a us-central1 n1-standard-8
# P4: nvidia-tesla-p4-vws idem acima
# p100: nvidia-tesla-p100-vws us-central1-c us-central1 n1-standard-8
S3='Choose the GPU type: '
options=("T4(16GB GDDR6)" "P4(8GB GDDR5)" "P100(16GB HBM2)" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "T4(16GB GDDR6)")
            export TF_VAR_GPU=nvidia-tesla-t4-vws
            export TF_VAR_ZONE=a
            break;;
        "P4(8GB GDDR5)")
            export TF_VAR_GPU=nvidia-tesla-p4-vws
            export TF_VAR_ZONE=a
            break;;
        "P100(16GB HBM2)")
            export TF_VAR_GPU=nvidia-tesla-p100-vws
            export TF_VAR_ZONE=c
            break;;
        "Quit")
            exit 0
            ;;
        *) echo "invalid option";;
    esac
done

# initializes and apply terraform
terraform init
terraform_result=$(terraform apply -auto-approve 2>&1 )

#starts the provisioned VM
if ! [[ $terraform_result == *"Error:"* ]]; then
    echo "starting VM bg3..."
    gcloud compute instances start bg3
else
    echo -n "$terraform_result"
fi

