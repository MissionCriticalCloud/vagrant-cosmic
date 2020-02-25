#!/bin/sh
docker run \
-e USER=${USER} \
-e COSMIC_API_KEY=${COSMIC_API_KEY} \
-e COSMIC_SECRET_KEY=${COSMIC_SECRET_KEY} \
-e COSMIC_HOST=${COSMIC_HOST} \
-e ZONE_NAME=${ZONE_NAME} \
-e SERVICE_OFFERING_NAME=${SERVICE_OFFERING_NAME} \
-e VPC_PUBLIC_IP=${VPC_PUBLIC_IP} \
-e VPC_TIER_NAME=${VPC_TIER_NAME} \
-e VR_PUBLIC_IP=${VR_PUBLIC_IP} \
-e VR_NETWORK_NAME=${VR_NETWORK_NAME} \
-e NETWORK_NAME=${NETWORK_NAME} \
-e PUBLIC_SOURCE_NAT_IP=${PUBLIC_SOURCE_NAT_IP} \
-e OPEN_FIREWALL=${OPEN_FIREWALL} \
-e PUBLIC_SSH_PORT=${PUBLIC_SSH_PORT} \
-e PRIVATE_SSH_PORT=${PRIVATE_SSH_PORT} \
-e PUBLIC_WINRM_PORT=${PUBLIC_WINRM_PORT} \
-e PRIVATE_WINRM_PORT=${PRIVATE_WINRM_PORT} \
-e SSH_USER=${SSH_USER} \
-e SSH_KEY=/work/${SSH_KEY} \
-e WINDOWS_USER=${WINDOWS_USER} \
-e LINUX_TEMPLATE_NAME=${LINUX_TEMPLATE_NAME} \
-e WINDOWS_TEMPLATE_NAME=${WINDOWS_TEMPLATE_NAME} \
-e SOURCE_CIDR=${SOURCE_CIDR} \
-e TRUSTED_NETWORKS=${TRUSTED_NETWORKS} \
-e KITCHEN_LOCAL_YAML=${KITCHEN_LOCAL_YAML} \
-e DISK_OFFERING_NAME=${DISK_OFFERING_NAME} \
-e EXPUNGE_ON_DESTROY=${EXPUNGE_ON_DESTROY} \
-ti --rm  -v $(pwd):/work MissionCriticalCloud/vagrant-cosmic /bin/bash
