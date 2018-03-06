## Create a config map

1. Resources -> Config Maps -> Create Config Map
2. Add Config Map to application

## Mount the config map

YAML file should look like this (Caddyfile example):
```
         volumeMounts:
            - mountPath: /etc/Caddyfile
              name: test-caddy-conf
              subPath: Caddyfile
```
```
     volumes:
        - configMap:
            defaultMode: 420
            items:
              - key: Caddyfile
                path: Caddyfile
            name: caddy-conf
          name: test-caddy-conf
```
