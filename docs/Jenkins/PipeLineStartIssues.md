***Issue:***

 Jenkins Pipelines not starting - Developers using a Chrome extension

***Case:*** 

Contractors were using a chrome extension to auto complete and submit jenkins jobs through the browser. Developer renamed a few projects which caused them to recreate others, all with the same name, which caused name  collision. 
Cleanup of this in the end required to completely remove the pipelines and re-create them.

***Issue:***

Jenkins Pipeline not starting - Kubernet plugin upgraded

*** Solution:***

The Kubernet plugin versio 1.1.3+ causes a problem with OpenShift 3.6. 
RESOLUTION: Downgrade the plugin to 1.1.3 or lower.
