# Request Project Set

Prior to this step is a manual/human step that involves a team lead / sponsor communicating with the DevOps team and having their project/app/product accepted for deployment on the DevOps platform.

Currently the projects deployed on the platform are focused on "Continuous Service Improvement Lab"-afficilated projects, and a handful of others.

Once a verbal approval has been received, a request should be made on the #requests channel of the Pathfinder DevOps Slack team. (Slack team URL: https://devopspathfinder.slack.com).

Ideally, the above requests should include:

1. the short team/organization name. Commonly, this is the ministry name plus program area/branch, but may also be just the program area. (e.g. MOTI, OCIO, NR, EAO, DEVEX)
2. product acronym/short name (e.g. EPIC, TFRS, IOT, etc.)
3. product full name (e.g. Transporation Fuels Reporting System)
4. One sentence product description
5. the desired environments (e.g. tools, dev, test, prod)
6. the GitHub ID and email address of the BC Gov employee who will be the owner/steward of the product. This should be someone with a hands-on technical skillset and is typically a developer or architect.
(if it exists) the GitHub repo that contains the app's code. Note this must be within the BCGov GitHub organization.

At this point a member of the core DevOps platform team will action the request and create an appropriately configured set of projects on OpenShift as described below. A notification email will be sent to the requestor when complete.

Reference:  https://github.com/BCDevOps/BCDevOps-Guide/blob/master/NewProjectSetup.md
