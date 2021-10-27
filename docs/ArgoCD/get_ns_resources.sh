#!/bin/sh
#
# get_ns_resources.sh
#
# Get resources in a namespace in preparation for migration to Argo CD
#
# Requirements:
#	oc
#	jq
#	yq
#
# This script is meant to make it easier to migrate an app that is not already 
# configured for Kustomize.  In order to populate the manifest repo that Argo CD
# reads from, we can get the YAML definitions from OpenShift.  There are a 
# number of fields added to resource definitions by OpenShift, so we remove 
# those.
# Consider this script a work in progress.  There may be other fields that 
# should be excluded, or better ways to achieve the same goal.
# Note that some resources, such as Secrets, are not included in this script.
# ------------------------------------------------------------------------------

# Check OCP login and project
# ---------------------------
unset GET_RESOURCES_PROJECT
GET_RESOURCES_PROJECT=`oc project`
if [ -z "$GET_RESOURCES_PROJECT" ]; then
  echo ""
  echo "Please log in to OpenShift and select your namespace."
  echo ""
  exit 1
else
  echo ""
  echo $GET_RESOURCES_PROJECT
  echo ""
fi

if [ ! -d lists ]; then mkdir lists; fi
if [ ! -d manifests ]; then mkdir manifests; fi

# Create lists of resources
# -------------------------
echo "# Generating resource lists"
echo "# -------------------------"
for resource in configmap deployment deploymentconfig pvc route service statefulset; do
  echo "lists/${resource}.txt"
  oc get $resource -o custom-columns=NAME:.metadata.name --no-headers=true > lists/${resource}.txt
done
echo ""

# Create a YAML file for each resource, omitting auto-generated fields
# --------------------------------------------------------------------
echo "# Collecting resource details"
echo "# ---------------------------"
for resource in configmap deployment deploymentconfig route service statefulset; do
  for i in `cat lists/${resource}.txt`; do
    MANIFEST_FILE="manifests/${resource}.${i}.yaml"
    echo $MANIFEST_FILE

    # Remove a number of unneeded fields if they exist
    oc get $resource $i -o json | jq '
if .metadata.annotations["kubectl.kubernetes.io/last-applied-configuration"] != null then del(.metadata.annotations["kubectl.kubernetes.io/last-applied-configuration"]) else . end |
if .metadata.creationTimestamp != null then del(.metadata.creationTimestamp) else . end |
if .metadata.generation != null then del(.metadata.generation) else . end |
if .metadata.managedFields != null then del(.metadata.managedFields) else . end |
if .metadata.resourceVersion != null then del(.metadata.resourceVersion) else . end |
if .metadata.selfLink != null then del(.metadata.selfLink) else . end |
if .metadata.uid != null then del(.metadata.uid) else . end |
if .spec.clusterIP != null then del(.spec.clusterIP) else . end |
if .status != null then del(.status) else . end' | yq -P eval > $MANIFEST_FILE
  done
done
