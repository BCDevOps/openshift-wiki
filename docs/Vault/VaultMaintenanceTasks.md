# Maintenance Tasks for Vault

## License update

Vault license expires every year around April. Platform Admins will kick off the procurement process and obtain the new license.

Steps to update license:
- first make sure you have the `root token` for the vault instance, in case there is a need for configuration changes!
- find the `vault-license` secret from klab and gold, take a copy of it
- refer to [the tenant repo](https://github.com/bcgov-c/tenant-gitops-ea8776) to verify things are alright
- update the secret with the new vault license value
- restart vault sts pods:
  - to find the primary pod, look for `vault-active` service. the pod it points to is the primary
  - restart the non-primary pods, one after another
  - when they are all up and running, restart the primary pod
- at this point, things should just work as expected. The expiration message from Vault console should be gone as well!
- However, you might find that vault testing pods will fail authentication where SA gets `permission denied`. This is due to a known [Vault SA authentication issue](./Troubleshooting.md) don't panic, now we just need to disable issuer validation as noted from the troubleshooting doc.


## SSL Cert update

The SSL Cert for external Vault URL will expire April 1st every year.

Assuming there is still no automation done at the time, just update the TLS certs for the `vault-standard` route. DO NOT change the `Destination CA certificate`!
