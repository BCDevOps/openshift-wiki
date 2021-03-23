---
description: The demo collection from Platform Services Team's Sprint Reviews.
resourceType: Documentation
title: Platform Services Sprint Review Demo Collection
tags:
  - platform services demo
  - demos
  - demo collections
  - sprint review
---

# Platform Services Sprint Review Demos

This page contains links to the demos presented at BC Gov's Platform Services Team's Sprint Reviews. The collections includes demos not only by the Platform Services Team but by many product teams working together as the Platform Community.


[Demo #1: App Migration from Openshift On-prem to ARO](https://www.youtube.com/watch?v=i-auqEUcR5U&t=1s) (Sep 21, 2020)
Patrick form BCDEvExchange’s Platform Services Team talks about his experience with migrating DevHub app from the on-prem Openshift 3.11 cluster to the Openshift 4 ARO cluster in Azure.

[Demo #2: Shared/Reusable Front-End REACT and Vue Component Library for BC Gov-themed web applications](https://www.youtube.com/watch?v=eFi5QJo2hgo&t=4s) (Sep 21, 2020)
Shreyas and Alan from JAG/NTT Data product teams presents a library of reusable front-end components that can help expedite the development of the front-end for web applications that require to follow the BC Gov design theme. The components are available in 2 versions – REACT and VUE. Currently the GitHub release can be referenced directly in your project's package.json file to pull in the components and in the future will be available to download as an NPM package. The release includes components such as header, footer, terms of use,  button, table, etc and incorporates the official design guidelines outlined in BC Gov’s Design System (https://github.com/bcgov/design-system)
The component source code is available in GutHub at https://github.com/bcgov/react-shared-components

[Demo #3: Namespace provisioning in Openshift 4 using GitOps approach](https://www.youtube.com/watch?v=5aSon_DVbRM&t=1s) (Sep 21, 2020)
Jason from BCDEvExchange’s Platform Service Team shows the first iteration of the new Platform Project Registry that will be available on the new OCP 4 Platform and that aims to automate parts of the intake process. The first iteration demonstrates how the new Openshift namespace provisioning request flow will be streamlined through automation using a combination of the web UI and the ArgoCD GitOps components.
The Platform Project Registry Web UI code is available in GitHub at https://github.com/bcgov/platform-services-registry

[Demo #4: Openshift 4 Platform – New Project Registry Demo](https://www.youtube.com/watch?v=HiHsd-Rg57E&t=1633s)
The Platform Services Team piloted the use of the new Project Registry that implemented the GitOps approach to provisioning services on the new Openshift 4 Platform. The Project Registry is intended to be a single entry point for the Platform Service intake process where teams can submit requests for provisioning namespaces in Openshift 4 clusters and creating objects and accounts in the Platform’s Shared Services e.g. KeyCloak SSO, Artifactory, etc. The first iteration of the Project Registry implemented the namespace provisioning feature that the Openshift 4 Early Access participants used to request a project set (4 namespaces – dev, test, tools and prod) to be a created on the Silver cluster on the Openshift 4 Platform as a precursor to migrating their applications off the Openshift 3.11 Platform and onto Openshift 4.

[Demo #5: Integrating with KeyCloak SSO and BC Services Card on BCGov’s Openshift Platform](https://www.youtube.com/watch?v=IGONgJkvwms)
The JAG/NTT Data product team presents an integration pattern for Platform hosted apps that leverages BC Services Card as an identity provider through the KeyCloak SSO service.
The pattern addresses a security requirement of not storing (even temporarily) any user data  neither in the app itself or in the KeyCloak SSO while allowing to share a user session across multiple apps.

[Demo #6: Using BC Service Card Self Service Onboarding Application](https://www.youtube.com/watch?v=H2tKvOQ8x4k)
Provincial Identity Information Management Program team demonstrated the use of the BC Service Card Self Service Onboarding Application and the repo that product teams wishing to integrate their application using the BC Services Card as an OIDC authentication mechanism can use to generate sample integration code.

We keep adding demos to the collection as they get released to YouTube so keep checking for the new additions time to time.

Love, Your Platform Services Team, xo
