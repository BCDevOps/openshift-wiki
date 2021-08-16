---
title: BC Gov PaaS OpenShift Platform Service Definition
description: This resource is a Service Definition of the BC Government Private Cloud as a Service/OpenShift Container Platform Service and concisely describes the key elements of the service for current and prospective users of the service.
tags:
  - openshift
  - service overview
  - service definition
  - platform
  - devops
  - private cloud
---


# BC Government OpenShift Container Platform Service Definition

## Service Description

### Summary

The BC Gov's Private Cloud Platform as a Service (PaaS) is a reliable and security-compliant<sup>[^1](#myfootnote1)</sup>  application hosting platform for running government services in the on-premises private cloud. It is available for use by ministries, agencies and crown corporations working with the Government of British Columbia. 
The Private Cloud PaaS is powered by RedHat's OpenShift Container Platform (OCP) technology, and is hosted in the government's Data Centers; Kamloops (main operations) and Calgary (disaster recovery only).

### Features & Functions

BCGov’s Private Cloud PaaS offers tools to help product teams in the BC Government that are building online services for citizens, develop and run modern, cloud native software applications. We, at the Platform Services Team in BCDevExchange, Ministry of Citizen Services, maintain and secure the infrastructure, so your team can focus on building and improving your applications!

Product teams are offered a choice of two hosting tiers on the Private Cloud Platform - Silver and Gold. The Silver tier provides application hosting on the "Silver Kamloops" production cluster. The Gold tier provides application hosting across the pair of “Gold Kamloops” and “Gold Calgary” production clusters.

