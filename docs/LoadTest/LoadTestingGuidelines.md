---
description: Load Testing Guidelines for Ministry Apps Hosted in Silver and Gold cluster of BC Gov's Openshift 4 Platform
resourceType: Documentation
title: Load Testing Guidelines
tags:
- Application Profiling
- Profiling
- Network Traffic
- Bandwidth
- Resiliency
- HA
- High Availability
- Fail over
- Testing
- Guidelines
- Silver
- Gold
- Openshift
---
# Load Testing Guidelines for Ministry Apps Hosted in Silver and Gold cluster of BC Gov's Openshift 4 Platform

So you want to load-test your app? That sounds like a great idea!

Because this is a shared platform and because we (the Platform Services Team) want to make sure that you have the most successful test possible, there are a few things we require for any potential load test occurring on the Silver or Gold clusters of the BC Gov's Openshift 4 DevOps  Platform:

1. The test must take place after 5:30pm on a weekday
1. The maximum number of **concurrent sessions** during load testing must be restricted to 40K
1. There must be a Platform Team member present during the test

The first two are simply to ensure that your testing doesn't create any undue impact on other applications running on the clusters<sup>[^1](#myfootnote1)</sup>. This is very unlikely, as OpenShift typically does a good job of isolating each namespace effectively, but there can be unexpected outcomes to some tests, and sometimes tests can impact other shared services in unexpected ways. These requirements are intended to minimize the impact of these sorts of unexpected outcomes!

The third is for both the benefit of your team and the benefit of the Platform as a whole. We want to be able to keep an eye on the Platform during the test so we can react in case the test does something unexpected which might impact shared services. We also want to have someone around who can provide you with some support if something unexpected happens during the test and you require someone with elevated privileges on the Platform to take action. It also allows us to ensure that we don't have several teams accidentally scheduling their load-tests for the same time!

## What Does This Mean for Me?

In practice, we have a few steps that we'll need you to follow before you perform a load test!

First, you'll need to create a **load test plan** which outlines the following: 
- Duration of the test and desired weekday to run it
- Which app namespaces will be targeted e.g. prod only or both test and prod 
- Ramp up time and speed
- What constitutes a success/failure of the test? e.g. response time shall be under 2 seconds at all times, less than 10% errors in the response, etc
- Where will the generated traffic be coming from? e.g. outside of the BC Gov network or internally
- Does the app rely on anything off cluster? e.g. a backend DB in ZoneB or an external API that is called out to, etc.
- Include any other relevant information you feel the Platform Services Team should have going in. 
 
Providing a comprehensive test plan that includes all abovementioned  information  increases your chances of getting it approved quickly. 

Second, you'll need to speak to the Platform Services Team about scheduling your test (for after 5:30pm on a weekday, remember!) - we'll need to take a look at your load test plan, make sure we have all the information we need for the test, and make sure that we have someone available during your chosen testing window. We'll work with you if we need to request any alterations to either the time/date or the plan! Contact [@olena.mitovska](https://chat.developer.gov.bc.ca/direct/olena.mitovska) in RocketChat.

Assuming all goes well, your plan will be green-lit, and... that's it! Off you go to perform your load test!

<em>Love, Platform Services Team, xo</em>

<sub><sup><a name="myfootnote1">1</a>: As of spring 2021, the Silver cluster of OpenShift 4 Platform includes 6 router nodes which together can handle 60K **concurrent active connections**. Browsers and other clients will usually hold a connection open for some time and make multiple requests in the same connection or use a long running connection for things like websockets. To keep the cluster stable and healthy, only 2/3 of the overall routing capacity can be targeted by the application load test.</sup></sub>

