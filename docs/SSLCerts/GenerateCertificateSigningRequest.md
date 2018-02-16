Author: Clécio Varjão

# How-to: Generate a Certificate Signing Request (CSR)

### Using openssl

# Generate a passphrase
`openssl rand -base64 48 > passphrase.txt`

# Generate a Private Key
`openssl genrsa -aes128 -passout file:passphrase.txt -out server.key 2777`

# Generate a CSR (Certificate Signing Request)
`
openssl req -new -passin file:passphrase.txt -key server.key -out server.csr -subj "/C=CA/ST=British Columbia/L=Victoria/O=Government of the Province of British Columbia/OU=FLNRORD/CN=example.gov.bc.ca"
`

