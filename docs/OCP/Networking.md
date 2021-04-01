---
description: BC Gov OpenShift networking overview
title: BC Gov OpenShift networking overview
tags:
  - network
  - SDN
  - ingress
  - egress
  - openshift network
---

## Openshift Silver 4.x Networking

The Openshift 4 networking config is protected. You may view it on [documize](https://docs.developer.gov.bc.ca/s/bn6v0ac6f9gue7hhirbg/protected-platform-services/d/bsg9q3nu3u14r4kded80/ocp-4-platform-network-topology) with the appropriate level of access. 

## OpenShift Pathfinder 3.11 Networking

Pathfinder OpenShift specific implementation notes:
* SDN uses the ovs-multitenant SDN plug-in for configuring the pod network.
* Pathfinder OpenShift is *not* using the F5 plugin. `Routes`  within OpenShift  (similar to `Ingress`) are using the OpenShift-provided HA Proxy functionality. The frontend, Internet-facing load balancer located outside of OpenShift is an F5 (on IP .209) which is simply configured to forward traffic to the HA Proxy instances. The F5 is not tightly integrated with OpenShift. 
* CIDR Range 142.34.143.128/26; Netmask 255.255.255.192; Wildcard Bits 0.0.0.63; First IP 142.34.143.128; Last IP 142.34.143.191
* OpenShift servers are in `VLAN 138` in Kamloops
* Firewall Object: `OCIO-PF-PROD-DMZ` (used as SOURCE)
* Private Network IP Range: 172.51.0.0/16

* Access (ingress) points:
  * console.pathfinder.gov.bc.ca:8443 - (142.34.208.210) API and web UI
  * .pathfinder.gov.bc.ca:80/443 - (142.34.208.209) internet accessible application Virtual IP; there is an Entrust wildcard SSL cert for this.
  * .pathfinder.bcgov:80/443 (142.34.143.180) - Internal facing application Virtual IP; there is currently NO wildcard SSL cert for this.

> **Please note:** A common misconception is that using a *{name}*.pathfinder.bcgov name will secure your application for 'internal to BCGov' traffic.  This is **NOT** the case.  Both of the external VIPs are directing traffic to the *SAME* cluster ingress.  To secure named routes you must add route whitelists. (ref: https://docs.openshift.com/container-platform/3.11/architecture/networking/routes.html#whitelist)

* BCGov IP 142 Subnets (https://whois.arin.net/rest/org/PBC-51-Z/nets): 
142.22.0.0/16 142.23.0.0/16 142.24.0.0/16 142.25.0.0/16 142.26.0.0/16 142.27.0.0/16 142.28.0.0/16 142.29.0.0/16 142.30.0.0/16 142.31.0.0/16 142.32.0.0/16 142.33.0.0/16 142.34.0.0/16 142.35.0.0/16 142.36.0.0/16

