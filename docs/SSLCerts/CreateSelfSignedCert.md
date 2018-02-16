Author: Clécio Varjão

# How-to: Create a self-signed certificate 

### Using openssl

# Generate a passphrase
`openssl rand -base64 48 > passphrase.txt`

# Generate a Private Key
`openssl genrsa -aes128 -passout file:passphrase.txt -out server.key 2777`

# Generate a CSR (Certificate Signing Request)
`
openssl req -new -passin file:passphrase.txt -key server.key -out server.csr -subj "/C=CA/ST=British Columbia/L=Victoria/O=Government of the Province of British Columbia/OU=FLNRORD/CN=example.com"
`

# Remove Passphrase from Key
`cp server.key server.key.org`
`openssl rsa -in server.key.org -passin file:passphrase.txt -out server.key`

# Generating a Self-Signed Certificate for 100 years
`openssl x509 -req -days 36500 -in server.csr -signkey server.key -out server.crt`


References:
http://crohr.me/journal/2014/generate-self-signed-ssl-certificate-without-prompt-noninteractive-mode.html
