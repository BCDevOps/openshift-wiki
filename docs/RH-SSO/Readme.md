# RH Single SIgnon OpenShift

Urls: 
* https://sso-dev.pathfinder.gov.bc.ca/
* https://sso-test.pathfinder.gov.bc.ca/
* https://sso.pathfinder.gov.bc.ca/

Environments:
- Sandbox
- Dev
- Test
- Prod

Openshift Projectspace : devops-sso-*

Prod Certoificate Setup:
1.) Request an Entrust Cert

See https://www.entrustdatacard.com/resource-center/installation/installation-help

keytool -genkey -alias server -keyalg RSA -keysize 2048 -keystore sso_pathfinder_gov_bc_ca.jks -dname "CN=sso.pathfinder.gov.bc.ca,OU=CITZ, O=Government of the Province of British Columbia, L=Victoria, ST=BC, C=CA" 
keytool -certreq -alias server -file sso_pathfinder_gov_bc_ca.txt -keystore sso_pathfinder_gov_bc_ca.jks

Creates 
sso_pathfinder_gov_bc_ca.txt
sso_pathfinder_gov_bc_ca.jks

keytool -list -keystore sso_pathfinder_gov_bc_ca.jks 
Enter keystore password:  

Keystore type: JKS
Keystore provider: SUN

Your keystore contains 1 entry

server, 22-May-2018, PrivateKeyEntry, 
Certificate fingerprint (SHA1): D8:F4:8B:26:B8:09:B1:56:4B:A5:BA:07:F5:FD:EA:72:44:FB:AE:8A

send sso_pathfinder_gov_bc_ca.txt to entrust

2.) Received files from CITZ Identity Management:
- sso.pathfinder.gov.bc.ca.txt
- G2Root.txt
- L1KChain.txt

3.) Create keystore and trustore for RH SSO

keytool --importkeystore --srckeystore sso_pathfinder_gov_bc_ca.jks --srcalias server  --destkeystore keystore.p12 -deststoretype PKCS12
openssl pkcs12 -in keystore.p12 -nodes -nocerts -out key.pem
mv key.pem keystore.key
mv sso.pathfinder.gov.bc.ca.txt certificate.signed.crt
openssl pkcs12 -export -in certificate.signed.crt -inkey keystore.key -out keystore.signed.p12 -name sso-ssl -CAFile G2Root.txt -caname root
keytool -import -v -alias sso-ssl -file certificate.signed.crt  -keystore certificate.signed.jks
keytool -list  -keystore certificate.signed.jks
openssl pkcs12 -export -out certificate.signed.p12 -inkey keystore.key -in certificate.signed.crt
openssl pkcs12 -info -in certificate.signed.p12
rm certificate.signed.jks

keytool -importkeystore -srckeystore certificate.signed.p12 -srcstoretype PKCS12 -destkeystore certificate.signed.jks -deststoretype JKS -destalias sso-ssl
keytool -importkeystore -srckeystore certificate.signed.p12 -srcstoretype PKCS12 -destkeystore certificate.signed.jks -deststoretype JKS -srcalias 1 -destalias sso-ssl
keytool -list -keystore certificate.signed.jks -v
keytool -list -keystore certificate.signed.jks -v
keytool -list -keystore certificate.signed.jks
keytool -import -alias chain -keystore certificate.signed.jks -trustcerts -file L1KChain.txt
keytool -import -alias chain -keystore certificate.signed.jks -trustcacerts -file L1KChain.txt
keytool -import -alias chain -keystore certificate.signed.jks -trustcacerts -file L1KChain.txt  -v
keytool -import -alias chain -keystore certificate.signed.jks -trustcacerts -file L1KChain.txt  -v
keytool -import -alias root -keystore certificate.signed.jks -trustcacerts -file G2Root.txt
openssl x509 -outform der -in G2Root.txt -out G2Root.der
keytool -import -alias root -keystore certificate.signed.jks -trustcacerts -file G2Root.der
openssl x509 -outform der -in L1KChain.txt -out L1KChain.der
keytool -import -alias chain -keystore certificate.signed.jks -trustcacerts -file L1KChain.der
keytool -list -keystore certificate.signed.jks
keytool -import -alias root -keystore truststore.jks -trustcacerts -file G2Root.der




