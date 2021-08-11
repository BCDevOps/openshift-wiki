---
title: Openshift Useful Pro Tips
resourceType: Documentation
tags:
  - openshift
  - tips
  - FAQ
  - Openshift access
  - GitHub ID
  - Project Registry
  - Internal DNS Wildcard
  - Timezone cronjobs
  - Project edit
  - Project update
  - internal DNS Wildcard
  - Certificate
  - Timezone
  - Cronjob
  - Role Binding
  - Sysdig 
  - Patroni connectivity
  - jenkins account
  - Artifactory documentation
  - S2I documentation
  - graceful termination
  - ArtifactoryServiceAccount 
  - move data between clusters
  - storage
  - S3 Object store
  - best development practices
  - Pod status
  - UID injection
  - Docker Auth
  - Image registry
  - Bcgov custom domain
  - Patroni
  - RedHat Images
  - PostgreSQL initialization 
  - Namespace access
  - Jenkins image
  - egress
  - Secrets
  - Quota Increase
  - NetworkPolicies
  - Backup storage volumes
  - Firewall rule
  - Health checks 
  - oc CLI console
  - DNS Vanity URL
  - GitHub Actions
  - KeyCloak SSO 
  - customize Openshift Console
  - Kibana 
  - Build Entitlements
  - Cluster registry
  - OpenShift CLI
  - securityContext
  - HELM
  - RabbitMQ
  - Minio
  - RBAC Access
  - Patroni Network Issue 
description: Openshift useful tips and FAQ
---

## YOU CAME ACROSS THIS PAGE BECAUSE IT CONTAINS ONE OR MORE OF THE KEYWORDS THAT YOU ARE SEARCHING FOR. TO FIND THE PRO TIPS ON THIS PAGE THAT INCLUDE THE INFORMATION RELATED TO THE KEYWORD(S), USE PAGE SEARCH IN THE BROWSER (CTRL-F + ENTER THE KEYWORD + ENTER). 

# BC Gov's Openshift 4 Platform Q&A and Useful Pro Tips

Export of Github issues for [BCDevOps/OpenShift4-Migration](https://github.com/BCDevOps/OpenShift4-Migration). Generated on 2021.08.03 at 09:16:45.

# [\#76 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/76) `open`: I changed my GitHub ID and now I cannot see my namespaces in Openshift

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2021-06-21 19:00](https://github.com/BCDevOps/OpenShift4-Migration/issues/76):

We use membership in `BCDevOps` org in GitHub to control user access to the Openshift 4 Console. Access to the namespaces is set up within Openshift itself by the namespace admins. User authentication when accessing the Openshift 4 Console is handled by the `KeyCloak SSO` service. 

When you change your GitHub ID, it messes up with your account record in both systems - KeyCloak SSO and Openshift  - that store a cache your GitHub ID.  To resolve the access issues, follow the steps below.

Step 1:  Ask your PO or Tech Lead to remove your old user from the namespaces in Openshift where you had access before.  
Step 3: To force the refresh of your account record, contact the Platform Services Team at PlatformServicesTeam@gov.bc.ca and **request the following**:
 -  delete your old GitHub ID from `Kq56c126`, `DevHub` and `GitHub` realms in KeyCloak SSO
 -  delete your user in Openshift 4 Silver cluster
  - remove your old GitHub ID from BCDevOps and bcgov orgs
  
Step 4: After this ask your PO or Tech Lead to add your new GitHub ID to `BCDevOps` and `bcgov` orgs using the [Just Ask! tool](https://just-ask-web-bdec76-prod.apps.silver.devops.gov.bc.ca/) and then add your user to the namespaces that you need to have access to.
 
After these steps, clear your browser cache , and log into the Openshift 4 Console. You should see the list of projects to which you've been given access to in Step 4.




-------------------------------------------------------------------------------

# [\#75 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/75) `open`: Who can change project details in Project Registry?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2021-05-25 17:53](https://github.com/BCDevOps/OpenShift4-Migration/issues/75):

At this moment only a Product Owner and a Technical Lead(s) assigned to a project in the [OCP 4 Project Registry](https://registry.developer.gov.bc.ca/public-landing) can make any changes to the project details such as :
a) update the project name and a description 
b) change a Product Owner and/or Technical Lead. **Note: the old PO/TL will lose access to the project namespace in Openshift 4 once their name is removed from the project record in the Project Registry.**
c) request a resource quota increase for the project

Only **new project provisioning requests and resource quota increase requests require the Platform Services Team's approval** before being processed. All other changes are applied automatically to the project record in the Project Registry as well as to the project namespaces in Openshift. 




-------------------------------------------------------------------------------

# [\#74 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/74) `open`: What are the key success factors for migrating an app from OCP 3->OCP 4 Platform?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2021-03-24 23:46](https://github.com/BCDevOps/OpenShift4-Migration/issues/74):

1. **Having a support team in place!**  Yes, each app hosted on the Platform is supposed to have a DevOps Specialist/SRE person supporting it.  The team that built or supports the app can migrate it in the quickest and most efficient way.
2. **Having DevOps skills on the team**. If you don't have DevOps Specialists on the team, bring someone in to train your developers. Pair-programming is a great way to share knowledge and cross-train within the team.
3. **Staying in the loop**.  Learn about upcoming change early by attending Platform Services Sprint Reviews and being on the communications distribution list. 
4.  **Developing a migration plan as early as possible**.  Start planning the migration early, having a good plan is a key.
5.  **Keeping business owners aware about the migration**. Let your sponsor and other stakeholders know about the migration, it will help making it a priority and a part of the app roadmap. Also, will help with timing the migration to avoid  possible conflicts with other business priorities (e.g. important releases and milestones).  Keeping the business owners informed about the migration progress and let them know about possible delays and challenges as soon as possible to help with schedule adjustments.
6. **Having a pattern set up to follow for all environments**. Migrating a DEV environment will most likely take the longest but then you will be able to repeat the pattern for TEST and PROD and migrate those environments quickly.
7. **Discovering new services that the team can take advantage from**.  Your app stores a large amount of unstructure data such as files, images or documents? Have a look at the [new S3-based Object Storage service](https://github.com/BCDevOps/OpenShift4-Migration/issues/59) offered by OICO.
8. **Keep in touch with Platform Services team and using the support options available with them**. Ask migration questions in [#devops-ocp4-migration](https://chat.developer.gov.bc.ca/channel/devops-ocp4-migration) channel in Rocket.Chat.




-------------------------------------------------------------------------------

# [\#73 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/73) `open`: OpenShift nice-to-have feature list

#### <img src="https://avatars.githubusercontent.com/u/2395873?v=4" width="50">[Emiliano Suñé](https://github.com/esune) opened issue at [2021-02-10 17:53](https://github.com/BCDevOps/OpenShift4-Migration/issues/73):

The following is a list of nice-to-have features for OpenShift, based on personal experience (and taste) and on the patterns established for the projects hosted on the BC DevOps instance of OCP. They are not all-new features, but rather optimizations and tweaks of current workflows and setups.

- [ ] Pre-configured role bindings: when deploying a new set of services, role bindings need to be configured in order to follow the recommended pattern of storing builds/images in the `tools` namespace, and deployments in `dev/test/prod`.
- [ ] Pre-configured "general" NSPs: there are a couple of NSPs that could be configured by default when generating a name set, as not having them in place will cause things to not work at all. In particular, the NSP allowing pods to talk to the K8S api should be pre-configured in all namespaces (`tools/dev/test/prod`), while the NSP allowing builds to pull from the internet (Git, NPM, PyPy, NuGet, etc.) should be pre-configured for the `tools` namespace.
- [ ] Pre-configured pull secrets to make using Artifactory (or other Docker image registries) transparent.
- [ ]  The OCP3 way of copying the login command, without having additional pop-up windows and links to click seemes more efficient/user friendly.

This list could be extended with suggestions from other teams/developers as considered appropriate.

#### <img src="https://avatars.githubusercontent.com/u/10504350?v=4" width="50">[Wade Barnes](https://github.com/WadeBarnes) commented at [2021-02-16 18:29](https://github.com/BCDevOps/OpenShift4-Migration/issues/73#issuecomment-780033395):

If the pull secrets are created and properly linked to the correct service accounts in the given environments the use of the Artifactory proxy to pull images becomes completely transparent to the project teams; i.e. there is NO need to explicitly define them in the BCs and DCs.
Here are some recent updates we did to the [BCDevOps/openshift-developer-tools](https://github.com/BCDevOps/openshift-developer-tools/tree/master/bin); https://github.com/BCDevOps/openshift-developer-tools/pull/128/files.

Those functions are part of the [initOSProjects.sh](https://github.com/BCDevOps/openshift-developer-tools/blob/master/bin/initOSProjects.sh), which automates the initial setup of the roles and secrets on a given project set.  It automatically detects the `artifacts-default-*` creds in the `tools` project and automatically sets up the pull credentials and links them to the service accounts.

Example run (on an environment that already been setup, but it gives you the gist):
```
Found secret artifacts-default-ugnrgl, would you like to use this as a pull secret? (y/n)
y

Pull secret, artifactory-creds already exists in 583dbf-tools ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-tools ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-tools ...

Pull secret, artifactory-creds already exists in 583dbf-dev ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-dev ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-dev ...

Pull secret, artifactory-creds already exists in 583dbf-test ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-test ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-test ...

Pull secret, artifactory-creds already exists in 583dbf-prod ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-prod ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-prod ...
```

Something like this could be done automatically when the projects sets are provisioned.

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) commented at [2021-03-24 23:33](https://github.com/BCDevOps/OpenShift4-Migration/issues/73#issuecomment-806250708):

@esune I created a [ticket](https://app.zenhub.com/workspaces/platform-experience-5bb7c5ab4b5806bc2beb9d15/issues/bcgov/platform-services-registry/361) in our backlog to look into automating your suggestions with the Registry's provisioner bot.
@WadeBarnes Your suggestion is in another [ticket](https://app.zenhub.com/workspaces/platform-experience-5bb7c5ab4b5806bc2beb9d15/issues/bcgov/platform-services-registry/359).
We will tackle them in the next 2-3 Sprints.

#### <img src="https://avatars.githubusercontent.com/u/46204611?v=4" width="50">[IanKWatts](https://github.com/IanKWatts) commented at [2021-06-01 18:16](https://github.com/BCDevOps/OpenShift4-Migration/issues/73#issuecomment-852343696):

@esune @WadeBarnes Comments on these suggestions are inline below.

_1) Preconfigured role bindings_
Not all teams use the tools/dev/test/prod model and the Platform Services Team prefers that role bindings be managed by project teams.

_2) Preconfigured network security policies_
Now that the OpenShift platform is using Kubernetes network policies instead of Aporeto, this is no longer an issue. Egress traffic is now allowed by default and the Aporeto zero-trust policy is not in effect.

_3) Preconfigured pull secrets_
My understanding is that there are some problems with this.
If we use cluster-wide pull credentials so that project teams do not have to manage this on their own, then the platform team would be responsible for the management of the credentials, which the team would prefer to avoid.  Each project team should have full control over their pull secrets.
Alternatively, if pull secrets were automatically set up and managed by ArgoCD for project teams, that would interfere with teams managing secrets on their own.
The Platform Services Team will consider options for this in the future, but for now will not manage pull secrets for teams.

_4) Copying the login command_
Unfortunately, this is a feature of OpenShift 4 and is not something that we can change. It was implemented as a security feature by Red Hat. In OpenShift 3 the token could be copied with a single click, even if the user's session was already expired (the token might still be valid after session expiration). To prevent this, in OpenShift 4 you must open a new page in order to ensure that your session is still valid, although this is slightly less convenient.  Changing this behaviour would require a change request to Red Hat.

If project teams are struggling with items 1, 3, and 4, then perhaps an update to the onboarding process or documentation is required.

#### <img src="https://avatars.githubusercontent.com/u/2395873?v=4" width="50">[Emiliano Suñé](https://github.com/esune) commented at [2021-06-02 15:25](https://github.com/BCDevOps/OpenShift4-Migration/issues/73#issuecomment-853122784):

Thanks for the reply @IanKWatts .

A couple of additional notes:

> 
> 
> _1) Preconfigured role bindings_
> Not all teams use the tools/dev/test/prod model and the Platform Services Team prefers that role bindings be managed by project teams.

I wasn't aware this was (still) possible, as I was under the impression that the tools/dev/test/prod pattern was strongly recommended, if not even enforced in some way. I would play devil's advocate and say that if the majority of teams is following this pattern, it might be beneficial to have the role bindings pre-populated based on the recommended behaviour. I might however be missing something that could cause grief in the long term.

> 
> 
> _3) Preconfigured pull secrets_
> My understanding is that there are some problems with this.
> If we use cluster-wide pull credentials so that project teams do not have to manage this on their own, then the platform team would be responsible for the management of the credentials, which the team would prefer to avoid. Each project team should have full control over their pull secrets.
> Alternatively, if pull secrets were automatically set up and managed by ArgoCD for project teams, that would interfere with teams managing secrets on their own.
> The Platform Services Team will consider options for this in the future, but for now will not manage pull secrets for teams.

What I meant with pre-configured pull-secret is what @WadeBarnes described above, which is linking it to the default service account for the namespace. That I all I believe is needed for image pulls to succeed with Artifactory, and it looks like a similar situation to `1` to me.

