#!/bin/bash

RED='\e[0;31m'
YELLOW='\e[0;33m'
CYAN='\e[0;36m'
LIGHT_GRAY='\e[0;37m'
END_COLOR='\e[0m'

# fqdn = 'ns02.orion.lan'
# subjectAlternativeNames = 'DNS:ns02.orion.lan,DNS:stackstorm.orion.lan,IP:192.168.10.11'

if [[ "$1" == "" && "$2" == "" || "$1" == "--help" || "$1" == "help" ]]; then
    printf "${RED}ERROR: ${LIGHT_GRAY}Two parameters required, the host name followed by the subject alternataive names.\n"
    printf "${YELLOW}Syntax: ${LIGHT_GRAY}easy-rsa-gen-cert.sh ${CYAN}<fqdn> ${YELLOW}<subjectAlternativeNames>${END_COLOR}\n"
    printf "${LIGHT_GRAY}Do not use quotes. Use the format in the example below:\n"
    printf "${YELLOW}EX: ${LIGHT_GRAY}easy-rsa-gen-cert.sh ${CYAN}ns02.orion.lan ${YELLOW}DNS:ns02.orion.lan,DNS:stackstorm.orion.lan,IP:192.168.10.11${END_COLOR}\n"
    exit 1
fi


./easyrsa --batch --req-cn="$1" gen-req "$1" nopass
./easyrsa --batch --subject-alt-name="$2" sign-req server "$1"

