# Vault TLS Cipher Suites

Vault is using the default Golang CipherSuites(), which still includes SHA1 for compatibility reasons.
For increased security, all cipher suites ending with exactly _SHA should be removed,
see https://github.com/golang/go/blob/master/src/crypto/tls/cipher_suites.go#L50-L72.

This can be specified in the Vault configuration file with:

```bash
# Incomplete example below
"tls_cipher_suites": "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,<insert all non SHA cipher suites>",
```