Updates to the docs are definitely always welcome, I admit though that the above points/ideas came up (at least for me) after several years of working on the platform when we switched to OCP4 and things didn't "just work" because I was missing steps that, while they could be documented in the onboarding process, would have been skipped anyway as technically I was not really onboarding again 😅 (trying to provide some additional context in case it can be helpful to tackle the items and/or update docs more effectively).

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) commented at [2021-06-02 20:20](https://github.com/BCDevOps/OpenShift4-Migration/issues/73#issuecomment-853356888):

@j-pye What is your opinion about whether pull secrets should or should be managed by ArgoCD?

#### <img src="https://avatars.githubusercontent.com/u/10504350?v=4" width="50">[Wade Barnes](https://github.com/WadeBarnes) commented at [2021-06-04 13:10](https://github.com/BCDevOps/OpenShift4-Migration/issues/73#issuecomment-854712740):

There is an automated process for provisioning a set of credentials for Artifactory in the `tools` environments, I don't think it would be too much effort to enhance that process to do what my scripts do; create the associated pull secrets and register them with the appropriate service accounts.

#### <img src="https://avatars.githubusercontent.com/u/10466412?v=4" width="50">[Cailey Jones](https://github.com/caggles) commented at [2021-06-04 20:02](https://github.com/BCDevOps/OpenShift4-Migration/issues/73#issuecomment-854969874):

I agree that making the Artifactory pull secret process transparent to teams is a good idea, but I do not think this is the best way to do it. ArgoCD would not be involved in the creation of these additional pull secrets and service account bindings - ArgoCD only makes a ArtifactoryServiceAccount object. If we were the implement something like this, it would more likely work so that any new ArtifactoryServiceAccount object (default or otherwise) could (perhaps optionally?) create all of these links between the various namespaces and service accounts through the Archeobot operator. 

The problem with this method is that this means that the operator manages a significantly increased number of total objects, with the objects existing in namespaces that where the CR does not exist, and assumes that the CR must exist in a tools namespace. This means increasing the load on the Platform Team, because suddenly a large number of secrets and service accounts are our responsibility to maintain. It means the load on the operator increases. It's not a good practice to have the operator manage objects related to a CR that doesn't live in the same namespace as the CR (because a CR in tools would now be linked to a service account in prod, for example). We could avoid this by creating different ArtifactoryServiceAccounts in each of the 4 namespaces as part of standard provisioning, but that would increase the load on the operator even more. 

And, on a more philosophical note, I don't know that something like this _should_ be transparent. I don't think we want to take ownership of things in a team's namespace, but that's what it means to make something transparent - "this isn't your problem anymore, we'll take care of it." I like the idea of transparency for things like this, don't get me wrong, I just don't think we should be implementing said transparency by taking on responsibility for objects that live in namespaces. If we create transparency, we should work hard to make sure that we're doing it through cluster settings, instead of fudging with the namespaces and then telling the teams that they don't need to understand what we've done. The namespace is theirs - they should understand everything going on within it. That's part of the reason _why_ the default ArtifactoryServiceAccount is so barebones - it's not supposed to do a bunch of stuff for the teams, because it's an object in the namespace and therefore should be owned primarily by the team. If we make that default ArtifactoryServiceAccount in tools completely transparent, then it doesn't matter if we say the object is owned by the team - the fact of the matter is that it's on us to make sure it does what the team needs it to do.

That's why, instead, we are currently investigating the possibility of creating a cluster-wide default account for Artifactory which would grant access to the caching repos. This way, teams wanting to use that account would be able to do so (but only for caching repos - ones local private repos become available, they would need to make their own ArtifactoryServiceAccount to make use of them). This would reduce the amount of load on the operator (since provisioning a separate account in each tools namespace is not longer necessary) and would reduce the load on the Platform Team (since now there's just the one default account that we're responsible for) and any team that wants to use their own separate accounts for greater security is still absolutely free to do so. And it avoids the pitfall of us taking on ownership and responsibility for objects in a team's namespace, because this is a cluster setting and therefore _should_ be our responsibility.

#### <img src="https://avatars.githubusercontent.com/u/2395873?v=4" width="50">[Emiliano Suñé](https://github.com/esune) commented at [2021-06-07 18:30](https://github.com/BCDevOps/OpenShift4-Migration/issues/73#issuecomment-856165792):

Thanks for the detailed explanation @caggles, what you're bringing up makes sense to me.
And just to clarify: my point was just to facilitate a pattern that is recommended, if not somewhat enforced, for BCGov projects - not trying to shift responsibility between patform and every team.

#### <img src="https://avatars.githubusercontent.com/u/5686801?v=4" width="50">[Justin Pye](https://github.com/j-pye) commented at [2021-06-07 22:17](https://github.com/BCDevOps/OpenShift4-Migration/issues/73#issuecomment-856299873):

> @j-pye What is your opinion about whether pull secrets should or should be managed by ArgoCD?

**TL;DR: No**. Archeobot could link the secret to any service accounts for building but shouldn't touch any other namespace aside from tools. A cluster wide pull secret for the cache would be useful and reduce the issues we have with DockerHub limit spam in the event logs. (I've done this with other registries that require credentials). We could create something to automate the linking of service accounts for pulling from tools to the other environments but this should be outside of Archeobot and ArgoCD so that teams can opt-in and out. (Thinking out loud: A stand alone operator might be an option but further discussion is required and for now I'd consider Wade's script a good team driven option)

@mitovskaol While there are things we can do with ArgoCD to link the artifactory secret to the default service account, this is a feature for the Archeobot (Artifactory Operator). This is something that could be added to the ArtifactoryServiceAccount object. This is because we don't know the secret name at provisioning, when an ArtifactoryServiceAccount object is created in the tools namespace Archeobot picks it up and generates the credentials (secret) in that namespace with a unique name. This means ArgoCDs provisioning rate (sync) would be tied to the speed of Archeobot. To add to that, it's also not simple to patch core OpenShift objects with ArgoCD such as the default service account.  

**EDIT**: Just read @caggles response, I agree that the linking between namespaces should not be on Archeobot, I wouldn't be against linking the ArtifactoryServiceAccount to the builder service account though for any build related tasks. As Cailey said, we're working on performance improvements for that specific operator though so this is not the time to add this feature. 

> > 1) Preconfigured role bindings
> > Not all teams use the tools/dev/test/prod model and the Platform Services Team prefers that role bindings be managed by project teams.
> 
> I wasn't aware this was (still) possible, as I was under the impression that the tools/dev/test/prod pattern was strongly recommended, if not even enforced in some way. I would play devil's advocate and say that if the majority of teams is following this pattern, it might be beneficial to have the role bindings pre-populated based on the recommended behaviour. I might however be missing something that could cause grief in the long term.

@esune @mitovskaol This is a good point. We should probably create a document noting what is and isn't enforced for project sets. The tools/dev/test/prod namespaces are the static project set structure, along with the default deny Network Policies. How those namespaces are used is up to the team using them though. We try to enforce as little as possible. Unless you're causing issues for others, I doubt we'll reach out to enforce specific usage of the namespaces.

Our training materials are often geared towards that default 4 namespace structure and use though so there's benefit in sticking with the default structure/usage so you don't have to come up with workaround to fit custom use.

To your last point in the issue body, I also don't like the extra clicks to get my token but you can bookmark the token page and go straight to it if that helps.


-------------------------------------------------------------------------------

