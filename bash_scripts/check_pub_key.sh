#!/bin/bash

# Private key
KEY_PATH="/home/root/.ssh/id_ecdsa"

# check private key exists
if [ ! -f "$KEY_PATH" ]; then
    echo "Error: Private key don't exists: $KEY_PATH"
    exit 1
fi

# check hosts in file
# format:
# root@1.2.3.4
HOSTS_FILE="hosts"

if [ ! -f "$HOSTS_FILE" ]; then
    echo "Error: hosts file don't exists: $HOSTS_FILE"
    exit 1
fi

while IFS= read -r HOST; do
    echo "Conection... $HOST..."
    
    # check pub key on server
    ssh -o BatchMode=yes -o ConnectTimeout=5 -o StrictHostKeyChecking=no -o PasswordAuthentication=no -i $KEY_PATH $HOST "echo  Connection Success"
    
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32m Key found on $HOST \e[0m"
    else
        echo -e "\e[1;31m Key NOT found on $HOST \e[0m"
    fi

    echo "-------------------------------------"
done < "$HOSTS_FILE"

