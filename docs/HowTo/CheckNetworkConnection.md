
## Checking network connectivity of a pod to an external system


To verify tcp connection w/o requiring any tools installed 

```
oc rsh <pod>

timeout 5 bash -c "</dev/tcp/google.ca/443"; echo $?
```

this returns a 0 if connetion to google.ca on port 443 could be established within timeout period, if it returns anything else connection could not be established.

