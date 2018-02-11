**Issue:**

Deployment fails due to image pull problem.

**Solution:**

- Ensure that appropriate image puller permissions exist.

```
  oc policy add-role-to-user system:image-puller system:serviceaccount:i<project-name>-dev:default -n <project-name>-tools
```

- You may have to re-tag the image (or redo the build).

```  
  oc tag <image>:lates <image:dev>
```

- Verify your image stream settings (Deployments-><youyr app>->edit): Images

