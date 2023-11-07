# Kustomize Upgrade, v4 to v5

The upgrade of Argo CD from 2.6 to 2.8 includes a change in the bundled Kustomize from version 4 to version 5

Users of our community instance of Argo CD may need to make some changes to their `kustomization.yaml` files.

Notable changes include:
* The `patches` directive supports a new syntax.
* `patches` is no longer an alias for `patchesStrategicMerge`.
* `bases` has been merged with `resources`.
* Duplicate fields will generate an error instead of being silently ignored.

## How to test your GitOps repository
The best way to test your GitOps repo is to get v5 of the `kustomize` CLI and run `kustomize build` against your repo.  If you don't have v5 of `kustomize` on your workstation, you could run a Docker container that has it and clone your GitOps repo into that.

For example, the alpine/k8s image version 1.24.16 has the same versions of Kustomize and Helm as Argo CD 2.8 and includes the `git` CLI.
```
docker run -it --rm alpine/k8s:1.24.16 bash
```

### Patches
`patches` requires a path label for files in a list.

OLD:
```
patches:
  - patch.deployment.yaml
  - patch.route.yaml
```
NOW:
```
patches:
  - path: patch.deployment.yaml
  - path: patch.route.yaml
```
See: https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patches/

**Note:** Patch should have just one resource in them.  Split them out into multiple files.


### kustomize edit fix
Once your patches are compliant, you can fix up any other issues by running `kustomize edit fix` in the same directory as your kustomization.yaml file.  It will move any entries from `bases` to `resources` as well as other possible fixes.

For example, where a kustomization.yaml may have had:
```
bases:
  - ../base/server
resources:
  - configmap.special-config.yaml
```
This would now be:
```
resources:
  - configmap.special-config.yaml
  - ../base/server
```

Here is some example output from the command.  Carefully check the output for additional warnings.
```
$ kustomize edit fix
# Warning: 'bases' is deprecated. Please use 'resources' instead. Run 'kustomize edit fix' to update your Kustomization automatically.
# Warning: 'patchesStrategicMerge' is deprecated. Please use 'patches' instead. Run 'kustomize edit fix' to update your Kustomization automatically.

Fixed fields:
  patchesJson6902 -> patches
  patchesStrategicMerge -> patches
  commonLabels -> labels

To convert vars -> replacements, run the command `kustomize edit fix --vars`

WARNING: Converting vars to replacements will potentially overwrite many resource files and the resulting files may not produce the same output when `kustomize build` is run.

We recommend doing this in a clean git repository where the change is easy to undo.
```

## Official documentation
Kustomize v5 release notes  
https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv5.0.0
  
From Argo CD 2.6 to 2.8, Helm is upgraded from v3.10.0 to v3.12.1  
https://github.com/helm/helm/releases/tag/v3.12.0  
  
Argo CD 2.8 release notes  
https://github.com/argoproj/argo-cd/releases/tag/v2.8.0


