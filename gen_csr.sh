#!/bin/bash

# Shell colors
RED='\e[0;31m'
YELLOW='\e[0;33m'
CYAN='\e[0;36m'
LIGHT_GRAY='\e[0;37m'
END_COLOR='\e[0m'

SSL_DIR="/usr/share/scripts/csr"
OPENSSL_CMD="/usr/bin/openssl"

if [[ "$1" == "" || "$1" == "--help" ]]; then
    printf "${RED}ERROR: ${CYAN}Must specify cert name as a parameter.${END_COLOR}\n"
    printf "${CYAN}Example: ${YELLOW}./gen_csr.sh my_cert${END_COLOR}\n"
    exit 1
else
    printf "${CYAN}Generating Certificate Signing Request...\n"
    printf "${CYAN}Using Configuration File ${SSL_DIR}/openssl.conf${END_COLOR}\n"
    printf ${YELLOW}
    sudo ${OPENSSL_CMD} req -out $SSL_DIR/"$1".csr -new -newkey rsa:2048 -nodes -keyout $SSL_DIR/"$1".key -config $SSL_DIR/openssl.conf
    printf ${END_COLOR}
fi

if [ $? == 0 ]; then
    printf "${CYAN}Resetting Permissions.${END_COLOR}\n"
    printf ${YELLOW}
    sudo chown root:webdevs -R /usr/share/scripts/csr
    sudo chmod 644 $SSL_DIR/"$1".csr
    sudo chmod 644 $SSL_DIR/"$1".key
    printf ${END_COLOR}
    printf "${CYAN}CSR and Key located in directory: ${YELLOW}${SSL_DIR}${END_COLOR}\n"
else
    printf "${RED}ERROR: ${CYAN}Oops, something went wrong. Please investigate and try again.${END_COLOR}\n"
fi