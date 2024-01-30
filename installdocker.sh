i#!/bin/bash

# Installing Docker Engine for Ubuntu.
# According notes from: https://docs.docker.com/engine/install/ubuntu/
# By: Kevin J. Figueroa

# Add Docker's official GPG key:
apt-get update
if [[ $# == '0' ]]; then
    apt-get install -y ca-certificates curl gnupg
    if [[ $# == '0' ]]; then
        install -m 0755 -d /etc/apt/keyrings
        if [[ $# == '0' ]]; then
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            if [[ $# == '0' ]]; then
                chmod a+r /etc/apt/keyrings/docker.gpg

                # Add the repository to Apt sources:
                if [[ $# == '0' ]]; then
                    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
                    if [[ $# == '0' ]]; then
                        apt-get update
                        if [[ $# == '0' ]]; then
                            apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
                        fi
                    fi
                fi
            fi
        fi
    fi
fi
echo $(which docker)

