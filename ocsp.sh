#!/bin/bash
# File ocsp.sh - Tool for RGS auditing - P. Legand XIRIUS Informatique
# Checks the revocation status of a certificate using OSCP
#
# --------------------------------------------------------------------------------
# USER'S MANUAL
# - Copy the ocsp.sh and rgsTools.cfg files anywhere in a local folder
# - Set the related environment variables in file rgsTools.cfg
# - Copy certificates into the OCSP directory (PEM format)
# - Copy CA trust chain certificates into the AC_CERT_CER directory (PEM format)
#   (issuer = last intermediate certificate authority)
# - Launch command: "bash oscp.sh"

# Note - To convert DER certificates to PEM format:
# openssl x509 -in cert.der -inform DER -out cert.pem -outform PEM
# ---------------------------------------------------------------------------------

if [ ! -f `pwd`/rgsTools.cfg ]
then
	echo "**ERR: Configuration file `pwd`/rgsTools.cfg is missing."
	return $NO_CFG
fi
. `pwd`/rgsTools.cfg #$TOOL_PATH/rgsTools.cfg

echo "RGS Auditing tools v$VERSION"
echo "----------------------------"
initDir=`pwd`
cd ${OCSP}

for Cert in *
do
	echo "$Cert processing..."
	openssl ocsp -issuer ${AC_CERT_CER}$ISSUER -cert ${OCSP}$Cert -url $RESPONDER
done
cd $initDir
