---
title: Jenkins Slaves Not Starting Issue
description: How to resolve this issue.
---
**Issue:**

Slaves do not start, following text: `Using 64 bit Java since OPENSHIFT_JENKINS_JVM_ARCH is not set


**Solution:**

Set Jenkins config setting - Maven Kubernetes option, new environment variable OPENSHIFT_JENKINS_JVM_ARCH with value of x86_64
