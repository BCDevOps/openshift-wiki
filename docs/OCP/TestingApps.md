## Testing if apps is up via cmd line curl

```
while true; do curl -I http://<APPS-URL-PATH>/ \ 2>/dev/null | head -n 1 | cut -d$' ' -f2; sleep 1; done
```
