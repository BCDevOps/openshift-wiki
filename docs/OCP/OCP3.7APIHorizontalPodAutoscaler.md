# OpenShift 3.7 the API Schema change - HorizontalPodAutoscaler API Schema change

What changed:
* apiVersion :  was "apiVersion": "extensions/v1beta1" ; now is "apiVersion": "autoscaling/v1"
* spec.scaleTargetRef:  was "scaleRef"; now is "scaleTargetRef"

## Deploy Config prior to 3.7

```
{
  "kind": "HorizontalPodAutoscaler",
  "apiVersion": "extensions/v1beta1",
  "metadata": {
    "name": "${NAME}",
    "labels": {
      "app": "${NAME}"
    }
  },
  "spec": {
    "scaleRef": {
      "kind": "DeploymentConfig",
      "name": "${NAME}",
      "apiVersion": "extensions/v1beta1",
      "subresource": "scale"
    },
    "minReplicas": 2,
    "maxReplicas": 6
  }
}
```

## Deploy Config for 3.7+

```
{
  "kind": "HorizontalPodAutoscaler",
  "apiVersion": "autoscaling/v1",
  "metadata": {
    "name": "${NAME}",
    "labels": {
      "app": "${NAME}"
    }
  },
  "spec": {
    "scaleTargetRef": {
      "kind": "DeploymentConfig",
      "name": "${NAME}"
    },
    "minReplicas": 2,
    "maxReplicas": 6
  }
}
```