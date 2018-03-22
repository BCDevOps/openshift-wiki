# OpenShift Networking - Pathfinder Project Config

References:
* https://docs.openshift.com/container-platform/3.7/architecture/networking/sdn.html

Pathfinder OpenShift specific implementation notes:
* SDN uses the ovs-multitenant SDN plug-in for configuring the pod network.
* Pathfinder OpenShifyt is not using the F5 plugin; routing within OpenShift is using OpenShift-provided HA Proxy. The load balancer is outside OpenShift (.209) and forwards traffic to the HA Proxy instances is an F5, but it is not tightly integrated with OpenShift. 
* CIDR Range 142.34.143.128/26; Netmask 255.255.255.192; Wildcard Bits 0.0.0.63; First IP 142.34.143.128; Last IP 142.34.143.191
* OpenShift servers are in VLAN 138 in Kamloops
* Private Network IP Range: 172.51.0.0/16

