Great news for everyone in the BC Government who has closed-source code and still wants to leverage the power of GitHub, an online repository hosting service!

On this page you will find the informatiton that will help your team decide whether GitHub Enterprise service is right for your project: note, all code produced by BC Gov's teams should be open-source by default and closed-source e.g. private, by exception. You will also learn how to purchase user licenses for your team to work with the private repos linked to the Province's GitHub Enterprise account.


## When does your team need a GitHub Enterprise User License? 

 
As per the Province’s Digital Principles – 5. Work in The Open, OpenSource code base should first and foremost be considered whenever possible for your digital products.  All of the Province’s public code repositories on GitHub.com must live in public bcgov organization, to be consolidated within a central organization.  Github.com/bcgov has been properly procured with legal support, STRA and PIA for all of the Province’s OpenSource code.   


The Province also owns a private organization bcgov-c that serves as **temporary holding ground** for closed-sourced code and to be for staging the code that’s on its journey to OpenSource.  It is not to be used as a permanent code respository.  This staging environment was procured through a direct award, leveraging the same STRA and PIA for github.com/bcgov, as part of the evolution of the Province’s DevOps Platform, now known as Private Cloud and upcoming Public Cloud Pathfinder.  bcgov-c has a GitHub Teams license and requires a monthly user fee for every user that needs access to the private repos it contains. The GitHub Teams license includes community support (via GitHub Community Forum) + standard support model (via the GitHub Support Portal) 

 

If your code can never be OpenSource, and you are looking to leverage GitHub, you are recommended to use GitHub Enterprise.  It was procured as part of the Master Agreement with Microsoft. 

 

## What benefits do you get with the GitHub Enterprise User License? 

 

There a substantial collection of features that come with GitHub Enterprise, specifically over the free and Teams licenses.   

 

Here are major focus points when dealing with your code base if it can never see public consumption or become OpenSource.   

 

**Support** -> Enterprise license offers standard (via the GitHub Support Portal) + a premium support option, including phone support as well. 

 

**Security** ->  If you are looking to leverage GitHub.com’s features such code scanning, secrets scanning (like passwords, keys etc), and code dependency review including the ability to remove certain commits from the history (e.g. you accidentally included passwords or other sensitive info in your committed code), your private repositories can only use these features under the Enterprise account.  Free and Teams license only allows scanning public repositories, not private repositories. Enterprise license also comes with the advanced security portal/interface to gain additional insights into repo security that is not available in Free and Teams license.  To reduce your private code repos risk portfolio, Enterprise is the only option for IP white/black listing, and potential LDAP and SAML SSO should you eventually want to remove GitHub IDs and only integrate with IDIR ( this is still to be implemented). 

 

The full listing of differences between Free vs Teams vs Enterprise licenses is available here: 

https://github.com/pricing#compare-features 

 
## What is the total cost of ownership for the GitHub Enterprise User License? 

 

**$21CAD per user per month as per the Microsoft Master Agreement**.  Within GitHub Enterprise, a single user can have access to as many organizations with private repositories as required at no additional cost.   

 

## Who owns GitHub Enterprise account in BC Gov?

 

GitHub Enterprise account is owned by OCIO and managed by the Platform Services Team (Olena.Mitovska@gov.bc.ca and Justin.Hewitt@gov.bc.ca).  



## Who owns organizations linked to the BC Gov’s GitHub Enterprise account?

 

Ministries own GitHub organizations linked to the BC Gov’s GitHub Enterprise accounts and the private repos within their organizations.  

 
User licenses for accessing the private repos come from a central pool under the GitHub Enterprise account and must be purchased for each user that needs access to the private repos in the Ministry’s private organizations.   Management of this pool of seats will be done in partnership, with each sector/ministry purchasing their own allocated seat count. 


Also, when your private org is linked to the GitHub Enterprise account certain settings become automatically enabled/disabled. For example, the ability to create public repositories within this private org will be removed, as to fall in line with all Provincial Open Source code remaining in bcgov (all opensource code must be stored in bcgov org).  Additional information on settings can be found in ‘Settings’ tab on the organization profile page in GitHub after it is linked to the GitHub Enterprise account.  Further examples, 2MFA is set as mandatory, GitHub Actions is enabled for all, and Code Dependency Insights in enabled for all orgs linked to the GitHub Enterprise account.  Further settings to be shared. 

 

## How will you access the GitHub Enterprise account? 

 

Each Ministry has 1-2 GitHub admin users that manage user licenses purchased by the Ministry and assign individual users to the licenses. All license management and license-to-user assignment must go through Ministry account admins.   


*Step 1:* Your Ministry’s GitHub admin will have a private org created for your Ministry if it doesn’t exist already and link it to the GitHub Enterprise account.   

*Step 2:* Submit a request to Software Central Management as per the process below to purchase the desired number of user licenses. 

*Step 3:/* Once the Purchase Order has been processed and the new GitHub Enterprise User licenses have been added to the Province’s GitHub Enterprise account pool of seats, your Ministry’s GitHub admin will add your users (as many users as the purchased licenses) to the GitHub Enterprise account and to the Ministry’s private org. After this, these users will have access to all features available for the GitHub Enterprise users within their private org. 

 

## How to request a purchase of the GitHub Enterprise User Licenses? 

 

Contact Software Central Management at SoftwareCentral.Management@gov.bc.ca and cc: Dean Picton at Dean.Picton@gov.bc.ca, subject: GitHub Enterprise Request, with the following information:  

the Ministry the request is for: 

- Private GitHub organization name – indicate if you need a new org created or will be linking an existing private org  

- GitHub IDs of the org admins 

- Number of user licenses to purchase 

**If you are transferring an GitHub organization into Enterprise, you must have as many user licenses as you have org members that you are bringing in.**  

 

## How to pay for the GitHub Enterprise User Licenses? 

 
Software Central management handles your purchase order, with billing back to your expense authority. Note, the that Ministry will be billed monthly for the GitHub Enterprise User licenses until a request is sent to SoftwareCentral.Management@gov.bc.ca asking to cancel the user licenses.

##Can you help me understand what org should I use for my code?

Can your code be stored in a public space e.g. open-source today? If yes, create a repo in `bcgov`. Anyone with the `bcgov` membership can create repos in this org.

Do you have  code that will be made public within the next 12 months but needs to be kept private for now? If yes, submit a request to the Platform Service Team [here](https://github.com/BCDevOps/devops-requests/issues/new?assignees=caggles%2C+ShellyXueHan%2C+mitovskaol%2C+patricksimonian&labels=github-repo%2C+pending&template=github_repo_request.md&title=).

Do you have code that will never become open-source due to its sensitivity or security considerations? If yes, contact your Ministry GitHub admin to create a private repo for you in your Ministry's private org linked to the Province's GitHub Enterprise account.

 

 

 

 

 
 

