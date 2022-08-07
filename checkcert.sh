#!/bin/bash -       
# ==============================================================================
# Title           : checkcert.sh
# Description     : This script will check the expiration date of a SSL.
# Author     		  : Julien Mousqueton @JMousqueton
# Date            : 2022-08-07
# Version         : 1.0
# Licences        : GNU 3.0    
# Usage	      	  : bash checkcert.sh -d <domain>
# Notes           : 
# ==============================================================================



DAYS=7
# DOMAIN="expired.badssl.com"
PORT="443" 
Verbose="false"

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White


############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Check expiration date of SSL certificat."
   echo
   echo "Syntax: scriptTemplate [-d|p|D|h]"
   echo "options:"
   echo -e "d     Domain name (${Red}Mandatory${Color_Off})."
   echo "h     Print this Help."
   echo "D     Number of days (by default 7 days)."
   echo "p     Port (by default 443)."
   echo
}

############################################################
# Error Message                                            #
############################################################
echoerr() 
{ 
  if [ "$Verbose" == "true" ]; then   
    echo "$@" 1>&2; 
  fi 
}

############################################################
# Check if OpenSSL is installed                            #
############################################################
Openssl_check ()
{
  echoerr "Checking for openssl..."
  if command -v openssl > /dev/null; then
    echoerr "Detected openssl..."
  else
    if [[ $OSTYPE == 'darwin'* ]]; then 
        echoerr "MacOS : you should check manually if openssl is installed" 
    else
      echoerr "Installing openssl..."
      sudo apt-get install -q -y openssl
      if [ "$?" -ne "0" ]; then
        echoerr "Unable to install openssl ! Your base system has a problem; please check your default OS's package repositories because openssl should work."
        echoerr "Repository installation aborted."
        exit 1
      fi
    fi
  fi
}

############################################################
# Main                                                     #
############################################################

# Get the options
while getopts ":d:hD:p:v" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      d) # Domain name
         DOMAIN=$OPTARG;;
      D) # nb Days 
         DAYS=$OPTARG;;
      p) # Port number 
         PORT=$OPTARG;;
      v) # Verbose mode 
         Verbose="true";;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

# Check if a domain is specified 
if [ -z "${DOMAIN}" ]; then
  echo -e "${Red}\xE2\x9D\x8C${Color_Off} A domain name (-d) is mandatory !!!\n" 
  Help
  exit
fi

# Call Openssl_check()
Openssl_check

# Check if the domain is responding 
status_code=$(curl --write-out %{http_code} --silent --output /dev/null https://$DOMAIN:$PORT) 
    if [[ "$status_code" -ne 200 ]] ; then
        echo -e "${Red}\xE2\x9D\x8C${Color_Off} ${Yellow}$DOMAIN${Color_Off} ne repond pas !!!" 
        exit 
    fi   

# Concert Days in seconds for openssl call 
Seconds=$((DAYS * 86400))


echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:$PORT 2>/dev/null | openssl x509 -noout -enddate -checkend "$Seconds" >/dev/null
if [ $? -eq 1 ];
then
	echo -e "${Red}\xE2\x9D\x8C${Color_Off} ${Yellow}$DOMAIN${Color_Off} has been expired or will expire within ${Yellow}$DAYS${Color_Off} days."
else
  echo -e "${Green}\xE2\x9C\x94${Color_Off} ${Yellow}$DOMAIN${Color_Off} won't expired within ${Yellow}$DAYS${Color_Off} days."
fi
