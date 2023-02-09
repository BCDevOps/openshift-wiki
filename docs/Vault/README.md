# HashiCorp Vault Architecture and Design <!-- omit in toc -->

This documentation outlines the implementation details, architecture and design of the HashiCorp Vault installed on the BC Gov's Private Cloud OpenShift Platform.

### Vault Architecture and Design

- [Structure and Architecture within Vault](./StructureAndArchitecture.md)
- [Troubleshooting](./Troubleshooting.md)
- [Maintenance Tasks](./VaultMaintenanceTasks.md)
- [TLS Cipher Suites](./VaultTLSCipherSuites.md)
- [Rotate and Rekey](./VaultRotateAndRekey.md)
- [Create Raft Snapshot](./VaultRaftSnapshot.md)
- [Restore Raft Snapshot](./VaultRaftRestore.md)
- [Service Definition](./VaultServiceDefinition.md)
- [Terraform Integration](./vault-terraform.md)

### Failover to DR site
When Vault server in Gold Cluster fails, follow [this link](https://developer.hashicorp.com/vault/tutorials/enterprise/disaster-recovery#generate-a-dr-operation-token) to start failover to the Vault-DR server in GoldDR cluster.
