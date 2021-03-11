# Load Testing Guidelines for Ministry Apps Hosted in Silver and Gold cluster of BC Gov's Openshift 4 Platform

So you want to load-test your app? That sounds like a great idea!

Because this is a shared platform and because we (the Platform Services Team) want to make sure that you have the most successful test possible, there are a few things we require for any potential load test occurring on the Silver or Gold clusters of the BC Gov's Openshift 4 DevOps  Platform:

1. The test must take place after 5:30pm on a weekday
1. The maximum number of **concurrent sessions** during load testing must be restricted to 40K
1. There must be a Platform Team member present during the test

The first two are simply to ensure that your testing doesn't create any undue impact on other applications running on the cluster. This is very unlikely, as OpenShift typically does a good job of isolating each namespace effectively, but there can be unexpected outcomes to some tests, and sometimes tests can impact other shared services in unexpected ways. These requirements are intended to minimize the impact of these sorts of unexpected outcomes!

The third is for both the benefit of your team and the benefit of the Platform as a whole. We want to be able to keep an eye on the Platform during the test so we can react in case the test does something unexpected which might impact shared services. We also want to have someone around who can provide you with some support if something unexpected happens during the test and you require someone with elevated privileges on the Platform to take action. It also allows us to ensure that we don't have several teams accidentally scheduling their load-tests for the same time!

## What Does This Mean for Me?

In practice, we have a few steps that we'll need you to follow before you perform a load test!

First, you'll need to create a **load test plan** which outlines the duration of the test, ramp up time, speed, and any other relevant information you feel the platform team should have going in. Make sure it follows the requirements above!

Second, you'll need to speak to the Platform Services TTeam about scheduling your test (for after 5:30pm on a weekday, remember!) - we'll need to take a look at your load test plan, make sure we have all the information we need for the test, and make sure that we have someone available during your chosen testing window. We'll work with you if we need to request any alterations to either the time/date or the plan! Contact @olena.mitovska in [RocketChat](https://chat.developer.gov.bc.ca) to get that process started.

Assuming all goes well, your plan will be green-lit, and... that's it! Off you go to perform your load test!


