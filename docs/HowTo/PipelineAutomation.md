---
description: This page provides guidance to the teams in BC Gov that look to get started with encorporating Continuous integration (CI) and continuous delivery (CD) into the lifecycle of their application hosted on the Private Cloud Openshift Platform. 
title: CI/CD with Pipeline Automation
tags:
  - continuous integration
  - continuous deployment
  - pipeline
  - template
  - ArgoCD
  - Tekton
  - Openshift Pipelines
  - GitHub Actions
---

# Use of CI/CD Pipeline Templates for Private Cloud teams

So now you have built a new and shiny app and want to deploy it to the BC Gov's Private Cloud Openshift Platform. You also want to take advantage of the Continuous integration (CI) and Continuous delivery (CD) power that can enable your team to automatically build, test, and prepare code changes for release to production so that your software delivery is more efficient, rapid and - **very importantly** - secure.
To help teams like yours that want to get started with pipeline automation quickly or wonder what the best security practices for pipeline development are, or both!, we have created pipeline templates for the  automation technologies supported<sup>[^1](#myfootnote1)</sup> on the Private Cloud Platform.

## Who can use these pipeline templates?

Any product teams working in the Silver and Gold clusters on the Private Cloud Platform. 

## How to get started with the pipeline templates?

Head out to the [Security Pipeline Templates](https://github.com/bcgov/security-pipeline-templates) repo to find easy-to-follow guides for getting started with each of the supported technology.

## What automation technologies are supported on the Platform?

At this moment, the following technologies are available to the product teams:
- ArgoCD (Coming Soon!)
- [GitHub Actions](https://github.com/bcgov/security-pipeline-templates/tree/main/.github/workflows)
- [Openshift Pipelines (Tekton)](https://github.com/bcgov/security-pipeline-templates/tree/main/tekton) 

While Jenkins is technically supported on the Platform we **highly discourage** teams from using this technology as it is highly inefficient with the use of valuable Platform resources. Over the next few months we will be guiding the teams that currently use Jenkins to transition to a more modern and efficient technology such as those listed above.

## How do I decide which of these technologies to use?

The final decision should be made by each team and may depend on their previous experience and comfort for each tool. We would like to offer the following rule of thumb:

For teams with limited to no previous experience developing automation pipelines, the combination of Github Actions for builds and ArgoCD for deployments is recommended.

For more mature teams with previouse automation expereince, Openshift Pipelines is a good choice.

Finally, while teams can use GitHub Actions for both builds (CI) and deployments (CD), we feel that ArgoCD provides more control over the success of the deployment and brings many other benefits of the Infrastructure as Code / GitOps approach such as observability, improved stability and consistency, and an improved security model to name a few.  If you are interested to learn in more detail our team members' opinions about each tool, you can follow their discussion [here](https://app.zenhub.com/workspaces/platform-experience-5bb7c5ab4b5806bc2beb9d15/issues/bcdevops/developer-experience/1772).

## I know how to make the pipeline templates better, how can I help?

You are welcome to fork a repo and add more steps to the templates or make any modifications that you think will make the template better. Submit a PR and tag any of the Platform Admins for review and we will send some good karma your way!

We hope that these pipeline templates will enable your team to enjoy the power or CI/CD automation and the best app security practices with less effort so you can spend this time on what most teams enjoy the most - building better digital services for citizens of our beautiful province.

<em>Love, Platform Services Team, xo</em>

<sub><sup><a name="myfootnote1">1</a>: By **supported** we mean that not only this technology is available today on the Platform but also the Platform Services Team has expertise with this technology to help the product teams using it. While teams can absolutely use any other automation technology outside of the Platform, we may not have the expertise to support them if they need help.</sup></sub>