# [\#72 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/72) `open`: Does OCP4 have a internal DNS Wildcard?

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) opened issue at [2021-01-27 19:36](https://github.com/BCDevOps/OpenShift4-Migration/issues/72):

In OCP3 there was a DNS wildcard for `*.pathfinder.bcgov`, is there an equivalent for OCP4?

As of Jan 27th 2021 there is now a DNS record for `*.silver.devops.bcgov` pointing at the same load balanced VIP as `*.apps.silver.devops.gov.bc.ca`.

### Warnings

This exists to smooth like-for-like migrations from OCP3 and **is not a recommended long-term architecture**.

Using cluster named DNS entries like `*.silver.devops.bcgov` or `*.apps.silver.devops.gov.bc.ca` makes future changes to your apps more complex as target clusters change. It is better to get a subdomain of gov.bc.ca (e.g. `myapp.gov.bc.ca` or a "vanity name" e.g. `myapp.ca` if this is the team's preferences) that is **owned and managed by your application team** and can be easily repointed should you later move to the GOLD cluster, or to a Azure based cluster. Subdomains of gov.bc.ca can be public or an internal `myapp.myministry.gov.bc.ca`.

The default TLS cert used by the router is for `*.apps.silver.devops.gov.bc.ca` and does not list `*.silver.devops.bcgov` since 2015 TLS certs signed by publicly trusted certificate authorities are not allowed to list internal DNS names. https://cabforum.org/internal-names/ . Your application will either need to ignore the invalid cert, or use a custom self-signed cert added to your route. https://docs.openshift.com/container-platform/4.5/networking/routes/secured-routes.html

Internal DNS names provide very little additional security over the public DNS names. As the IP of the OCP ingress is on the public internet, and it just routes based on `Host:` headers, it is very easy to add a entry to your local `/etc/hosts` file and access an internal DNS named application. `myobscureapp.apps.silver.devops.gov.bc.ca` is equally obscure and un guessable as `myobscureapp.silver.devops.bcgov` for an attacker trying to find your route if it's not published publicly.

#### <img src="https://avatars.githubusercontent.com/u/31288809?v=4" width="50">[Ryan Loiselle](https://github.com/rloisell) commented at [2021-01-28 00:30](https://github.com/BCDevOps/OpenShift4-Migration/issues/72#issuecomment-768669739):

I would like to comment that the general barrier to a myapp.gov.bc.ca vanity domain is that it requires GCPE approvals, and is often a challenge to acquire without a supporting business case (for the naming selected). Mapping under a ministry subdomain myapp.ministry.gov.bc.ca does not have that same barrier to entry and is often an option within the control of each ministry.

CC: @juhewitt 

PS. Thank you for enabling migrations while we address issues with how to approach this in the new cluster.

#### <img src="https://avatars.githubusercontent.com/u/15350676?v=4" width="50">[Justin Hewitt](https://github.com/juhewitt) commented at [2021-01-28 01:13](https://github.com/BCDevOps/OpenShift4-Migration/issues/72#issuecomment-768685784):

@rloisell I'm working on getting some support from GCPE on specific language and standards, that I co-created with them for transparency sakes.  everything you wrote is exactly by design... once you get your subdomain in place through GCPE, you are on your way for all subdomains within... it's the first one... so trying to see if I can get some language to set expectations to make it easier for everyone


-------------------------------------------------------------------------------

# [\#71 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/71) `open`: What timezone is used for CronJob schedules?

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) opened issue at [2021-01-27 19:13](https://github.com/BCDevOps/OpenShift4-Migration/issues/71):

OCP4 uses UTC for CronJob schedules.

https://access.redhat.com/solutions/4479091




-------------------------------------------------------------------------------

# [\#70 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/70) `open`: OCP4 GUI BUG - Role Bindings and Project Access under Developer view

#### <img src="https://avatars.githubusercontent.com/u/31288809?v=4" width="50">[Ryan Loiselle](https://github.com/rloisell) opened issue at [2021-01-26 23:12](https://github.com/BCDevOps/OpenShift4-Migration/issues/70):

There are multiple options for provisioning RBAC and User Access to namespaces in OCP 4. It can be done via Administrator view, Developer view, via the API as distinct commands, or via yml files applied via the CLI. 

There is a bug in the Developer view of Project Access that only displays the first user of a particular role type, if those users have been added on the CLI via a YML file, via the project registry, or the Admin GUI. 

For the examples below, if applied from the CLI with:

% oc apply -f <file>-access.yml

You will only be able to see the "bcdevops-admin", "dev1", and "govemp1" users from the Developer Project Access View. The CLI and the Administrator view will both display the appropriate information and Role Bindings. 

This bug is of concern as it does not provide an accurate view of the RBAC that have been provisioned via the CLI from yml templates. In multiple projects this has led to duplication of users being provisioned as the view as to who has been provisioned is not consistent depending on where you were looking. 


Sample YML Files:

% more developer-access.yml 
```yaml
apiVersion: v1
items:
- apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: nttdevops
  roleRef:
    kind: ClusterRole
    name: admin
  subjects:
  - kind: User
    name: dev1@github
  - kind: User
    name: dev2@github
  - kind: User
    name: dev3@github 
  - kind: User
    name: dev4@github
kind: List
```

% more sector-access.yml 
```yaml
apiVersion: v1
items:
- apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: sectoradmin
  roleRef:
    kind: ClusterRole
    name: admin
  subjects:
  - kind: User
    name: govemp1@github
  - kind: User
    name: govemp2@github 
  - kind: User
    name: govemp3@github 
kind: List
```

Screen Shots provided to Platform Services team via email to protect identity of those with privileged levels of access. 

#### <img src="https://avatars.githubusercontent.com/u/31288809?v=4" width="50">[Ryan Loiselle](https://github.com/rloisell) commented at [2021-01-26 23:13](https://github.com/BCDevOps/OpenShift4-Migration/issues/70#issuecomment-767891051):

CC: @juhewitt @mitovskaol @NickCorcoran

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) commented at [2021-02-01 19:47](https://github.com/BCDevOps/OpenShift4-Migration/issues/70#issuecomment-771112032):

I've opened https://access.redhat.com/support/cases/#/case/02858257 with Red Hat to report this issue.

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) commented at [2021-02-02 16:51](https://github.com/BCDevOps/OpenShift4-Migration/issues/70#issuecomment-771782346):

This is a known bug, and scheduled to be fixed in 4.7 https://bugzilla.redhat.com/show_bug.cgi?id=1906898

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) commented at [2021-02-03 16:43](https://github.com/BCDevOps/OpenShift4-Migration/issues/70#issuecomment-772651021):

Bug to track backporting to 4.6 https://bugzilla.redhat.com/show_bug.cgi?id=1924437

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) commented at [2021-03-12 16:41](https://github.com/BCDevOps/OpenShift4-Migration/issues/70#issuecomment-797610587):

The version 4.6.20 provides the fix of https://github.com/openshift/console/pull/8034 https://access.redhat.com/errata/RHBA-2021:0674 and is now available.

So we should pick this up when we upgrade next quarter.


-------------------------------------------------------------------------------

# [\#69 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/69) `open`: Sysdig: cannot share notification channels across teams

#### <img src="https://avatars.githubusercontent.com/u/26367840?v=4" width="50">[Dylan Leard](https://github.com/dleard) opened issue at [2021-01-25 21:11](https://github.com/BCDevOps/OpenShift4-Migration/issues/69):

I have been configuring our notification channels & I have noticed that when creating a channel the 'shared with' option is disabled and defaults to the team I am currently using. In the documentation it appears to be a dropdown https://docs.sysdig.com/en/email-notifications.html

We are managing 3 separate namespaces, which means we have 3 different teams set up in sysdig (one for each ns). It would be great if (if possible) we could create one notification channel that can be used across the 3 different teams rather than creating a separate (identical) channel for each team.

Current behaviour: The 'shared with' option when creating a notification channel is disabled and defaults to current team.

Desired behaviour: The 'shared with' option would allow the selection of a set of teams to share one notification channel.




-------------------------------------------------------------------------------

# [\#68 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/68) `open`: My app experiences periodic connectivity issues with connections to Patroni pod, what should I do?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2021-01-19 21:54](https://github.com/BCDevOps/OpenShift4-Migration/issues/68):

**What is happening?**

There have been reports on the OCP 4 Silver cluster of connectivity issues  affecting the connections from other pods (e.g. backup contains, api pods) to Patroni database pods. No other types of pods seem to be affected.
The database pods seems to be running fine, but other pods are not able to connect to it. It may result in the other pods failing liveliness checks or just throwin `Connection time out` errors. Once the database pod was recycled - either manually or automatically after some time - the other pods were able to connect to it again.

**Why is it happening?**
The possible root cause of the issue has been traced to the Aporeto, Software Defined Network (SDN) Solution running in the Silver cluster. Aporeto seems to be ocassionally removing the Processing Units (PU) labels from the Patroni pods which prevents the Network Security Policies (NSP) attached to the pod from being enforced and therefore all communications to and from the pods are blocked according to the Zero-Trust Model principle.

**What can I do?**
We highly recommend to have health checks (readiness probes) set up for **all pods connecting to Patroni database pods** and make sure they are checking **all dependencies** required for healthy operations for a pod including **connections to other pods and external databases**.  If a health check detects an connection issue, delete and re-created the affected database pod. Increase the number of replicas to make the app more resilient to a failure of one database pod (at minimum 3 replica pods are recommended).

**What can Platform Services do?**
We are working with Aporeto on releasing the fix for the removed PU labels, and expect it roll it out in Silver before the end of the week of Jan 18. 




-------------------------------------------------------------------------------

# [\#67 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/67) `open`: Cannot provide jenkins service account with permission to image pull & build on dev namespace

#### <img src="https://avatars.githubusercontent.com/u/9897282?v=4" width="50">[AJ Po-Déziel](https://github.com/ajdeziel) opened issue at [2021-01-18 21:49](https://github.com/BCDevOps/OpenShift4-Migration/issues/67):

I have been attempting to build & deploy using the `jenkins` service account from my `tools` namespace into my `dev` namespace. However, I keep encountering this error when pulling in base images from my `tools` namespace into `dev`:

```none
Pulling image image-registry.openshift-image-registry.svc:5000/9c33a9-tools/aspnet:3.1 ...
Warning: Pull failed, retrying in 5s ...
Warning: Pull failed, retrying in 5s ...
Warning: Pull failed, retrying in 5s ...
error: build error: failed to pull image: After retrying 2 times, Pull image still failed due to error: unauthorized: authentication required
error: the build 9c33a9-dev/dotnet-webapi-develop-temp-ocp4-9 status is "Failed"
```

To resolve this, I tried to perform the following with no success:
* Provide the service account with the `system:image-puller` and `system:image-builder` role binding in my `dev` namespace.
* Ensuring that the NSPs across `dev` and `tools` are able to talk with one another.

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) commented at [2021-01-19 00:43](https://github.com/BCDevOps/OpenShift4-Migration/issues/67#issuecomment-762531978):

1. Shouldn't builds be happening in `9c33a9-tools` ?
2. The `jenkins` SA interacts with the BuildConfig objects to trigger new builds, but the builds themselves run as the `builder` SA.
3. So the service account `9c33a9-dev/builder` needs `system:image-puller` RoleBinding in `9c33a9-tools`

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: jenkins-image-puller
  namespace: 9c33a9-tools
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:image-puller
subjects:
- kind: ServiceAccount
  name: builder
  namespace: 9c33a9-dev
- kind: ServiceAccount
  name: builder
  namespace: 9c33a9-test
- kind: ServiceAccount
  name: builder
  namespace: 9c33a9-prod
```

/cc @jleach in case I missed anything

#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) commented at [2021-01-19 17:50](https://github.com/BCDevOps/OpenShift4-Migration/issues/67#issuecomment-763011296):

@ajdeziel Steven helped explain what you're up to to me. Its pretty strange to have buildconfig in `dev`. We created a `tools` space because that's where they're meant to run. Not saying you can't do it, but when you try and do special config like this it does require some NSP and RBAC considerations. Any reason you need to do the build in `dev`?

#### <img src="https://avatars.githubusercontent.com/u/9897282?v=4" width="50">[AJ Po-Déziel](https://github.com/ajdeziel) commented at [2021-01-19 18:19](https://github.com/BCDevOps/OpenShift4-Migration/issues/67#issuecomment-763029970):

@jleach The pipeline was originally constructed in this manner on OCP 3, and I was attempting a lift and shift of it to OCP 4 for simplicity's sake. Is the idea of building it in tools that you can then promote images across environments more easily? Our current pipeline's methodology isolates builds & deploys to their respective space for the purpose of having clear separation between each stage of development.

#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) commented at [2021-01-19 23:03](https://github.com/BCDevOps/OpenShift4-Migration/issues/67#issuecomment-763198770):

@ajdeziel I think its easier. What might be the easies build an store the images in tools; then just source them from your deployment. I typically use the tag "latest"  for dev, "test" for test and "prod" for prod. Then when the deployment detects that image in tools wit will trigger a deployment. Works great, pretty simple.

EDIT: It's also a common pattern so a bit easier to help with.


-------------------------------------------------------------------------------

# [\#66 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/66) `closed`: Finding that NSPs currently are taking over 5 minutes to delete

#### <img src="https://avatars.githubusercontent.com/u/23747270?v=4" width="50">[ikethecoder](https://github.com/ikethecoder) opened issue at [2021-01-15 18:42](https://github.com/BCDevOps/OpenShift4-Migration/issues/66):

As the title states.. just deleted an NSP and it took 6m40s.

Namespace: 264e6f-dev
NSP: proto-aps-portal-feature-test
Ran: 10:30am






-------------------------------------------------------------------------------

# [\#65 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/65) `open`: Documentation on Artifactory and S2I
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/58346777?v=4" width="50">[Jeremy Vernon](https://github.com/jeremy-vernon-bcgov) opened issue at [2021-01-08 20:20](https://github.com/BCDevOps/OpenShift4-Migration/issues/65):

Hello,

As per this thread: https://chat.pathfinder.gov.bc.ca/channel/devops-how-to?msg=Lnf9Hb2dDKa36XTed
and this thread: https://chat.pathfinder.gov.bc.ca/channel/devops-artifactory?msg=mzGB3gJhw9RkkYPNR

To get Artifactory to work I followed the tutorial but did have the following stumbling blocks:

1) I think since we're an older tenant the name for our artifactory service account secret didn't match the format indicated in the tutorial (which is the newer, more legible, construction). I eventually saw the thread where that change was explained which got me past the first paragraph...until.

2) When using the S2I build strategy on my *-test namespace after following the tutorial, builds would fail at the "pull builder image" step - with an error indicating that authentication failed.  This is because I had linked the pull secret to the builder user in the *-tools namespace but not the *-test namespace. `oc project b07dd3-test` -> `oc secrets link default <secret-name>` & `oc secrets link builder <secret-name>` ... resolved the issue.




-------------------------------------------------------------------------------

# [\#64 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/64) `open`: Network Security Policy and External Network Examples and Management Strategy
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/10504350?v=4" width="50">[Wade Barnes](https://github.com/WadeBarnes) opened issue at [2021-01-07 14:16](https://github.com/BCDevOps/OpenShift4-Migration/issues/64):

The combination of External Network and Network Security Policy resources can be used to control access from a given pod/namespace out to external network resources.  Following are some examples.  The BC Government's OCP environment also does a much better job at DNS resolution, allowing host names to be defined via DNS names rather than IP addresses in many cases.

### Allow a backup-container to post notifications to rocket.chat:
- The template for this can be found here; https://github.com/bcgov/family-law-act-app/blob/master/openshift/templates/backup/backup-deploy.yaml#L7
```
kind: ExternalNetwork
  name: backup
  namespace: 09e0c5-dev
spec:
  description: |
    Define the network parameters for accessing remote resources.
  entries:
  - chat.pathfinder.gov.bc.ca
  servicePorts:
  - tcp/443

kind: NetworkSecurityPolicy
  name: backup
  namespace: 09e0c5-dev
spec:
  description: |
    Allow the backup-container to access the application's database for backup purposes, as well as access to rocket.chat to log notifications.
  destination:
  - - role=db
    - app=fla
    - env=dev
    - $namespace=09e0c5-dev
  - - ext:name=backup
  source:
  - - role=backup
    - app=Backup
    - env=dev
    - $namespace=09e0c5-dev
```

### Allow a pod to access KeyCloak and other Organization specific resources:
```
kind: ExternalNetwork
  name: web
  namespace: 9b71af-dev
spec:
  description: |
    Define the network parameters for accessing remote resources.
  entries:
  - wsgw.dev.some.org.ca
  - dev.oidc.gov.bc.ca
  - logontest.gov.bc.ca
  servicePorts:
  - tcp/443

kind: NetworkSecurityPolicy
  name: web
  namespace: 9b71af-dev
spec:
  description: |
    Allow the application to access a defined set of external resources.
  destination:
  - - ext:name=web
  source:
  - - role=web
    - app=a2a
    - env=dev
    - $namespace=9b71af-dev
```

#### The template snippets for the above configurations:
```
  - kind: ExternalNetwork
    apiVersion: security.devops.gov.bc.ca/v1alpha1
    metadata:
      name: ${NAME}${SUFFIX}
      network: ${NAME}${SUFFIX}
      labels:
        name: ${NAME}${SUFFIX}
        network: ${NAME}${SUFFIX}
        app: ${APP_NAME}${SUFFIX}
        app-group: ${APP_GROUP}
        env: ${TAG_NAME}
    spec:
      description: |
        Define the network parameters for accessing remote resources.
      entries:
        - ${API_SERVER_HOST}
        - ${KEYCLOAK_HOST}
        - ${SITEMINDER_LOGOUT_HOST}
      servicePorts:
        - tcp/443

  - kind: NetworkSecurityPolicy
    apiVersion: security.devops.gov.bc.ca/v1alpha1
    metadata:
      name: ${NAME}${SUFFIX}
      labels:
        name: ${NAME}${SUFFIX}
        app: ${APP_NAME}${SUFFIX}
        app-group: ${APP_GROUP}
        env: ${TAG_NAME}
    spec:
      description: |
        Allow the application to access a defined set of external resources.
      source:
        - - role=${ROLE}
          - app=${APP_NAME}${SUFFIX}
          - env=${TAG_NAME}
          - $namespace=${NAMESPACE_NAME}-${TAG_NAME}
      destination:
        - - ext:name=${NAME}${SUFFIX}
```

### Other Examples
#### Access to an external oracle database:
*The IP in this example was randomly generated for demo purposes*
```
kind: ExternalNetwork
metadata:
  name: fdw-primary
  namespace: 7cba16-dev
spec:
  description: |
    Define the network parameters for accessing the remote database.
  entries:
  - 217.5.215.0/24
  servicePorts:
  - tcp/1521
```
#### Access to an Indy Blockchain Ledger:
```
kind: ExternalNetwork
  name: indy-agent
  namespace: 7cba16-dev
spec:
  description: |
    Define the network parameters for accessing remote agents.
  entries:
  - 0.0.0.0/0
  servicePorts:
  - tcp/9700:9799
  ```
### Managing creation/update of Network Security Policy and External Network resources:

Network Security Policy and External Network resources are defined statically, meaning you can not use something like,
```
 valueFrom:
      secretKeyRef:
        ....     
```
to dynamically reference a secret.

In order to better facilitate the management of the parameters for such resources, the [BCDevOps/openshift-developer-tools](https://github.com/BCDevOps/openshift-developer-tools/tree/master/bin) have been updated to allow hostname parameters to be parsed from user provided endpoints, be stored in secrets, and then read back from secrets during updates.  Allowing the static resources to be updated, while the settings are retained.

Examples of this can be found here:
- [Hostname parameter in External Network definition](https://github.com/bcgov/family-law-act-app/blob/master/openshift/templates/backup/backup-deploy.yaml#L22)
- [Storage in secret](https://github.com/bcgov/family-law-act-app/blob/master/openshift/templates/backup/backup-deploy.yaml#L99)
- [Population of hostname from user provided endpoint](https://github.com/bcgov/family-law-act-app/blob/master/openshift/templates/backup/backup-deploy.overrides.sh#L29)
- [Hostname read from secret during update](https://github.com/bcgov/family-law-act-app/blob/master/openshift/templates/backup/backup-deploy.overrides.sh#L36)

The resulting create and update flows then look like this:

**Create:**
```Wade@hvWin10x64 MINGW64 /c/family-law-act-app/openshift (master)
$ genDepls.sh -e dev -c backup

Loading settings ...
Loading settings from /c/family-law-act-app/openshift/settings.sh ...

Switching to 09e0c5-dev ...

Configuring the dev environment for . ...

Processing deployment configuration; ../openshift/templates/backup/backup-deploy.yaml ...

Reading config from ../openshift/templates/backup/backup-deploy.param ...

Reading config from ../openshift/templates/backup/backup-deploy.dev.param ...
Loading parameter overrides for ../openshift/templates/backup/backup-deploy.yaml ...

Initializing backup-deploy.overrides ...

Generating ConfigMap; backup-conf ...

WEBHOOK_URL - Please provide the webhook endpoint URL.  If left blank, the webhook integration feature will be disabled:
https://chat.pathfinder.gov.bc.ca/hooks/...

Parsing WEBHOOK_URL_HOST from WEBHOOK_URL; 'https://chat.pathfinder.gov.bc.ca/hooks/...' => 'chat.pathfinder.gov.bc.ca' ...

...

Removing temporary param override files ...
        Deleting override param file; ./backup-deploy.overrides.param ...

Deploying deployment configuration files ...

...
```

**Update:**
```
Wade@hvWin10x64 MINGW64 /c/family-law-act-app/openshift (master)
$ genDepls.sh -e dev -c backup -u

Loading settings ...
Loading settings from /c/family-law-act-app/openshift/settings.sh ...

Switching to 09e0c5-dev ...

Configuring the dev environment for . ...

Processing deployment configuration; ../openshift/templates/backup/backup-deploy.yaml ...

Reading config from ../openshift/templates/backup/backup-deploy.param ...

Reading config from ../openshift/templates/backup/backup-deploy.dev.param ...
Loading parameter overrides for ../openshift/templates/backup/backup-deploy.yaml ...

Initializing backup-deploy.overrides ...

Generating ConfigMap; backup-conf ...

Update operation detected ...
Skipping the prompts for the WEBHOOK_URL secret ...

Getting WEBHOOK_URL_HOST for the ExternalNetwork definition from secret ...

Preparing deployment configuration for update/replace, removing any 'Secret' objects so existing values are left untouched ...

...

Removing temporary param override files ...
        Deleting override param file; ./backup-deploy.overrides.param ...

Deploying deployment configuration files ...

...
```




-------------------------------------------------------------------------------

# [\#63 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/63) `open`: I have accidentally deleted my artifactory-creds secret from my tools project. How can I restore it?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2021-01-05 19:56](https://github.com/BCDevOps/OpenShift4-Migration/issues/63):

The long-term solution for this problem is to find the ArtifactoryServiceAccount object in your tools namespace and delete it. The project provisioner will recreate it for you.

However, at the moment, there are some privilege problems with that object where the admin of the namespace should be able to view and delete it, but cannot. We are still investigating this problem so, for the time being, please post in #devops-artifactory or #devops-ocp4-migration to ask for help with someone who has permissions to delete the object for you.

#### <img src="https://avatars.githubusercontent.com/u/10466412?v=4" width="50">[Cailey Jones](https://github.com/caggles) commented at [2021-01-05 19:59](https://github.com/BCDevOps/OpenShift4-Migration/issues/63#issuecomment-754865220):

The solution here is to find the ArtifactoryServiceAccount object in your tools namespace and delete it. The project provisioner will recreate it for you.

However, at the moment, there are some privilege problems with that object where the admin of the namespace _should_ be able to view and delete it, but cannot. We are still investigating this problem so, for the time being, please post in #devops-artifactory or #devops-ocp4-migration to ask for help with someone who has permissions to delete the object for you.


-------------------------------------------------------------------------------

# [\#61 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/61) `open`: Best practices for graceful terminations

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) opened issue at [2020-12-11 23:44](https://github.com/BCDevOps/OpenShift4-Migration/issues/61):

There was lots of good discussion on https://github.com/BCDevOps/developer-experience/pull/766 from @wenzowski , but nothing truly blocking on that PR. In an effort to get it merged, but not lose that discussion, lets continue here.

- What is the correct balance of timings to ensure that patching doesn't take forever, and applications are able to gracefully terminate?
- Anything we can add to the docs on best configs for apps? How to ensure your container handles `SIGTERM` properly? Reduce or eliminate errors for end users of the application?




-------------------------------------------------------------------------------

# [\#60 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/60) `open`: How do I move data between clusters?

#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) opened issue at [2020-12-11 21:15](https://github.com/BCDevOps/OpenShift4-Migration/issues/60):

OpenShift 4.5+ (Silver Cluster) comes with an image `openshift/cli` in the `openshift` namespace. You can spin one up on the Silver cluster, `oc logon` to the Pathfinder (3.11) cluster, and then do commands like `oc rsync` to copy data from Pathfinder to a PVC mounted on your `openshift/cli` Pod.

The command below will help you get started. If you don't want the pod to be **deleted** when it exits remove the argument `--rm=true` or set it to `--rm=false`.

```console
oc run -i -t mycli \
--image=image-registry.openshift-image-registry.svc:5000/openshift/cli:latest \
--restart=Never \
--command=true \
--rm=true \
-- /bin/bash
```

Once the pod is started you can `export HOME=/tmp` and then `oc login` as normal.

**ProTip**
You can use this container for other things like CronJobs, etc.




#### <img src="https://avatars.githubusercontent.com/u/22400069?v=4" width="50">[Jeff](https://github.com/jefkel) commented at [2020-12-22 20:10](https://github.com/BCDevOps/OpenShift4-Migration/issues/60#issuecomment-749753054):

For some templates and step by step samples for copying data between clusters, head on over to the [BCDevOps/StorageMigration/CrossClusterDataSteps](https://github.com/BCDevOps/StorageMigration/blob/master/CrossClusterDataSteps.md) walkthrough in the [StorageMigration](https://github.com/BCDevOps/StorageMigration) repo.

The walkthrough includes templates to build and deploy a migration pod (that mounts your PVC), as well as how to run an `oc rsync` from a pod in Cluster A to a pod in Cluster B.


-------------------------------------------------------------------------------

# [\#59 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/59) `open`: My app stores large amounts of data, what storage options are available in OCP 4?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-12-09 19:23](https://github.com/BCDevOps/OpenShift4-Migration/issues/59):

For the applications that need to store large amounts of data - beyond the storage allocation included in the `medium` size quota as defined [here](https://app.zenhub.com/workspaces/openshift-4-build-out-5db73142897668000144f22b/issues/bcdevops/openshift4-rollout/254) - we recommend using the S3-compliant on-prem [**Object Storage Service**](https://ssbc-client.gov.bc.ca/services/ObjectStorage/overview.htm) offered by OCIO's Hosting Branch for storing **unstructured data** such as images, pdfs and other types of files. The NetApp storage offered on the OCP4 Platform is **not suitable** for storing large amounts of unstructured data. The NetApp storage should only be used for structured data such as databases that require high-I/O workloads. 

 **Please contact your Ministry IMB to get access to the Ministry service account** that controls access to the <ministry_name>.objectstrorage.gov.bc.ca namespace in the S3 storage where a bucket for your app will be provisioned. 

Object Storage Service is highly fault tolerant using erasure coding within the cluster, as well as asynchronous replication and automatic failover to the Calgary data center The solution also allows offers configurable object versioning, allowing for file recovery. Due to the high fault tolerance, versioning, and redundancy, most teams  do not implement additional backups. A recommended design pattern would be to replace the app's Minio storage with the direct integration with the S3 API within the Object Storage Enterprise Services.

NRM has had significant experience with the Object Storage service and kindly shared their [collection of tips and tricks and best practices](https://apps.nrs.gov.bc.ca/int/confluence/display/OPTIMIZE/NRS+Object+Storage) for how to work with the Object Storage Enterprise Service, with the Platform Community. 🙏

Our own Artifactory service in the Silver cluster leverages the Object Storage Service behind the scene as image storage (ping @caggles if you have any question about the Artifactory setup).  

You can connect with other teams that are working with the Object Storage Service in the **#object-storage** channel in RocketChat!


#### <img src="https://avatars.githubusercontent.com/u/58020382?v=4" width="50">[ccocker-hub](https://github.com/ccocker-hub) commented at [2020-12-10 00:41](https://github.com/BCDevOps/OpenShift4-Migration/issues/59#issuecomment-742156215):

Thanks for this - if you are working in the NRS Namespace, please follow the '[How to Request Object Storage](https://apps.nrs.gov.bc.ca/int/confluence/display/OPTIMIZE/How+to+Request+Object+Storage)'  instructions on the page through the NRM Business Service Desk.

#### <img src="https://avatars.githubusercontent.com/u/22400069?v=4" width="50">[Jeff](https://github.com/jefkel) commented at [2020-12-22 20:20](https://github.com/BCDevOps/OpenShift4-Migration/issues/59#issuecomment-749757352):

Cross posting from @BcGovNeal for an S3 mirroring walkthrough:
https://github.com/BCDevOps/OpenShift4-Migration/issues/9#issuecomment-723287484

> I have created a very simple Docker image layered on top of the official Minio Client docker image to assist Minio data migration between clusters.
> 
> This image can be run on OpenShift to enable cluster to cluster data migration.
> 
> The documentation ca be found in my repo at https://github.com/BcGovNeal/minio-client


-------------------------------------------------------------------------------

# [\#58 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/58) `open`: Are there best development practices for cloud native apps in Openshift?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-12-09 01:00](https://github.com/BCDevOps/OpenShift4-Migration/issues/58):

Yes, check out these resources in DevHub
 - [Resiliency Guidelines](https://developer.gov.bc.ca/Resiliency-Guidelines)
 - [Resource Tuning Recommendations](https://developer.gov.bc.ca/Resource-Tuning-Recommendations)
 - [Post-Outage Checklist](https://developer.gov.bc.ca/Post-Outage-Application-Health-Checklist)

 and [this article](https://www.openshift.com/blog/14-best-practices-for-developing-applications-on-openshift) from RedHat
and the classic [12-factor app design principles](https://12factor.net/)




-------------------------------------------------------------------------------

# [\#57 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/57) `open`: How do I request a gov.bc.ca subdomain for my app in OCP 4?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-12-03 19:25](https://github.com/BCDevOps/OpenShift4-Migration/issues/57):

All apps hosted in OCP 4 Platforms are expected to have a gov.bc.ca subdomain (e.g. myapp.gov.bc.ca) in order to reduce their ties to the cluster-specific DNS and increase their portability within the multi-cluster OCP 4 Platform. While the wildcard DNS is now supported in the OCP 4 Silver cluster as per [#72](https://github.com/BCDevOps/OpenShift4-Migration/issues/72), it has been implemented as a temporary solution to enable the teams to move ahead with their migration while they are waiting for the iStore order for their gov.bc.ca subdomain to be processed. 

The process of request a new gov.bc.ca subdomain for CITZ projects:

1. Ask the Ministry contact for GCPE for approval on URL name
2. Order (via iStore), the SSL Certificate (Fillout a SSL request form without WAM required and attach to SSL Certificate)
Info: https://ssbc-client.gov.bc.ca/services/SSLCert/overview.htm and https://ssbc-client.gov.bc.ca/services/SSLCert/documents.htm
3. Send a note to DNSRequest@gov.bc.ca to create dns entry with new URL and point to OCP4
4. Once you receive a note from SSL folks, you will need to send them a CSR.
5. They will send you the Certificate

For everybody else,  submit a Web Property Application to the GCPE Joint Delivery Working Group as described [here](https://www2.gov.bc.ca/gov/content/governments/services-for-government/service-experience-digital-delivery/digital-delivery/web-property-process/web-property-applications).

#### <img src="https://avatars.githubusercontent.com/u/19917617?v=4" width="50">[Karim Gillani](https://github.com/gil0109) commented at [2020-12-04 02:43](https://github.com/BCDevOps/OpenShift4-Migration/issues/57#issuecomment-738524890):

For CITZ, if you work with CITZ IMB for services, send your DNSRequest to CITZIMBTechServ@gov.bc.ca instead of DNSReqeust@gov.bc.ca


-------------------------------------------------------------------------------

# [\#56 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/56) `open`: My account seems to be regularly removed from Sysdig UI, what can I do?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-12-02 23:31](https://github.com/BCDevOps/OpenShift4-Migration/issues/56):






-------------------------------------------------------------------------------

# [\#55 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/55) `open`: Why do I see init:0/2 as the status of my pod?
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) opened issue at [2020-11-27 18:00](https://github.com/BCDevOps/OpenShift4-Migration/issues/55):

The `init` denotes an init container is being triggered and the `0/2` is the count; in this example `init:0/2` zero-of-two init containers have run. Once they are complete your Pod will start. You see them on OCP4 because those init containers are giving Aporeto a chance to start enforcing the pod before it starts; this helps prevent application connectivity issues.




-------------------------------------------------------------------------------

# [\#54 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/54) `open`: How do I add users to my namespace
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) opened issue at [2020-11-27 17:27](https://github.com/BCDevOps/OpenShift4-Migration/issues/54):

The UI has changed but the functionality largely remains the same. To add users, admin or otherwise, using the "Administrator / Developer" drop down in the top left. Then Developer -> Project -> Project Access. Add users with `@github` after their name like `jane@github`.

![add-user](https://user-images.githubusercontent.com/390891/100473788-fbeef780-3093-11eb-939a-72f0ba77bdda.gif)


#### <img src="https://avatars.githubusercontent.com/u/21046727?v=4" width="50">[Patrick Simonian](https://github.com/patricksimonian) commented at [2021-02-03 23:19](https://github.com/BCDevOps/OpenShift4-Migration/issues/54#issuecomment-772894482):

You can also add users via the commandline: `oc policy add-role-to-user <role> <user>` for a given namespace. This will create a rolebinding in that namespace just like the above gif.


-------------------------------------------------------------------------------

# [\#53 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/53) `open`: Storage classes have changed
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) opened issue at [2020-11-27 17:23](https://github.com/BCDevOps/OpenShift4-Migration/issues/53):

In OCP4 the storage classes are different. Find a complete list of current storage classes with the handy `oc get sc` command. For most applications, it won't make a difference if you use `file` or `block` storage.




-------------------------------------------------------------------------------

# [\#52 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/52) `open`: UID injection into /etc/passwd has nuanced behaviour
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) opened issue at [2020-11-27 17:20](https://github.com/BCDevOps/OpenShift4-Migration/issues/52):

As per the [docs](https://docs.openshift.com/container-platform/3.11/creating_images/guidelines.html) CRI-O supports the insertion of random UIDs into the container’s /etc/passwd;  Changing it’s permissions should never be required. As part of this new behaviour, CRI-O will not inject the UID if the permissions of /etc/passwd have been changed.





-------------------------------------------------------------------------------

# [\#51 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/51) `open`: Docker & Artifactory implementation details
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/51424896?v=4" width="50">[Marco Villeneuve](https://github.com/arcshiftsolutions) opened issue at [2020-11-20 17:32](https://github.com/BCDevOps/OpenShift4-Migration/issues/51):

# What's the issue?
Several teams are now hitting the docker rate-limit issue; only 200 images can be pulled every 6 hours. 

# Solutions
Two solutions were recommended by the platform team:

- Use the platform Artifactory repository to cache images
-- Automated Solution
-- Manual Solution
- Sign up for your own Docker account and use it (so your team gets 200 pulls of their own every six hours)

# Platform Docs
https://developer.gov.bc.ca/Artifact-Repositories-(Artifactory)

# Artifactory Repository
## Automated Solution

This solution automates the artifactory process and avoids having to explicitly define the `pullSecret` or `imagePullSecret` in your BCs or DCS; run [initOSProjects.sh](https://github.com/BCDevOps/openshift-developer-tools/blob/master/bin/initOSProjects.sh)

If the pull secrets are created and properly linked to the correct service accounts in the given environments the use of the Artifactory proxy to pull images becomes completely transparent to the project teams; i.e. there is NO need to explicitly define them in the BCs and DCs.

Here are some recent updates we did to the BCDevOps/openshift-developer-tools; https://github.com/BCDevOps/openshift-developer-tools/pull/128/files.

Those functions are part of the [initOSProjects.sh](https://github.com/BCDevOps/openshift-developer-tools/blob/master/bin/initOSProjects.sh), which automates the initial setup of the roles and secrets on a given project set. It automatically detects the `artifacts-default-*` creds in the tools project and automatically sets up the pull credentials and links them to the service accounts.

Example run (on an environment that already been setup, but it gives you the gist):

```
Found secret artifacts-default-ugnrgl, would you like to use this as a pull secret? (y/n)
y

Pull secret, artifactory-creds already exists in 583dbf-tools ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-tools ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-tools ...

Pull secret, artifactory-creds already exists in 583dbf-dev ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-dev ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-dev ...

Pull secret, artifactory-creds already exists in 583dbf-test ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-test ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-test ...

Pull secret, artifactory-creds already exists in 583dbf-prod ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-prod ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-prod ...
```

If you are using the automated scripts to setup the secrets and you still run into authentication issues pulling images, we have found, in some (limited) cases, the order the secrets are listed under the service account is significant:

This does not work in some cases (`artifactory-creds` listed last):
```
kind: ServiceAccount
apiVersion: v1
metadata:
  name: builder
  namespace: 069465-tools
  selfLink: /api/v1/namespaces/069465-tools/serviceaccounts/builder
  uid: 7b4cf3e7-c4fe-4d87-89ec-e6623535a040
  resourceVersion: '885860320'
  creationTimestamp: '2021-04-21T00:19:56Z'
secrets:
  - name: builder-dockercfg-2lxkk
  - name: builder-token-dwqrb
  - name: artifactory-creds
imagePullSecrets:
  - name: builder-dockercfg-2lxkk
 ```
```
kind: ServiceAccount
apiVersion: v1
metadata:
  name: default
  namespace: 069465-tools
  selfLink: /api/v1/namespaces/069465-tools/serviceaccounts/default
  uid: 5bde1f20-4b45-490e-aa14-2dfd9baec5ac
  resourceVersion: '885860288'
  creationTimestamp: '2021-04-21T00:19:56Z'
secrets:
  - name: default-token-8v8gl
  - name: default-dockercfg-7g9xf
imagePullSecrets:
  - name: default-dockercfg-7g9xf
  - name: artifactory-creds
```
In this case the solution is to change the order so the `artifactory-creds` are listed first:
```
kind: ServiceAccount
apiVersion: v1
metadata:
  name: builder
  namespace: 069465-tools
  selfLink: /api/v1/namespaces/069465-tools/serviceaccounts/builder
  uid: 7b4cf3e7-c4fe-4d87-89ec-e6623535a040
  resourceVersion: '885860320'
  creationTimestamp: '2021-04-21T00:19:56Z'
secrets:
  - name: artifactory-creds
  - name: builder-dockercfg-2lxkk
  - name: builder-token-dwqrb
imagePullSecrets:
  - name: builder-dockercfg-2lxkk
```
```
kind: ServiceAccount
apiVersion: v1
metadata:
  name: default
  namespace: 069465-tools
  selfLink: /api/v1/namespaces/069465-tools/serviceaccounts/default
  uid: 5bde1f20-4b45-490e-aa14-2dfd9baec5ac
  resourceVersion: '885860288'
  creationTimestamp: '2021-04-21T00:19:56Z'
secrets:
  - name: default-token-8v8gl
  - name: default-dockercfg-7g9xf
imagePullSecrets:
  - name: artifactory-creds
  - name: default-dockercfg-7g9xf
```

## Manual Artifactory Solution
For Artifactory, you will need to use the username & password from the secret created by the platform team in the TOOLS env. Your secret should be in the format of `default-[namespacename]-[plate]` or `artifacts-default-[plate]`. We also needed one additional step in our build configurations:

## Create Secret
```
oc create secret docker-registry artifactory-creds \
    --docker-server=docker-remote.artifacts.developer.gov.bc.ca \
    --docker-username=<our username from secret> \
    --docker-password=<our password from secret> \
    --docker-email=unused
```

## Link Secret for Build & Pulls
```
oc secrets link default artifactory-creds --for=pull
oc secrets link builder artifactory-creds
```

## Change required to Dockerfile (include docker-remote.artifacts.developer.gov.bc.ca)
```
FROM docker-remote.artifacts.developer.gov.bc.ca/node:lts-alpine
```

## Change required to Build Config (note the pullSecret)
```
strategy:
      dockerStrategy:
        pullSecret:
          name: artifactory-creds
        env:
        - name: BUILD_LOGLEVEL
          value: '2'
        - name: NPM_CONFIG_LOGLEVEL
          value: notice
      type: Docker
```

# Docker Auth
For Docker auth, you will need your own docker username and password. We ran the following commands in our tools namespace:

## Create Secret

```
oc create secret docker-registry docker-creds \
    --docker-server=docker.io \
    --docker-username=<docker username> \
    --docker-password=<docker password> \
    --docker-email=unused
```

## Link Secret for Build & Pulls
```
oc secrets link default docker-creds --for=pull
oc secrets link builder docker-creds
```

## Change the BuildConfig to specify the image (include docker.io)

```yaml
  strategy:
    dockerStrategy:
      from:
        kind: DockerImage
        name: docker.io/node:lts-alpine
```

## Change required to Dockerfile (include docker.io)
```
FROM docker.io/node:lts-alpine
```




#### <img src="https://avatars.githubusercontent.com/u/10504350?v=4" width="50">[Wade Barnes](https://github.com/WadeBarnes) commented at [2021-02-16 18:34](https://github.com/BCDevOps/OpenShift4-Migration/issues/51#issuecomment-780035982):

Another solution that automates the above process and avoids having to explicitly define the `pullSecret` or `imagePullSecret` in your BCs or DCS; run [initOSProjects.sh](https://github.com/BCDevOps/openshift-developer-tools/blob/master/bin/initOSProjects.sh)

**Details:**

If the pull secrets are created and properly linked to the correct service accounts in the given environments the use of the Artifactory proxy to pull images becomes completely transparent to the project teams; i.e. there is NO need to explicitly define them in the BCs and DCs.

Here are some recent updates we did to the [BCDevOps/openshift-developer-tools](https://github.com/BCDevOps/openshift-developer-tools/tree/master/bin); https://github.com/BCDevOps/openshift-developer-tools/pull/128/files.

Those functions are part of the [initOSProjects.sh](https://github.com/BCDevOps/openshift-developer-tools/blob/master/bin/initOSProjects.sh), which automates the initial setup of the roles and secrets on a given project set.  It automatically detects the `artifacts-default-*` creds in the `tools` project and automatically sets up the pull credentials and links them to the service accounts.

Example run (on an environment that already been setup, but it gives you the gist):
```
Found secret artifacts-default-ugnrgl, would you like to use this as a pull secret? (y/n)
y

Pull secret, artifactory-creds already exists in 583dbf-tools ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-tools ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-tools ...

Pull secret, artifactory-creds already exists in 583dbf-dev ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-dev ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-dev ...

Pull secret, artifactory-creds already exists in 583dbf-test ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-test ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-test ...

Pull secret, artifactory-creds already exists in 583dbf-prod ...
Linking pull secret, artifactory-creds, to the default service account in 583dbf-prod ...
Linking pull secret, artifactory-creds, to the builder service account in 583dbf-prod ...
```

#### <img src="https://avatars.githubusercontent.com/u/22899001?v=4" width="50">[Roland Stens](https://github.com/rstens) commented at [2021-04-12 21:43](https://github.com/BCDevOps/OpenShift4-Migration/issues/51#issuecomment-818262870):

@WadeBarnes Solution does not work for regular admins:

```
Loading settings ...
Loading settings from /h/biohubbc/settings.sh ...
/c/openshift-developer-tools/bin/settings.sh: line 374: ./settings.sh: No such file or directory
Granting deployment configuration access from '-dev', to '-tools', for service account 'default' ...
Assigning role [system:image-puller], to user [system:serviceaccount:-dev:default], in project [-tools] ...
Error from server (Forbidden): rolebindings.rbac.authorization.k8s.io is forbidden: User "rstens@github" cannot list resource "rolebindings" in API group "rbac.authorization.k8s.io" in the namespace "-tools"
```

#### <img src="https://avatars.githubusercontent.com/u/10504350?v=4" width="50">[Wade Barnes](https://github.com/WadeBarnes) commented at [2021-04-12 22:47](https://github.com/BCDevOps/OpenShift4-Migration/issues/51#issuecomment-818292427):

> @WadeBarnes Solution does not work for regular admins:
> 
> ```
> Loading settings ...
> Loading settings from /h/biohubbc/settings.sh ...
> /c/openshift-developer-tools/bin/settings.sh: line 374: ./settings.sh: No such file or directory
> Granting deployment configuration access from '-dev', to '-tools', for service account 'default' ...
> Assigning role [system:image-puller], to user [system:serviceaccount:-dev:default], in project [-tools] ...
> Error from server (Forbidden): rolebindings.rbac.authorization.k8s.io is forbidden: User "rstens@github" cannot list resource "rolebindings" in API group "rbac.authorization.k8s.io" in the namespace "-tools"
> ```

@rstens, You're missing a `settings.sh` file for the [BCDevOps/openshift-developer-tools](https://github.com/BCDevOps/openshift-developer-tools/tree/master/bin).  The file is used to define project's namespaces, for example; https://github.com/bcgov/orgbook-configurations/blob/master/openshift/settings.sh#L1.  Therefore the script does not know how to connect to your projects.

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) commented at [2021-04-16 21:49](https://github.com/BCDevOps/OpenShift4-Migration/issues/51#issuecomment-821581114):

Could we please:
1.  Rename "Option 2 - Artifactory Auth" to "Option 1- Artifactory Auth" and move to the top of the choices?    
2.  Add "Option 2 - OpenShift Developer Tools" and copy the text in from https://github.com/BCDevOps/OpenShift4-Migration/issues/51#issuecomment-780035982
3. Rename "Option 1 - Docker Auth" to "Option 3 - Docker Auth" and move this to the bottom?

Lastly, at https://developer.gov.bc.ca/Artifact-Repositories-(Artifactory) update all references to `default-[namespacename]-[plate]` to:

`default-[namespacename]-[plate]` or `artifacts-default-[plate]`

I think that'll make things much clearer, and lessen the odds of a new dev choosing 'Docker Auth' as the first choice.

thanks
gary

#### <img src="https://avatars.githubusercontent.com/u/10504350?v=4" width="50">[Wade Barnes](https://github.com/WadeBarnes) commented at [2021-04-22 19:52](https://github.com/BCDevOps/OpenShift4-Migration/issues/51#issuecomment-825140977):

If you are using the automated scripts to setup the secrets and you still run into authentication issues pulling images, we have found, in some (limited) cases, the order the secrets are listed under the service account is significant:

This does not work in some cases (`artifactory-creds` listed last):
```
kind: ServiceAccount
apiVersion: v1
metadata:
  name: builder
  namespace: 069465-tools
  selfLink: /api/v1/namespaces/069465-tools/serviceaccounts/builder
  uid: 7b4cf3e7-c4fe-4d87-89ec-e6623535a040
  resourceVersion: '885860320'
  creationTimestamp: '2021-04-21T00:19:56Z'
secrets:
  - name: builder-dockercfg-2lxkk
  - name: builder-token-dwqrb
  - name: artifactory-creds
imagePullSecrets:
  - name: builder-dockercfg-2lxkk
```
```
kind: ServiceAccount
apiVersion: v1
metadata:
  name: default
  namespace: 069465-tools
  selfLink: /api/v1/namespaces/069465-tools/serviceaccounts/default
  uid: 5bde1f20-4b45-490e-aa14-2dfd9baec5ac
  resourceVersion: '885860288'
  creationTimestamp: '2021-04-21T00:19:56Z'
secrets:
  - name: default-token-8v8gl
  - name: default-dockercfg-7g9xf
imagePullSecrets:
  - name: default-dockercfg-7g9xf
  - name: artifactory-creds
```

In this case the solution is to change the order so the `artifactory-creds` are listed first:
```
kind: ServiceAccount
apiVersion: v1
metadata:
  name: builder
  namespace: 069465-tools
  selfLink: /api/v1/namespaces/069465-tools/serviceaccounts/builder
  uid: 7b4cf3e7-c4fe-4d87-89ec-e6623535a040
  resourceVersion: '885860320'
  creationTimestamp: '2021-04-21T00:19:56Z'
secrets:
  - name: artifactory-creds
  - name: builder-dockercfg-2lxkk
  - name: builder-token-dwqrb
imagePullSecrets:
  - name: builder-dockercfg-2lxkk
```
```
kind: ServiceAccount
apiVersion: v1
metadata:
  name: default
  namespace: 069465-tools
  selfLink: /api/v1/namespaces/069465-tools/serviceaccounts/default
  uid: 5bde1f20-4b45-490e-aa14-2dfd9baec5ac
  resourceVersion: '885860288'
  creationTimestamp: '2021-04-21T00:19:56Z'
secrets:
  - name: default-token-8v8gl
  - name: default-dockercfg-7g9xf
imagePullSecrets:
  - name: artifactory-creds
  - name: default-dockercfg-7g9xf
```

#### <img src="https://avatars.githubusercontent.com/u/51424896?v=4" width="50">[Marco Villeneuve](https://github.com/arcshiftsolutions) commented at [2021-04-23 19:42](https://github.com/BCDevOps/OpenShift4-Migration/issues/51#issuecomment-825879232):

@garywong-bc @WadeBarnes - I've updated the issue description with your recommendations; please let me know if I've missed anything. Thanks!

#### <img src="https://avatars.githubusercontent.com/u/10504350?v=4" width="50">[Wade Barnes](https://github.com/WadeBarnes) commented at [2021-04-26 19:34](https://github.com/BCDevOps/OpenShift4-Migration/issues/51#issuecomment-827091901):

@arcshiftsolutions, Looks good.  I'd promote the automated approach more, but hopefully the platform team gets things setup in such a way that this all becomes transparent to all of us soon; https://github.com/bcgov/platform-services-registry/issues/359

#### <img src="https://avatars.githubusercontent.com/u/51424896?v=4" width="50">[Marco Villeneuve](https://github.com/arcshiftsolutions) commented at [2021-04-28 02:43](https://github.com/BCDevOps/OpenShift4-Migration/issues/51#issuecomment-828099186):

Thanks @WadeBarnes - I've made further updates to promote the automated approach.

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) commented at [2021-05-17 16:47](https://github.com/BCDevOps/OpenShift4-Migration/issues/51#issuecomment-842476239):

Looks good..  any way to sync up https://developer.gov.bc.ca/Artifact-Repositories-(Artifactory) ?  TIA

#### <img src="https://avatars.githubusercontent.com/u/51424896?v=4" width="50">[Marco Villeneuve](https://github.com/arcshiftsolutions) commented at [2021-05-21 00:23](https://github.com/BCDevOps/OpenShift4-Migration/issues/51#issuecomment-845566673):

@garywong-bc I've updated the URL above to the new link - thanks for noting that. :)


-------------------------------------------------------------------------------

# [\#50 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/50) `open`: What images will platform services provide on OCP4?
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) opened issue at [2020-11-17 22:44](https://github.com/BCDevOps/OpenShift4-Migration/issues/50):

On OCP311 we provided several images that didn't get updated frequently because of ownership and teams size. As a result, over time these images started to decay and expose security vulnerabilities. On OCP4 we're going to take a different tack: We'll provide the bare minimum of images focusing on ones that yield the widest blast radius. 

With this in mind we've published `postgres / patroni` to the `bcgov` namespace `oc get is -n bcgov` and have paused there. The community has asked for Caddy and that may be a good next candidate. Many other images can be found off cluster in the [Redhat Container Catalog](https://catalog.redhat.com/software/containers/explore) and [community catalog](https://github.com/sclorg).

Feel free to add comments below to indicate a vote for a particular image.







-------------------------------------------------------------------------------

# [\#49 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/49) `closed`: Common registry namespace images on OCP4 now managed by individual teams (except Patroni)

#### <img src="https://avatars.githubusercontent.com/u/51424896?v=4" width="50">[Marco Villeneuve](https://github.com/arcshiftsolutions) opened issue at [2020-11-17 22:37](https://github.com/BCDevOps/OpenShift4-Migration/issues/49):

In OCP4, it is up to the individual teams to build and manage their base product images. (i.e. Caddy, s2i, Jenkins etc.)

The Platform team has setup the Patroni V12 image, but are not planning on including any further images; this is to ensure that individual teams are managing their own images. Given the amount of variety, it would be too difficult for the platform team to maintain all the different images teams are asking for. 


#### <img src="https://avatars.githubusercontent.com/u/51424896?v=4" width="50">[Marco Villeneuve](https://github.com/arcshiftsolutions) commented at [2020-11-17 23:47](https://github.com/BCDevOps/OpenShift4-Migration/issues/49#issuecomment-729282436):

Please see issue #50 for more info.


-------------------------------------------------------------------------------

# [\#48 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/48) `open`: How can I get a .bcgov domain to work on OCP4?
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) opened issue at [2020-11-13 17:59](https://github.com/BCDevOps/OpenShift4-Migration/issues/48):

Per https://pathfinder-faq-ocio-pathfinder-prod.pathfinder.gov.bc.ca/OCP/Networking.html

>Please note: A common misconception is that using a {name}.pathfinder.bcgov name will secure your application for 'internal to BCGov' traffic. This is NOT the case. Both of the external VIPs are directing traffic to the SAME cluster ingress. To secure named routes you must add route whitelists.

OCP3 was behind the DMZ firewall and so you could connect to either the outside VIP or the inside VIP. OCP4 only has the outside VIP. And only has the one subnet in the SDN Zone that is not behind any firewalls.

Security should be achieved via [ACLs](https://docs.openshift.com/container-platform/4.5/networking/routes/route-configuration.html#nw-route-specific-annotations_route-configuration) `haproxy.router.openshift.io/ip_whitelist` in routes, and Aporeto policy.

Additionally, OCP4 won't have a built in wildcard set up for `*.apps.silver.devops.bcgov` as we are trying to get people to move to [vanity URLs](https://github.com/BCDevOps/OpenShift4-Migration/blob/master/docs/planning-your-migration.md#ingress). No wildcard TLS cert will be added for `bcgov`.

>With the move to an enterprise service, the platform wildcard has been deemed unsuitable for production application deployments. This means if you don't have a vanity URL for your application yet, you will want to get started on provisioning one.

Users are welcome to create a CNAME from a `bcgov` subdomain of their choosing to the ingress route, but it is just security through obscurity. 

Ref: https://github.com/BCDevOps/OpenShift4-RollOut/issues/460

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) commented at [2020-11-13 19:28](https://github.com/BCDevOps/OpenShift4-Migration/issues/48#issuecomment-726989169):

Please update/close https://github.com/BCDevOps/OpenShift4-Migration/issues/26 when this issue is resolved.


-------------------------------------------------------------------------------

# [\#47 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/47) `closed`: Suggestion for more precise naming of Artifactory secret

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-10 21:51](https://github.com/BCDevOps/OpenShift4-Migration/issues/47):

A default secret is automatically create in the `*-tools` namespaces, following a name convention that starts with `default-*`.

```bash
# oc get secret -n e69aae-tools default-e69aae-rqmrfq
NAME                    TYPE                       DATA   AGE
default-e69aae-rqmrfq   kubernetes.io/basic-auth   2      26d
```

Perhaps `jfrog-default-<namespace-id>-<random-string` ?  

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) commented at [2020-11-10 21:52](https://github.com/BCDevOps/OpenShift4-Migration/issues/47#issuecomment-724989010):

Dup of https://app.zenhub.com/workspaces/platform-experience-5bb7c5ab4b5806bc2beb9d15/issues/bcgov/devhub-app-web/1510


-------------------------------------------------------------------------------

# [\#46 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/46) `open`: Patroni V10 image deployment hangs
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:33](https://github.com/BCDevOps/OpenShift4-Migration/issues/46):

This is still unresolved, but some users report a delay of 10-15 minutes when deploying Patroni.  At first glance, it is hanging on PVC allocation.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=tfCYZjkZQAD65HxSf




-------------------------------------------------------------------------------

# [\#45 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/45) `open`: How do I pull RedHat Images?
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:32](https://github.com/BCDevOps/OpenShift4-Migration/issues/45):

The OCP4 environment does not seem to have the permissions to pull the image, where OCP3 does.

The error message is:
```bash
this system is not receiving updates. You can use subscription-manager on the host to register and assign subscriptions
```

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=oMHSLSa6BpLAkqgEY

For further details:
- https://github.com/BCDevOps/OpenShift4-Migration/issues/15




-------------------------------------------------------------------------------

# [\#44 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/44) `closed`: documentation | Pulling RH images

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:31](https://github.com/BCDevOps/OpenShift4-Migration/issues/44):

The OCP4 environment does not seem to have the permissions to pull the image, where OCP3 does.

The error message is:
```bash
this system is not receiving updates. You can use subscription-manager on the host to register and assign subscriptions
```

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=oMHSLSa6BpLAkqgEY

For further details:
- https://github.com/BCDevOps/OpenShift4-Migration/issues/15

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) commented at [2020-11-06 22:36](https://github.com/BCDevOps/OpenShift4-Migration/issues/44#issuecomment-723330781):

dup


-------------------------------------------------------------------------------

# [\#43 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/43) `open`: Different PostgreSQL initialization behaviour
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:29](https://github.com/BCDevOps/OpenShift4-Migration/issues/43):

When deploying the `openshift-postgresql-oracle_fdw` image, it now uses the OCP4 assigned user account rather than the default `postgres` user to initialize the database. Then causes other initialization issues. 

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=4fN4M6gNMSZgrpcTb

For further details:





-------------------------------------------------------------------------------

# [\#42 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/42) `open`: Granting users access to Project Namespaces
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:27](https://github.com/BCDevOps/OpenShift4-Migration/issues/42):

In the Console GUI, first switch from `Administrator` to `Developer` mode, and on the 
`Developer` menu, select a project and then select `Project Access`.

Important, GitHub usernames need to be cast to lowercase and appended with `@github`. 
 `@github` is the specific auth provider to KeyCloak; in the future it will also support IDIR.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=KPZj8gL375kKGELwh
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=bgprGyqhv3ZAZbC7N


#### <img src="https://avatars.githubusercontent.com/u/31288809?v=4" width="50">[Ryan Loiselle](https://github.com/rloisell) commented at [2020-11-12 23:32](https://github.com/BCDevOps/OpenShift4-Migration/issues/42#issuecomment-726405447):

@garywong-bc  - casting the username in lower case is creating issues and security concerns as they are case sensitive within GitHub.com. It very easy to assign the incorrect user when in one place it is case sensitive, and in another it is not. 

CC: @NickCorcoran @mitovskaol @juhewitt


-------------------------------------------------------------------------------

# [\#41 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/41) `open`: New IP Ranges
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:24](https://github.com/BCDevOps/OpenShift4-Migration/issues/41):

The new cluster has a different set of IP Addresses.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=2HniRQZCrT9eCCke4

For further details (access to the protected space in Documize is required):
https://docs.developer.gov.bc.ca/s/bn6v0ac6f9gue7hhirbg/protected-platform-services/d/bsg9q3nu3u14r4kded80/ocp-4-platform-network-topology


#### <img src="https://avatars.githubusercontent.com/u/1703309?v=4" width="50">[Matthew Bystedt](https://github.com/mbystedt) commented at [2021-02-17 19:24](https://github.com/BCDevOps/OpenShift4-Migration/issues/41#issuecomment-780793762):

@garywong-bc The links need updating after the url change.

#### <img src="https://avatars.githubusercontent.com/u/23747270?v=4" width="50">[ikethecoder](https://github.com/ikethecoder) commented at [2021-04-16 18:06](https://github.com/BCDevOps/OpenShift4-Migration/issues/41#issuecomment-821377874):

I _think_ these are the new ones:

https://chat.developer.gov.bc.ca/channel/devops-ocp4-migration?msg=2HniRQZCrT9eCCke4

https://docs.developer.gov.bc.ca/s/bn6v0ac6f9gue7hhirbg/protected-platform-services/d/bsg9q3nu3u14r4kded80/ocp-4-prod-networks


-------------------------------------------------------------------------------

# [\#40 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/40) `closed`: documentation | New Jenkins image has different data folder by default

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:23](https://github.com/BCDevOps/OpenShift4-Migration/issues/40):

Jenkins  v2.235+ now looks in `/var/jenkins-data`.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=cmCeKTsYgSs9FQnYt

For further details:
- https://github.com/bcgov/devhub-resources/issues/39
- https://developer.gov.bc.ca/Cloud-Migration/Migrating-Your-BC-Gov-Jenkins-to-the-Cloud


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) commented at [2020-11-06 22:37](https://github.com/BCDevOps/OpenShift4-Migration/issues/40#issuecomment-723330951):

dup


-------------------------------------------------------------------------------

# [\#39 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/39) `closed`: documentation | New Jenkins image looks in different data folder

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:23](https://github.com/BCDevOps/OpenShift4-Migration/issues/39):

Jenkins  v2.235+ now looks in `/var/jenkins-data`.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=cmCeKTsYgSs9FQnYt

For further details:
- https://github.com/bcgov/devhub-resources/issues/39
- https://developer.gov.bc.ca/Cloud-Migration/Migrating-Your-BC-Gov-Jenkins-to-the-Cloud


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) commented at [2020-11-06 22:36](https://github.com/BCDevOps/OpenShift4-Migration/issues/39#issuecomment-723330884):

dup


-------------------------------------------------------------------------------

# [\#38 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/38) `open`: New default egress rules 
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:21](https://github.com/BCDevOps/OpenShift4-Migration/issues/38):

OCP4 is in the SDN Compartment, and uses Secure Internet Service Firewall that does do some filtering and IPS.  For example, `tcp/9700:9799` no longer works (by default).

Example spec:
```yaml
spec:
  description: allow my namespace namespace to talk to the internet.
  destination:
    - - 'ext:network=any'
  source:
    - - $namespace=<mynamespace>-dev
```

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=pqAet6NH3mi5hJGKE
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=NRAcjxnooeoBsaAme
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=vpe9Qced2WM4Tp3BC

For further details:
If this egress is required, you may submit a firewall request with the source `MCS-SILVER-NAT` and just mention Secure Internet Service Firewall to:
- https://ssbc-client.gov.bc.ca/order/howtoorder.htm
- https://ssbc-client.gov.bc.ca/services/Firewall/order.htm






-------------------------------------------------------------------------------

# [\#37 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/37) `open`: Is it not possible to extract values for NSPs from secrets
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:19](https://github.com/BCDevOps/OpenShift4-Migration/issues/37):

The Network Security Policy is just a YAML file picked up by an operator, so there is no pod or anything to do the mounting of said secret.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=RFEHQRJ4Cdg9Dqabr

The GUI will show NSP's in `Administrator` mode:
- Home
  - Explore
    -  NetworkSecurityPolicy
       -  Instances




-------------------------------------------------------------------------------

# [\#36 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/36) `open`: How to Request a Resource Quota Increase for a Namespace in OCP 4? 
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:16](https://github.com/BCDevOps/OpenShift4-Migration/issues/36):

All project sets in the new OCP 4 Platform are provisioned by default with a "small" resource quota size that includes a certain amout of CPU, RAM and Storage.  The amount of resources within each quota size - small, medium and large are as follows:

**CPU/RAM/Storage long-running workload quotas (per namespace)**:
* **Small (Default)**:  
CPU: 4 cores as request, 8 cores as limit
RAM: 16GBs as request, 32GBs as limit
20 PVC count , 50Gbs overall storage with 25 GBs for backup storage

* **Medium: (needs to be requested and justified)**:
Long-running workload quotas:
CPU: 8 cores as request, 16 cores as limit
RAM: 32GBs as request, 64GBs as limit
Medium: 40 PVC count , 100Gbs overall storage with 50 GBs for backup storage

* **Large: (needs to be requested and justified):**
Long-running workload quotas:
CPU: 16 cores as request, 32 cores as limit
RAM: 64GBs as request, 128GBs as limit
Large: 60 PVC count , 200Gbs overall storage with 100 GBs for backup storage 

If you find that the new default allocations are insufficient, you can request a quota increase **for the entire project set** in the Project Registry (currently this feature is only available to the requestors of the project set provisioning as part of the project edit funtionality, it will be available to POs/Tech Leads in Jan 2021).  

**We currently do not support quota increases for a specific resource (i.e. just RAM, or just CPU, or just Storage) or for a specific namespace (i.e. prod only).**  Teams requiring more resources in any of the 3 resource categories such as CPU/RAM/Storage in any of the 4 namespaces (dev, test, tool or prod), will have to submit a standard quota increase request through the Project Registry.  The upgrade path will only be available in this order: from small -> medium -> large. You cannot skip medium and upgrade from small to large.

Once the quota increase request is approved (see the approval process below), all 4 namespaces in a project set will be upgraded to the next quota size which includes a double amount of resources in all 3 categories.

*Example: If your prod namespace needs more storage and you request a standard quota increase from small to medium, the resource allocations for all 4 of your namespaces will be upgraded to the medium size quota as per the OCP 4 quota definition.*

**Quota increase approval process**

When requesting a quota increase from small to medium,  follow the process for request a quota increase as described [here](https://developer.gov.bc.ca/Need-more-quota-for-OpenShift-project-set).

When requesting a quota increase from medium to large, book a 30 min meeting with the Platform Services Team (send the invite to @mitovskaol and she will be pull in team's operations experts as needed). The Platform Services Team will be looking for an overview of the application design and architecture that clearly demonstrate why more resources are required for its operations.

**All quota requests will be reviewed by the Platform Services Team and will require a proof of the need for increased resources from the product team (i.e. load test results, CPU/RAM historic usage chart that shows consistent consumption close to the limit).** 

We haven't been very efficient with using resources on the old OCP 3.11 Platform, so we are trying to get better on the new Platform :)



#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) commented at [2020-12-02 22:50](https://github.com/BCDevOps/OpenShift4-Migration/issues/36#issuecomment-737543494):

OCP3 defaults were a Medium for CPU/Mem and a Large for storage.

#### <img src="https://avatars.githubusercontent.com/u/30994898?v=4" width="50">[sbathgate](https://github.com/sbathgate) commented at [2020-12-21 19:12](https://github.com/BCDevOps/OpenShift4-Migration/issues/36#issuecomment-749147732):

# Walkthrough of the Quota Increase procedure
![Quota Increase](https://user-images.githubusercontent.com/30994898/102813257-5ae71a00-437d-11eb-9c47-762361957be4.gif)

#### <img src="https://avatars.githubusercontent.com/u/22899001?v=4" width="50">[Roland Stens](https://github.com/rstens) commented at [2021-06-24 00:14](https://github.com/BCDevOps/OpenShift4-Migration/issues/36#issuecomment-867238353):

A url would be nice

#### <img src="https://avatars.githubusercontent.com/u/30994898?v=4" width="50">[sbathgate](https://github.com/sbathgate) commented at [2021-06-24 17:23](https://github.com/BCDevOps/OpenShift4-Migration/issues/36#issuecomment-867817970):

Hi @rstens, each project has a unique url which is part of the path to the quota page, so it isn't something that can necessarily be directly linked to. The url to the registry is: [https://registry.developer.gov.bc.ca/](https://registry.developer.gov.bc.ca/). The format of the link to the quota edit page would be as follows if that is helpful too:
https://registry.developer.gov.bc.ca/profile/[:uniqueProfileId]/quota

#### <img src="https://avatars.githubusercontent.com/u/22899001?v=4" width="50">[Roland Stens](https://github.com/rstens) commented at [2021-06-24 18:38](https://github.com/BCDevOps/OpenShift4-Migration/issues/36#issuecomment-867867506):

Thanks, that was was I was looking for.


-------------------------------------------------------------------------------

# [\#35 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/35) `open`: Potential confusion between `NetworkSecurityPolicy` and `NetworkPolicies`
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:14](https://github.com/BCDevOps/OpenShift4-Migration/issues/35):

Custom `NetworkSecurityPolicy` objects do not supercede `NetworkPolicies` (different animals).

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=yfAEqYbCnk2ZiNrjY

For further details:
- https://github.com/BCDevOps/OpenShift4-RollOut/issues/376
- https://www.openshift.com/blog/troubleshooting-openshift-internal-networking






-------------------------------------------------------------------------------

# [\#34 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/34) `open`: New easier way to provision Backup storage volumes
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:09](https://github.com/BCDevOps/OpenShift4-Migration/issues/34):

Instead of NFS and a separate provisioning method, simply refer to the new storageClass
`netapp-file-backup`. 

```bash
❯ oc get storageClass
NAME                             PROVISIONER                AGE
gluster-block                    gluster.org/glusterblock   1y
gluster-file                     kubernetes.io/glusterfs    1y
gluster-file-db                  kubernetes.io/glusterfs    1y
netapp-block-standard            netapp.io/trident          149d
netapp-file-standard (default)   netapp.io/trident          346d
nfs-backup   
```

RocketChat Reference(s):
- https://chat.developer.gov.bc.ca/channel/devops-ocp4-migration?msg=mfqvBmjthREYqanXm

For further details:
- https://developer.gov.bc.ca/OCP4-Backup-and-Restore





-------------------------------------------------------------------------------

# [\#33 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/33) `open`: Pending Firewall rule to allow connection to/from OCP3
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:07](https://github.com/BCDevOps/OpenShift4-Migration/issues/33):

Until the pending FW rule to allow OPC3 to SILVER is implemented, you will be unable to connect from the Pathfinder cluster to Silver.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=pwPG5tjBmhE67m72k

For further details:
- https://app.zenhub.com/workspaces/platform-experience-5bb7c5ab4b5806bc2beb9d15/issues/bcdevops/openshift4-rollout/427

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) commented at [2020-11-16 19:03](https://github.com/BCDevOps/OpenShift4-Migration/issues/33#issuecomment-728262340):

Firewall rule has been implemented.


-------------------------------------------------------------------------------

# [\#32 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/32) `open`: Health checks in the OpenShift 4.5 web console
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:06](https://github.com/BCDevOps/OpenShift4-Migration/issues/32):

A best practice is use health checks for your pods.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=9xZzLkrg4C8usCeLo

For further details:
- https://developers.redhat.com/blog/2020/07/20/best-practices-using-health-checks-in-the-openshift-4-5-web-console/




-------------------------------------------------------------------------------

# [\#31 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/31) `open`: How to download oc CLI from OCP4 Console
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:04](https://github.com/BCDevOps/OpenShift4-Migration/issues/31):

The new console provides a link to download the version of `oc` CLI that matches OCP4.  Note that you can use the parameter `oc -v=10` for extra verbosity when debugging.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=zx6Rzo73WwxvD729D







-------------------------------------------------------------------------------

# [\#30 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/30) `open`: Coordinating migration of changes of DNS Vanity URLs
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:02](https://github.com/BCDevOps/OpenShift4-Migration/issues/30):

When re-pointing existing DNS names,  a best practice is to reduce TTL and to collaborate w OCIO to schedule during off-hours.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=6ZEZPJPmNLasgQf3r

To find the IP of the OCP4 VIP (point your vanity URL DNS entry to it), please get access to https://docs.pathfinder.gov.bc.ca/s/bn6v0ac6f9gue7hhirbg/protected-platform-services/d/bsg9q3nu3u14r4kded80/ocp-4-platform-network-topology and look up the `Ingress VIP` IP Address

#### <img src="https://avatars.githubusercontent.com/u/19917617?v=4" width="50">[Karim Gillani](https://github.com/gil0109) commented at [2021-01-13 17:39](https://github.com/BCDevOps/OpenShift4-Migration/issues/30#issuecomment-759608012):

I also worked with OCIO/CITZ IMB to get access to my domain (servicebc.gov.bc.ca) to adjust DNS myself at anytime for my specific Domain.  Works great...

If you use/have access to wildcard cert.. this is great.

Web App is called Remedy.


-------------------------------------------------------------------------------

# [\#29 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/29) `open`: How to set up GitHub Actions
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 22:01](https://github.com/BCDevOps/OpenShift4-Migration/issues/29):

For GitHub, or any other external CI, it requires restricted access to OCP4.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=Mo2xpbtq8FLiJAjjt

For further details:
- https://github.com/bcgov/platform-services-registry/blob/master/openshift/templates/cicd.yaml





-------------------------------------------------------------------------------

# [\#28 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/28) `open`: New Cluster Registry URL 
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 21:59](https://github.com/BCDevOps/OpenShift4-Migration/issues/28):

The URL is now `image-registry.openshift-image-registry.svc:5000` and no longer `docker-registry.default.svc:5000/`.

The GUI console that was at `https://registry-console-default.pathfinder.gov.bc.ca/registry` is no longer available in OCP4.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=SDWDHPTW8J7goYqnF
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=2E6fskh3FwAWTyxSq

For further details:
- https://github.com/BCDevOps/OpenShift4-Migration/issues/14





-------------------------------------------------------------------------------

# [\#27 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/27) `open`: Do not use old OCP3 'networkPolicy' object in *.yaml
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 21:57](https://github.com/BCDevOps/OpenShift4-Migration/issues/27):

There are no default NetworkSecurityPolicy in the workspaces by design.  To create NSP's in OCP4, use the `security.devops.gov.bc.ca/v1alpha1` object, and not the OpenShift `NetworkPolicy` object. 

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=REWyaCKWpmYMzdMPd





-------------------------------------------------------------------------------

# [\#26 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/26) `open`: No more *.bcgov by default
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 21:56](https://github.com/BCDevOps/OpenShift4-Migration/issues/26):

Unlike OCP3, there are no default `*.bcgov` routes.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=d9z6KdTaAxKtkgYDK

#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) commented at [2020-11-13 19:33](https://github.com/BCDevOps/OpenShift4-Migration/issues/26#issuecomment-726991530):

@garywong-bc I created #48 to document a convo we had with AG/JAG about this. I creating a wildcard `*.bcgov` for the new clusters in favour of teams using a vanity domain like `mycoolapp.nrm.bcgov` and just pointing that via a DNS `CNAME` record to `aps.silver.gov.bc.ca` or the front-door IP. That ticket also comments on how to better secure the route.


-------------------------------------------------------------------------------

# [\#25 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/25) `open`: Cleanup of legacy OCP3 when OCP4 migration complete
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 21:55](https://github.com/BCDevOps/OpenShift4-Migration/issues/25):

Once you finished migrating an app to the Silver cluster, please:

1. Scale all your pods in all app namespaces on the OCP 3.11 Platform to 0
2. Submit a request to remove the namespaces from the OCP 3.11 Platform here

RocketChat Reference(s):
https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=gCkcX2mr92vprycfN




-------------------------------------------------------------------------------

# [\#24 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/24) `open`: Artifactory service
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 21:53](https://github.com/BCDevOps/OpenShift4-Migration/issues/24):

OCP4 supports our on-prem Caching Repository.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=JGWNaixvNHH9pNHCs

For further details:
- https://github.com/BCDevOps/developer-experience/blob/master/apps/artifactory/DEVHUB-README.md

#### <img src="https://avatars.githubusercontent.com/u/10466412?v=4" width="50">[Cailey Jones](https://github.com/caggles) commented at [2020-12-02 22:22](https://github.com/BCDevOps/OpenShift4-Migration/issues/24#issuecomment-737531578):

Quick reference on the intended use of Artifactory:

Caching repos are available right now and all teams are encouraged to use these.

Private repos are going to be available soon and will allow teams to push their own images and other artifacts to artifactory. We encourage teams to push only prod (or prod-ready) images to their private repos. So build on the OCP integrated registry, and then push your image to artifactory once you're ready for prod.

There are a number of reasons for encouraging this pattern, which will be updated in our documentation very soon as well!


-------------------------------------------------------------------------------

# [\#23 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/23) `open`: Connect to the KeyCloak SSO service from my namespace
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 21:52](https://github.com/BCDevOps/OpenShift4-Migration/issues/23):

SSO is treated as an 'external' system, and OCP4's Aporeto needs you to grant permission for your pod(s) to talk to the external system.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=eKeuFaKCALWzrxf7s

For further details:
- https://github.com/BCDevOps/OpenShift4-Migration/issues/5





-------------------------------------------------------------------------------

# [\#22 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/22) `open`: Assigning privileges between namespaces
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 21:49](https://github.com/BCDevOps/OpenShift4-Migration/issues/22):

In OpenShift 3, each of our namespaces could pull images from the tools namespace and this was easily done in the UI using the membership page.  But in OCP4, in trying to "create binding", it is not straight-forward to select `system:image-puller` as a role nor a `default` namespace ServiceAccount as subject.

In OCP4, use `oc policy add-role-to-user` to grant permissions; remember that when granting access from a different account you need the fully qualified name.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=S5brTEKwEGRXkgnr4
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=ksB9AAiECjajjCbYX





-------------------------------------------------------------------------------

# [\#21 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/21) `open`: How can I customize Openshift 4 Console?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-11-06 19:37](https://github.com/BCDevOps/OpenShift4-Migration/issues/21):

The Openshift console has changed quite a bit between OCP 3.11 and OCP 4. The good news is that OCP 4 offers developers a capability to customize the Console to better meet their needs. Check out [this article](http://gexperts.com/wp/empowering-developers-in-the-openshift-console/) for guidance on how to customize the Developer perspective in the OCP 4 Console 




-------------------------------------------------------------------------------

# [\#20 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/20) `closed`: test only

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 18:59](https://github.com/BCDevOps/OpenShift4-Migration/issues/20):

xxx




-------------------------------------------------------------------------------

# [\#19 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/19) `closed`: test only 2

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 18:59](https://github.com/BCDevOps/OpenShift4-Migration/issues/19):

xxx




-------------------------------------------------------------------------------

# [\#18 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/18) `open`: DNS URL's for non-PROD applications

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 18:55](https://github.com/BCDevOps/OpenShift4-Migration/issues/18):

For non-prod (non-published) service names, the silver cluster will provide a wildcard DNS/cert combo at `*.apps.silver.devops.gov.bc.ca`.

RocketChat Reference(s):
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=zh3hsE9f8dPFCAcNX





-------------------------------------------------------------------------------

# [\#17 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/17) `open`: Default to CRI-O 

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) opened issue at [2020-11-06 18:38](https://github.com/BCDevOps/OpenShift4-Migration/issues/17):

This means docker images no longer need customization for random uid/gid in `/etc/passwd`. CRI-O supports the insertion of random user IDs into the container’s /etc/passwd, so changing it’s permissions should never be required.

RocketChat Reference(s):

- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=d6GKBSnx6DqezzJHe
- https://chat.pathfinder.gov.bc.ca/channel/devops-ocp4-migration?msg=BAa9mMjPqsrT5uyGd

For further details:
- https://access.redhat.com/articles/4859371






-------------------------------------------------------------------------------

# [\#16 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/16) `open`: Set up Kibana

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) opened issue at [2020-11-05 21:46](https://github.com/BCDevOps/OpenShift4-Migration/issues/16):

https://kibana-openshift-logging.apps.silver.devops.gov.bc.ca/

When you first log into Kibana you need to create your search index.

Index pattern: `app*`
Timestamp field name: `@timestamp`

![image](https://user-images.githubusercontent.com/24236108/98299796-1f2ef700-1f6d-11eb-99bf-7bb608a7dc8d.png)
![image](https://user-images.githubusercontent.com/24236108/98299832-2d7d1300-1f6d-11eb-8d0a-a90a98ece48f.png)


#### <img src="https://avatars.githubusercontent.com/u/37156853?v=4" width="50">[David Agahchen](https://github.com/agahchen) commented at [2021-02-24 20:11](https://github.com/BCDevOps/OpenShift4-Migration/issues/16#issuecomment-785342456):

There is a bug reported opened with RedHat re Kibana corrupting users security index settings (see https://bugzilla.redhat.com/show_bug.cgi?id=1902112 for more details.)

The workaround in the mean time is to request the removal on your Kibana settings file (provide your GitHub id) via Rocket.Chat (e.g., #devops-ocp4-migration or #devops-operations channel).

#### <img src="https://avatars.githubusercontent.com/u/2684022?v=4" width="50">[Matthieu Foucault](https://github.com/matthieu-foucault) commented at [2021-05-11 18:04](https://github.com/BCDevOps/OpenShift4-Migration/issues/16#issuecomment-838925355):

How long is creating an index pattern expected to take? I followed the steps above, and can only see this:
![image](https://user-images.githubusercontent.com/2684022/117863498-b0e32e00-b248-11eb-9933-d2e8688a9831.png)


-------------------------------------------------------------------------------

# [\#15 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/15) `open`: Build Entitlements

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) opened issue at [2020-11-04 17:11](https://github.com/BCDevOps/OpenShift4-Migration/issues/15):

When building container images based on RHEL images and using `yum` or `dnf` to install packages you might get an error like.

```
This system is not receiving updates. You can use subscription-manager on the host to register and assign subscriptions.
```

This is a known issue with Red Hat ~~and the Platform Team is tracking the solution in [ZenHub](https://app.zenhub.com/workspaces/platform-experience-5bb7c5ab4b5806bc2beb9d15/issues/bcdevops/openshift4-rollout/357)~~

~~Until its fixed in OCP, the platform team can create a set of Secrets and ConfigMaps in your namespace to inject into your builds.~~

~~Have a Platform Team member create the needed ConfigMaps and Secrets for Subscription Manager. Stored in a private repo https://github.com/bcgov-c/platform-tools/blob/ocp4-base/ocp4/entitlement.yaml~~

```bash
oc -n <namespace> create -f entitlement.yaml
```

~~On the todo list is to have the Project Registry auto-create these for all `*-tools` namespaces`. The rest of the steps will need to be done by the developers.~~

The Project Registry now creates the config maps and secrets for you in your -tools namespace.

Edit the BuildConfig to load the files.

```yaml
    source:
      secrets:
      - secret:
          name: platform-services-controlled-etc-pki-entitlement
        destinationDir: etc-pki-entitlement
      configMaps:
      - configMap:
          name: rhsm-conf
        destinationDir: platform-services-controlled-rhsm-conf
      - configMap:
          name: rhsm-ca
        destinationDir: platform-services-controlled-rhsm-ca
```

Edit the BuildConfig to squash all the layers, else the private key will stay in the image layer.

```yaml
    strategy:
      type: Docker
      dockerStrategy:
        imageOptimizationPolicy: SkipLayers
```

Ensure the `Dockerfile` loads the files and uses them.

```Dockerfile
# Copy entitlements
COPY ./etc-pki-entitlement /etc/pki/entitlement

# Copy subscription manager configurations
COPY ./rhsm-conf /etc/rhsm
COPY ./rhsm-ca /etc/rhsm/ca

# Install some packages and clean up
RUN INSTALL_PKGS="space separated list of packages" && \
    # Initialize /etc/yum.repos.d/redhat.repo
    # See https://access.redhat.com/solutions/1443553
    rm /etc/rhsm-host && \
    yum repolist --disablerepo=* && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum -y clean all --enablerepo='*' && \
    # Remove entitlements and Subscription Manager configs
    rm -rf /etc/pki/entitlement && \
    rm -rf /etc/rhsm
```

#### <img src="https://avatars.githubusercontent.com/u/10504350?v=4" width="50">[Wade Barnes](https://github.com/WadeBarnes) commented at [2020-11-04 21:53](https://github.com/BCDevOps/OpenShift4-Migration/issues/15#issuecomment-721995125):

The `rm /etc/rhsm-host && \` line is significant.  It's needed to initialize the subscription manager configurations.

#### <img src="https://avatars.githubusercontent.com/u/10504350?v=4" width="50">[Wade Barnes](https://github.com/WadeBarnes) commented at [2020-11-10 18:37](https://github.com/BCDevOps/OpenShift4-Migration/issues/15#issuecomment-724888605):

Here is an example of what these changes look like when applied to a project: https://github.com/bcgov/openshift-postgresql-oracle_fdw/pull/11

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) commented at [2021-06-04 21:05](https://github.com/BCDevOps/OpenShift4-Migration/issues/15#issuecomment-854997077):

Update to this thread. `entitlements.yaml` is deprecated now.  Upon request (via https://chat.developer.gov.bc.ca/channel/general), Platform Services team will create 
- platform-services-controlled-etc-pki-entitlement Secret
- platform-services-controlled-rhsm-ca ConfigMap
- platform-services-controlled-rhsm-conf ConfigMap

Your Build config should reference these three resources.   A good example is at:
https://github.com/bcgov/von-bc-registries-agent-configurations/blob/878001e765c1052625393fda93355f5cd9ab1179/openshift/templates/bc-reg-fdw/bc-reg-fdw-build.yaml#L35-L45

TL;DR You cannot self-provision these.. you MUST go via Platform Services team.

#### <img src="https://avatars.githubusercontent.com/u/5686801?v=4" width="50">[Justin Pye](https://github.com/j-pye) commented at [2021-06-04 21:28](https://github.com/BCDevOps/OpenShift4-Migration/issues/15#issuecomment-855007178):

> Update to this thread. `entitlements.yaml` is deprecated now. Upon request (via https://chat.developer.gov.bc.ca/channel/general), Platform Services team will create
> 
> * platform-services-controlled-etc-pki-entitlement Secret
> * platform-services-controlled-rhsm-ca ConfigMap
> * platform-services-controlled-rhsm-conf ConfigMap
> 
> Your Build config should reference these three resources. A good example is at:
> https://github.com/bcgov/von-bc-registries-agent-configurations/blob/878001e765c1052625393fda93355f5cd9ab1179/openshift/templates/bc-reg-fdw/bc-reg-fdw-build.yaml#L35-L45
> 
> TL;DR You cannot self-provision these.. you MUST go via Platform Services team.

Just to add a little more info.

We provide the entitlements through the project registry. All teams have these in their tools namespaces by default. Sometimes the entitlements expire. I don't believe any of our projects are actually using entitlements so there's a chance we will not notice. There is some work that's either being done or was recently finished to monitor for new entitlements. Once we've been notified and the template for the entitlements has been updated it takes about an hour to roll out the changes to all tools namespaces.

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) commented at [2021-06-09 19:42](https://github.com/BCDevOps/OpenShift4-Migration/issues/15#issuecomment-858041953):

Thanks for the new docs.. hey can an admin update this part to NOT have the strikeout?  It led to confusion on the RC threads as looked like this was a self-serve thing but obviously it's not.  It's not so much the `entitlement.yaml` as it is the process.

> ~Until its fixed in OCP, the platform team can create a set of Secrets and ConfigMaps in your namespace to inject into your builds.~
> 
> ~Have a Platform Team member create the needed ConfigMaps and Secrets for Subscription Manager. Stored in a private repo https://github.com/bcgov-c/platform-tools/blob/ocp4-base/ocp4/entitlement.yaml~
>


-------------------------------------------------------------------------------

# [\#14 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/14) `open`: Cluster registry name change

#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) opened issue at [2020-10-27 22:28](https://github.com/BCDevOps/OpenShift4-Migration/issues/14):

# Need to know

The URL/name for the cluster registry has changed in OpenShift 4.  When migrating existing manifests or pipeline steps that reference the internal cluster registry, you will want to double-check your registry URL.

**Internal name** (accessing from a deployment manifest): `image-registry.openshift-image-registry.svc:5000`
**External name** (accessing from an external service or workstation): `https://image-registry.apps.silver.devops.gov.bc.ca`

## common errors

### Mistakenly using an external name in your deployment manifest
The in-cluster service accounts have default access tokens configured for the internal registry, but this does not include automatically logging into the external name.  Errors like the following indicate that you will want to change your registry reference in your deployment manifest to the **internal name** instead of the external route.

```
Failed to pull image "image-registry.apps.silver.devops.gov.bc.ca/e52f12-dev/patroni:v10-stable": rpc error: code = Unknown 
desc = Error reading manifest v10-stable in image-registry.apps.silver.devops.gov.bc.ca/e52f12-dev/patroni: unauthorized: 
authentication required
```

### Hard-coded registry name not changed during migration
Some deployment manifests and templates may still reference the OpenShift 3 registry DNS.  Check your manifest file for things like `docker-registry.default.svc:5000` or even an IP address like: `172.50.0.2:5000`.  If you see these in your manifests, you'll want to replace them with the **internal name**.


#### <img src="https://avatars.githubusercontent.com/u/24236108?v=4" width="50">[Steven Barre](https://github.com/StevenBarre) commented at [2020-10-27 22:36](https://github.com/BCDevOps/OpenShift4-Migration/issues/14#issuecomment-717580975):

The image registry in OCP4 is available internally via `image-registry.openshift-image-registry.svc:5000` and externally via `image-registry.apps.silver.devops.gov.bc.ca:443`. 

It appears that internal access works with local service accounts including the default `image-puller` and `builder` SAs out of the box. You should use this by default.

External access should be used with newly created service account when accessing the cluster from some other system.

#### <img src="https://avatars.githubusercontent.com/u/25966613?v=4" width="50">[Gary Wong](https://github.com/garywong-bc) commented at [2021-01-20 18:19](https://github.com/BCDevOps/OpenShift4-Migration/issues/14#issuecomment-763839519):

OCP3 names were:
Internal name: `docker-registry.default.svc:5000`
External name: `docker-registry.pathfinder.gov.bc.ca` 

Documenting here so that searches on the old names will return this issue.


-------------------------------------------------------------------------------

# [\#13 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/13) `open`: OpenShift CLI tips and tricks
**Labels**: `documentation`


#### <img src="https://avatars.githubusercontent.com/u/22400069?v=4" width="50">[Jeff](https://github.com/jefkel) opened issue at [2020-10-22 17:00](https://github.com/BCDevOps/OpenShift4-Migration/issues/13):

# Tips and tricks for using `oc` cli

This is a place to throw tips/tricks/shortcuts for using the `oc` cli with the new openshift 4 clusters.  Team members can update the description with tips/tricks added as comments

Let's gather up those tips and tricks!

## Access

Shortcut URL to directly request an authentication token (ie: *Copy login command* )
https://oauth-openshift.apps.silver.devops.gov.bc.ca/oauth/token/request





-------------------------------------------------------------------------------

# [\#12 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/12) `open`: Invalid value: []int64{1000}: 1000 is not an allowed group spec.containers[0].securityContext.securityContext.runAsUser: Invalid value: 1000: must be in the ranges: [1001090000, 1001099999]]

#### <img src="https://avatars.githubusercontent.com/u/19917617?v=4" width="50">[Karim Gillani](https://github.com/gil0109) opened issue at [2020-10-21 23:37](https://github.com/BCDevOps/OpenShift4-Migration/issues/12):

For Minio, we set securityContext.enabled=false

Install Minio Helm: 
git clone https://github.com/minio/charts
helm install --set persistence.size=10Gi --set securityContext.enabled=false minio minio
edit deployment yaml to fix minor error with memory





-------------------------------------------------------------------------------

# [\#11 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/11) `open`: Simple HELM install of RabbitMQ

#### <img src="https://avatars.githubusercontent.com/u/19917617?v=4" width="50">[Karim Gillani](https://github.com/gil0109) opened issue at [2020-10-21 23:33](https://github.com/BCDevOps/OpenShift4-Migration/issues/11):

- Installed via [Helm ](https://docs.openshift.com/container-platform/4.5/cli_reference/helm_cli/getting-started-with-helm-on-openshift-container-platform.html)
- git clone https://github.com/redhat-cop/containers-quickstarts
- cd /mnt/c/git/containers-quickstarts/rabbitmq
- oc project <project workspace to install to>
- helm install rabbitmq chart




-------------------------------------------------------------------------------

# [\#10 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/10) `open`: How can I leverage the new Artifactory service on the OCP 4 Platform to pull images?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-10-21 19:28](https://github.com/BCDevOps/OpenShift4-Migration/issues/10):

On November 4th Docker Hub implemented rate limits on the number of pulls from anonymous (100 image pulls) or free (200 image pulls) accounts. As a result, many teams may encounter this limit in the form of this (or similar) error:

> Error initializing source docker://node:lts-alpine: Error reading manifest lts-alpine in docker.io/library/node: toomanyrequests: You have reached your pull rate limit. You may increase the limit by authenticating and upgrading: https://www.docker.com/increase-rate-limit

If you encounter this error, you have two options:

1) Setup Artifactory and use it as a pull-through cache.

Your newly minted OCP4 `tools` namesapce will have your Artifactory username/password hidden in a secret. You can find instructions on what to do with them [here](https://developer.gov.bc.ca/Artifact-Repositories)

2) Setup your own team credentials as a pull secret and use those. 

Find instructions on how to do that [here](https://docs.openshift.com/container-platform/4.5/openshift_images/managing_images/using-image-pull-secrets.html#images-allow-pods-to-reference-images-from-secure-registries_using-image-pull-secrets)




-------------------------------------------------------------------------------

# [\#9 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/9) `open`: What are some of the way to migrate a Minio instance with data to the OCP 4 Platform?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-10-21 18:00](https://github.com/BCDevOps/OpenShift4-Migration/issues/9):

@jleach  can you please add the steps

#### <img src="https://avatars.githubusercontent.com/u/47604552?v=4" width="50">[BcGovNeal](https://github.com/BcGovNeal) commented at [2020-11-06 20:34](https://github.com/BCDevOps/OpenShift4-Migration/issues/9#issuecomment-723287484):

I have created a very simple Docker image layered on top of the official Minio Client docker image to assist Minio data migration between clusters.

This image can be run on OpenShift to enable cluster to cluster data migration.

The documentation ca be found in my repo at https://github.com/BcGovNeal/minio-client

#### <img src="https://avatars.githubusercontent.com/u/22400069?v=4" width="50">[Jeff](https://github.com/jefkel) commented at [2020-12-22 20:14](https://github.com/BCDevOps/OpenShift4-Migration/issues/9#issuecomment-749755051):

That's a great idea @BcGovNeal .  With the `mc` cli tool you're not just limited to mirroring between minio deployments, but you can use those notes to replicate to any S3 compatible datastore too!  (like the Hosting Services Object Storage - see https://github.com/BCDevOps/OpenShift4-Migration/issues/59 for more detail)

#### <img src="https://avatars.githubusercontent.com/u/47604552?v=4" width="50">[BcGovNeal](https://github.com/BcGovNeal) commented at [2021-01-06 23:20](https://github.com/BCDevOps/OpenShift4-Migration/issues/9#issuecomment-755774424):

I have an alternative method to sync files from Minio to another Minio instance or other S3 services  The reason I'm using this alternative method is because it can achieve much higher transfer speeds and it's more reliable in my own testing.

The alternative method works by running the `mc` cli tool directly in the source Minio instance on OCP.  The trick is to run the `mc` cli with the `--config-dir` or `-C` Global Options and set it to a directory that the user has write access to.  For example, if you're using the `openshift/minio` image then it can be set to `/opt/minio/.mc`.  By default, the `mc` cli will try to create the `.mc` directory in the root, which will encounter access denied error.  This is why the `--config-dir` option is needed.

**Example usage**
```
# Download mc cli to /opt/minio/mc
curl https://dl.min.io/client/mc/release/linux-amd64/mc -o /opt/minio/mc

# Set execute permission, may not be needed
chmod +x /opt/minio/mc

# Set sync target alias
/opt/minio/mc -C /opt/minio/.mc alias set target https://yourtargetservice.com your--access-id your-access-secret

# Sync Minio data to the target service bucket, assuming Minio data is stored in /data/uploads
/opt/minio/mc -C /opt/minio/.mc mirror /data/uploads target/bucketname
```


-------------------------------------------------------------------------------

# [\#8 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/8) `open`: What should I do when the app is fully migrated to OCP 4?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-10-21 17:12](https://github.com/BCDevOps/OpenShift4-Migration/issues/8):

Once you finished migrating an app to the Silver cluster, **please** 

1) Scale all your pods in all app namespaces on the OCP 3.11 Platform to 0
2) Submit a request to remove the namespaces from the OCP 3.11 Platform here:
 
https://github.com/BCDevOps/devops-requests/issues/new?assignees=caggles,+mitovskaol,+ShellyXueHan&labels=openshift-project-set,+pending&template=openshift_project_request.md&title=




-------------------------------------------------------------------------------

# [\#7 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/7) `open`: Is there a way to easily add team members to all OCP4 namspaces?

#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) opened issue at [2020-10-20 16:31](https://github.com/BCDevOps/OpenShift4-Migration/issues/7):

# TL;DR

RBAC. Use a YAML manifest with RBAC rules and keep it as part of your source control; keep in mind that the IDs added to your RBAC should be business contact details.

## Using RBAC for Access Control

You can create a manifest file in yaml that you can apply to each namespace to quickly grant and manage access to your namespaces. 

// TODO:(jl) Add sample RBAC manifest here.

#### <img src="https://avatars.githubusercontent.com/u/2684022?v=4" width="50">[Matthieu Foucault](https://github.com/matthieu-foucault) commented at [2020-11-06 23:44](https://github.com/BCDevOps/OpenShift4-Migration/issues/7#issuecomment-723349033):

https://github.com/bcgov/cas-pipeline/pull/32 (work in progress) might be of interest. TL;DR: One can do 
```
./lib/oc_add_gh_team_to_nsp.sh --token <your_gh_token> -t cas-owners -pp abc123,qwe456,321rty -r admin
```
To give admin access to everyone in the `bcgov/cas-owners` team, in all of the namespaces they want (`-pp` is short for `--project-prefixes`)


-------------------------------------------------------------------------------

# [\#6 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/6) `open`: Why do I see a network error in my Patroni logs?

#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) opened issue at [2020-10-17 00:27](https://github.com/BCDevOps/OpenShift4-Migration/issues/6):

# TL;DR

Your newly minted namespace on OCP4 uses Aporeto to create a zero trust network. As a result, none of your workload (pods) can talk to each other. You'll need to write some Network Security Policy (NSP) for your StatefulSet (patroni Pods) to talk to one another.

## Fixing Patroni Network Issues

If you're seeing something like the error below in your Patroni logs it often means your pods can't talk to one another. This is probably because you need to add some NSP to let them talk.

```console
2020-10-16 04:54:02,790 ERROR: ObjectCache.run ProtocolError('Connection broken: 
IncompleteRead(0 bytes read)', IncompleteRead(0 bytes read))
```

See the `db-to-db` NSP in [this example](https://github.com/bcgov/platform-services-registry/blob/master/openshift/templates/nsp.yaml). In the NSP the name of the StatefulSet is used as an identifier so that any pod that is a part of the StatefulSet can talk to any other member in the same set, as long as the pods are in the same namespace.






-------------------------------------------------------------------------------

# [\#5 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/5) `open`: Why can't my application on OCP4 talk to SSO on OCP3?

#### <img src="https://avatars.githubusercontent.com/u/390891?v=4" width="50">[Jason C. Leach](https://github.com/jleach) opened issue at [2020-10-17 00:02](https://github.com/BCDevOps/OpenShift4-Migration/issues/5):

# TL;DR
The current Pathfinder cluster on OCP3.11 is considered an external system to the new OCP4 Silver cluster. As a result, Aporeto needs you to grant permission for your Pod(s) to talk to said external system

# Talking to External System

Your newly minted namespace on OCP4 comes with the bare minimum Network Security Policy (NSP); it's just enough for very common tasks that every pod needs, like for example, talking to the Kubernetes API. Anything beyond this requires you to grant permission. You do this by wringing NSP. In this case, you need to do two things:

1. Create an External Network exposing ports 80 and 443.
2. Create NSP to let your Pod(s) talk to this External Network.

[Here](https://github.com/bcgov/platform-services-registry/pull/126/files) is a PR agains some existing NSP to do (1) and (2) above. In that example my API has a label `role=api` and I use that to help identify what is permitted to talk to the external network:

```
      source:
        - - '$namespace=${NAMESPACE}'
          - 'role=api'
      destination:
        - - 'ext:name=all-things-external'
```





-------------------------------------------------------------------------------

# [\#4 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/4) `open`: What can I do to prepare my app for migration to the OCP 4 Platform?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-09-21 23:38](https://github.com/BCDevOps/OpenShift4-Migration/issues/4):

Check out the [Migration Prep Checklist](https://github.com/BCDevOps/OpenShift4-Migration/blob/master/docs/pre-migration-cl.md) and [Planning Your Migration](https://github.com/BCDevOps/OpenShift4-Migration/blob/master/docs/planning-your-migration.md) docs for some useful information and continue checking time to time as these are living documents that will be updated with lessons learned from early adopters and the Platform Services team.






-------------------------------------------------------------------------------

# [\#3 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/3) `open`: How can I contribute to the migration documentation to help other teams?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-09-21 23:34](https://github.com/BCDevOps/OpenShift4-Migration/issues/3):

We suggest the following contribution process. 

- Start off by discussing a topic in #devops-ocp4-migration channel in Rocketchat with other early adopters and the Platform Services team. 

- Once a solution or a pro-tip is finalized, submit a GitHub issue in [OCP 4 Migration Repo](https://github.com/BCDevOps/OpenShift4-Migration/)

- the Platform Services team will merge frequently asked questions into the migration doc in the repo




-------------------------------------------------------------------------------

# [\#2 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/2) `open`: When can I migrate production workloads to the Silver cluster?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-09-21 23:31](https://github.com/BCDevOps/OpenShift4-Migration/issues/2):

The Silver cluster will be production-ready on Day 1 of "Early-Access" period, however, there will be more frequent change windows and maintenance activities during the "Early-Access" perion than the teams are used to in OCP 3.11 Platform as we will continue rolling out new features. 

All changes will be communicated to the early adopter teams in advance and the teams are expected to be available to test their applications after a change is complete to ensure the app recovered gracefully. 

The teams are expected to migrate their production workloads off the OCP 3.11 Platform onto the Silver cluster by the end of the "Early-Access" period.




-------------------------------------------------------------------------------

# [\#1 Issue](https://github.com/BCDevOps/OpenShift4-Migration/issues/1) `open`: What will my team get access to on Day 1 of "Early-Access"?

#### <img src="https://avatars.githubusercontent.com/u/28309901?v=4" width="50">[Olena Mitovska](https://github.com/mitovskaol) opened issue at [2020-09-21 23:24](https://github.com/BCDevOps/OpenShift4-Migration/issues/1):

The teams that have registered to be early adopter of the Openshift 4 Container Platform (OCP 4) will receive access to the following artifacts on the Silver cluster (the first production cluster of the new OCP 4 Platform):
- access for Product Owners to the new [Project Registry ](http://registry.developer.gov.bc.ca ) to request a project set provisioning (only IDIR-based authentication is supported at this moment). **PLEASE provide a meaningful project name (no abbreviations) and project description.**
- admin access to the 4 namespaces ('dev, test, tools and prod`) on the Silver cluster (once the provisioning request is approved and processed) for the Product Owner and the Tech Lead specified in the provisioning request. They can grant access to other team members as needed.
- access to the Artifactory caching repos (private repos will be available at a later stage) for caching images
- access to some bcgov custom images in the `openshift` namespace (backup and Patroni images only are availalbe at this moment )
- access to the #devops-ocp4-migration channel in RocketChat for connecting with other early adopters and the Platform Services team
- access to the oidc.gov.bc.ca SSO service name to update the app's integration with the KeyCloak SSO Service.




-------------------------------------------------------------------------------

