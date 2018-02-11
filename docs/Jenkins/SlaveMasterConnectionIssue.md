**Issue:**

Slaves start but cannot communicate with the master

**Solution:**

Set the Kubernetes Jenkins URL and JNLP fields to an appropriate value. If the values are appropriate, then check that the platform is not having DNS issues - it can get into a state where local services doe not resolve to valid IP addresses
