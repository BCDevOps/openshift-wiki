# HashiCorp Vault Architecture and Design <!-- omit in toc -->

This documentation outlines the implementation details, architecture and design of the HashiCorp Vault installed on the BC Gov's Private Cloud OpenShift Platform.

## Table of Contents <!-- omit in toc -->

### Vault Architecture and Design

- [Structure and Architecture within Vault](./StructureAndArchitecture.md)
- [Troubleshooting](./Troubleshooting.md)
- [TLS Cipher Suites](./VaultTLSCipherSuites.md)
- [Rotate and Rekey](./VaultRotateAndRekey.md)
- [Create Raft Snapshot](./VaultRaftSnapshot.md)
- [Restore Raft Snapshot](./VaultRaftRestore.md)

### Use-Cases

- [Use-Case 1 Multi-Tenancy with a single Vault Namespace

### Repository Folder Structure

- [Diagrams](#diagrams)
- [Folder structure](#folder-structure)

## Diagrams

**COMING SOON!!**

The diagrams.net source files with file extension **.drawio** are located here:

- [Diagrams (drawio)](./assets/drawio/)

## Folder structure

Below is a snapshot of this folder's structure.

```bash
docs/Vault/
├── README.md
├── StructureAndArchitecture.md
├── Troubleshooting.md
├── VaultRaftRestore.md
├── VaultRaftSnapshot.md
├── VaultRotateAndRekey.md
├── VaultServiceDefinition.md
├── VaultTLSCipherSuites.md
└── assets
    ├── drawio
    ├── gifs
    │   └── vault-login.gif
    └── images
```