|   | Silver  | Gold  |
|---|---|---|
| Who should use it?| Recommended for the majority of government services supported by Product teams **with junior to intermediate DevOps skills** |  Recommended for business mission critical government services supported by a **fully funded Product team with advanced DevOps skills** |
| How much does it cost? |  Free in 2021/2022 fiscal.  Cost recovery model may be implemented in 2022/2023 fiscal as part of the Enterprise Services cost review directed by Treasury Board, and will continue to consult with clients in that space on <em>whether</em> there will be cost recovery for Private Cloud, as well as  what it will look like if there is one. |  Free in 2021/2022 fiscal. Cost recovery model may be implemented in 2022/2023 fiscal as part of the Enterprise Services cost review directed by Treasury Board, and will continue to consult with clients in that space on <em>whether</em> there will be cost recovery for for Private Cloud, as well as what it will look like if there is one. |
| Maintenance Schedule | Private Cloud PaaS upgrades and patches will be applied in this production cluster quarterly after testing in LAB clusters	| All Private Cloud PaaS upgrades and patches are applied in Silver first; these will be applied quarterly in Gold a few weeks later. |
| High Availability | App horizontal scaling within Silver cluster, set up and managed by the Product team.	| App horizontal scaling within Gold Kamloops cluster AND a requirement to set up a geographic failover to Gold Calgary, both set up and managed by the Product team. |
| Network Services | Standard OpenShift routing. **Custom TLS certificates are mandatory for Product Teams to bring with the application**.	| Standard OpenShift routing, non-HTTP ports exposed to the DMZ for replication, and Global Site Load Balancing which is required for failover.  **Custom TLS certificates are mandatory for Product Teams to bring with the application.** |
| Platform Service Availability Level |	**90% for single-node application deployments<sup>[^2](#myfootnote2)</sup> 99.5% for multi-node application deployments<sup>[^3](#myfootnote3)</sup>** | **99.95%<sup>[^4](#myfootnote4)</sup>  for multi-node application deployments with geographic failover<sup>[^5](#myfootnote5)</sup>** |

BC Gov's Private Cloud as a Platform Service includes:

* a set of four project namespaces with self-serve developer access:  <em>tools</em> (for development of lifecycle support tools such as CI/CD pipelines, automated testing, and code quality tools), <em>dev</em>, <em>test</em>, and <em>prod</em> - each corresponding to a deployment stage in the application life cycle,
* "small" project resource quota by default (a bundle of CPU, RAM and storage resources) with ability to upgrade to "medium" and "large" as required. (See the project resource quota sizes [here](https://developer.gov.bc.ca/Project-Resource-Quotas-in-BC-Gov's-PaaS-(Openshift-4-Platform)) ),
* OCIO Standard Backup and restore services for application data. See more detials [here](https://developer.gov.bc.ca/OCP4-Backup-and-Restore),
* access to the DevSecOps tools to help teams build "Secure by Design" applications:
  * [Sysdig App Monitoring Service](https://developer.gov.bc.ca/BC-Government-Sysdig-Monitoring-Service-Definition) allows building robust dashboards for applications to monitor their health, availability and resource usage
  * [Artifactory Repository Service](https://developer.gov.bc.ca/BC-Government-Artifact-Repository-Service-Definition) provides access to a trusted and secure repository for storing images, packages, libraries and other artifacts
  * [Vault Secret Management Service](https://developer.gov.bc.ca/BC-Government-Vault-Secrets-Management) provides a secure way to store and manage credentials, API tokens and other sensitive app information
  * [AQUA Container Scanning Service](https://developer.gov.bc.ca/BC-Government-Aqua-Cloud-Service-Definition) allows teams to scan their running containers to find security vulnerabilities
  * [EnterpriseDB HA service for PostgreSQL](https://developer.gov.bc.ca/BC-Government-EDB-Operator-Service-Definition) – a vendor-supported product for running highly available PostgreSQL clusters (a product team must purchase their own license in order to use this service)

Other security features include:
* The majority of Private Cloud PaaS maintenance has no/minimal impact on the applications configured as multi-node deployments running on it and is run during business hours as required in a containerized environment.
* Multi-tenant hosting model in OpenShift and the build-in software defined network using Kubernetes Network Policies provides isolation between teams' environments so that they can't read or change each other's code, data or logs
* Developers receive self-serve access to create and manage application's network security rules for their own apps.  The Platform Community has a vast collection of design patterns that follow best security practices, for building integrations between the OpenShift applications and external systems. In addition, new technology and design patterns are being developed in partnership with ministries to ease this work even more.
  * Authenticated SSH access to application containers to debug problems i.e. rsh into a pod
  * Platform and application namespace access through org-restricted GitHub IDs (2FA required)
  * Single sign-on service for end-user authentication for apps through the BC Gov's Single Sign-On Service based on KeyCloak (https://oidc.gov.bc.ca)
  * The Private Cloud PaaS is piping core Platform log files into the central Security Information and Event Management (SIEM) system in OCIO for additional forensics and security audits.  Application log shipping and developer access to SIEM are coming soon.
  * Information Security Classification: Protected B.  The Private Cloud PaaS is approved for storage of Protected B information at rest.  However, if an application is designed with appropriate controls to protect data in transit, including the use of their own TLS certificate, an OpenShift application may pass Protected C information via APIs to a system component off-cluster (i.e. legacy system).  However, in this circumstance, DevOps teams should connect with their Ministry Information Security Officer (MISO) prior to collecting/using/storing Protected C information.  Once the VMWare NSX-T solution implementation and testing has completed, the information security classification level for the Private Cloud PaaS will be re-assessed.

### Support and Maintenance

The Platform Services Team with the help from Platform Operations and Data Center support teams monitors the infrastructure, OpenShift Container Platform and the critical DevOps Security services such as Vault and Artifactory, 24/7. All critical incidents that relate to the **availabilty of the Openshift 4 Platform and/or its critical services** outside of the regular business hours should be reported to Shared Services BC Service Desk at 250-387-7000 (aka 7-7000). 

We, at the Platform Services Team, also manage the patching of the platform's operating systems and infrastructure components. When we update the platform, we use zero downtime maintenance, so this won't interfere with the running of your application **if and only if your application is [designed for resiliency](https://developer.gov.bc.ca/Resiliency-Guidelines)**.

All non-critical Platform services and DevOps Security services are supported during business hours 9am-5pm Mon-Fri excluding statutory holidays.


### Requesting Access and Onboarding

Access to the Private Cloud Services is managed through a central application, the [Openshift 4 Platform’s Product Registry](https://registry.developer.gov.bc.ca/public-landing).  This application that we manage as a part of the Platform Service uses automation for the creation of your hosting space.  A team can have an environment created following an approval in as little as 10 minutes.  If you are net new to this service, **you will need to have an onboarding session with us first**.  Please reach out to Olena Mitovska, Product Director of the Private Cloud PaaS to get that started.  If you have any questions around the Platform Project Registry, she can answer those too.   If you are looking to leverage the Private Cloud PaaS, we are looking forward to welcoming you. 

### Service Availability and Communication

Much like we know you pride yourselves on the services you provide in your application development as part of your Product Team, we pride ourselves on the Private Cloud PaaS we provide.  Real-time uptime information for the DevOps Security services and the OpenShift clusters that we support can be found on the PaaS Reliability Dashboard at https://status.developer.gov.bc.ca , to compliment the SLA objectives above. More information about the Reliability Dashboard and what powers it underneath the hood, can be found [here](https://developer.gov.bc.ca/Openshift-4-Platform-Services-Reliability-Dashboard-with-Uptime-Robot)

As a member of the Private Cloud, you must join the [BCDevExchange](https://bcdevexchange.org/ExchangeLab), the Province of British Columbia’s vibrant developer community, also known as the Platform Community.  We leverage that community as part of our support model which is described below. The Platform Community relies on [Rocket.Chat](https://chat.developer.gov.bc.ca/), an open-source communication platform, to connect and stay in touch with each other and us, the Platform Services Team. You can read about how to join the RocketChat [here](https://developer.gov.bc.ca/Steps-to-join-Rocket.Chat).

We also provide additional communication channels for you to subscribe to for staying up to date on the Private Cloud PaaS offering and learn about major upcoming changes ahead of time.  Please sign up to the [Platform Updates Subscription service](https://subscribe.developer.gov.bc.ca ) to join our email distribution list.  In addition, once you join the community and service offering, we also encourage you to join our monthly Private Cloud PaaS Community Meetup Series where we share platform improvements, demos from ourselves and the community, and opportunities to engage with our service design research team. Please, ping [Olena Mitovska](mailto:Olena.Mitovska@gov.bc.ca) to get a meeting invite.


### Shared Responsibility Model

The Platform Services Team follows a team of teams model made up of the Platform Experience Team, and Platform Operations Team. Have a look at our org chart [here](https://docs.developer.gov.bc.ca/s/bk07fg8i4dscrcq7posg/devops-platform-services/d/bpp916b0acqjm3hnvd10/platform-services-org-chart?currentPageId=bpp91db0acqjm3hnvd1g).  While the Platform Services Team manages infrastructure, OpenShift Container Platform and the Platform critical services as part of the Private Cloud PaaS, the Product Team bears the responsibility for the functionality and operations of their application(s) hosted on the Platform.

| Resource | Responsibility for: Operational Support, Monitoring, Troubleshooting and Access Management |
|---|---|
| Application data | Product Team | 
| Application support and operations | Product Team |
| Application network security | Product Team together with their MISO |
| Application monitoring | Product Team |
| Application Integration with DevSecOps tools | Product Team | 
| Application Integration with KeyCloak SSO Service | Product Team |
| Platform Physical Infrastructure and OpenShift Software |	Platform Services Team: Operations Team (DXC/Advanced Solutions) |
| DevSecOps Tools (AQUA, Artifactory, Sysdig, EnterpriseDB Operator and Vault) | Platform Services Team: Platform Experience and Platform Operations Teams |
| BC Gov SSO Service | KeyCloak SSO Support Team (contact [Stephanie Bacon](mailto:Stephanie.Bacon@gov.bc.ca) for more details) |

If you have any questions about the shared responsibilities above, please contact Justin Hewitt, Sr Director of DevOps Platform Services at [Justin.Hewitt@gov.bc.ca](mailto:Justin.Hewitt@gov.bc.ca).

The diagram below shows the responsibilities that different groups within the government have in supporting the OpenShift 4 Platform, its infrastructure and the Ministry apps .

![BC Gov's Private Cloud Shared Responsibility Model](../../media/BCGov%20DevOps%20Platform%20Shared%20Responsibility%20Model.png)

### Community-based User Support Model

The Platform Community includes 2,000+ participants across all ministries of BC Government and is a mix of government employees and contracted resources.  While the Platform Services Team doesn’t provide direct application development support, the strong community of Platform users helps each other solve app-level questions. Read more about the Community-based User Support Model [here](https://developer.gov.bc.ca/Welcome-to-our-Platform-Community!)

The Platform team uses the open-source communication platform [Rocket.Chat](https://chat.developer.gov.bc.ca/) to connect with each other and help each other troubleshoot issues.  Refer to the [chat channel convention](https://developer.gov.bc.ca/Chat-Channel-Conventions) to find an appropriate channel to post your question.

If a team believes that an issue with the Private Cloud PaaS and not with the app itself, they can engage with the Platform Services Team in [#devops-sos](https://chat.developer.gov.bc.ca/channel/devops-sos) channel (if it is an urgent and critical production issue) or in [#devops-operations](https://chat.developer.gov.bc.ca/channel/devops-operations) channel (for non-urgent and non critical production issues) in RocketChat. Teams can also reach out to the Platform Community with general questions in [#devops-how-to](https://chat.developer.gov.bc.ca/channel/devops-how-to) channel.

We currently do not offer a Tiered Service Desk model on the Private Cloud PaaS, RocketChat is the primary communication tool to contact Platform Services Team to ask questions and get help.

### Training

Periodic internally-delivered training is provided by the DevOps Platform Services team. The internal training schedule is available [here](https://developer.gov.bc.ca/ExchangeLab-Course:-Openshift-101). Commercial OpenShift training is also available from Red Hat.  For details on the commercial training, contact [Olena Mitovska](mailto:olena.mitovska@gov.bc.ca), Product Owner for Platform Services.

**Welcome to the DevOps Platform and to the Platform Community!**

<em>Love, Platform Services Team, xo</em>

<sub><sup><a name="myfootnote1">1</a>: The OpenShift 4 Platform and all its services have STRA completed and signed-off by the government’s Chief Security Office</sup></sub>

<sub><sup><a name="myfootnote2">2</a>: Product team configured all applications pods to be deployed to a single cluster node within an OpenShift cluster</sup></sub>

<sub><sup><a name="myfootnote3">3</a>: Product team configured applications pods to be deployed to multiple nodes within an OpenShift cluster</sup></sub>

<sub><sup><a name="myfootnote4">4</a>: 99.95% uptime is on par with most Public Cloud Service Providers</sup></sub>

<sub><sup><a name="myfootnote5">5</a>: Product team configures the application with a Global Service Load Balancing service to failover to an application instance in Calgary Data Center</sup></sub>
