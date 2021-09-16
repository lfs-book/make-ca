#!/bin/bash
# Simple script to use Microsoft code signing trust from CCADB

CSURL="https://ccadb-public.secure.force.com/microsoft/IncludedRootsPEMTxtForMSFT?MicrosoftEKUs=Code%20Signing"

rm -f mscertsign.txt CS.txt
wget -O mscertsign.txt ${CSURL}

echo " Mozilla no longer provides any trust information for code signing, opting only
# to supply VERIFY trust, so that Mozilla neither provides policy, nor removes
# the functionality from NSS. The following list of certificate hashes (already
# installed as they have TLS trust from Mozilla) are also trusted by Microsoft
# for code signing. The Microsoft Trusted Root Certificate Program's inclusion
# policy is available for review at:
# https://docs.microsoft.com/en-us/security/trusted-root/program-requirements.
# See https://www.ccadb.org/ for joint efforts between Google, Microsoft, and
# Mozilla to create a unified trust store.
" > CS.txt

date=`date -u`
echo "# List current as of ${date}." >> CS.txt
echo -e "# Move this list to \$SSLDIR and use -i to add code signing trust\n" \
     >> CS.txt

startlist=`grep -n "^-----BEGIN" mscertsign.txt | cut -d ":" -f 1`
for certbegin in ${startlist}; do
    awk "NR==$certbegin,/^-----END CERTIFICATE-----/" mscertsign.txt \
        > ${certbegin}.crt
    openssl x509 -noout -in ${certbegin}.crt -hash >> CS.txt
    rm ${certbegin}.crt
done
rm -r mscertsign.txt

