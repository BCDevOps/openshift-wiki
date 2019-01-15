---
description: How to siphon off monitoring data for later consumption.
---
# Azure Subscription Event Monitoring

## Purpose

When services are provisioned in an Azure subscription monitoring data is generated in the Activity Log. This data can be siphoned off to an Event Hub that buffers the events for later consumption. An Event Hub is the preferred mechanism to buffer the data because it provides a cursor like mechanism to ensure all events are read by the consumer.

To get mentally prepared for this adventure check out [Stream to Event Hub][Stream to Event Hub] and learn a bit about [Unified Alerts][Unified Alerts].

## Commands

Create an Event Hub namespace; this will act as a container for the logging Event Hub.

```console
az eventhubs namespace create --name my-eventhub-namespace-name --resource-group my-resource-group-name --enable-auto-inflate false --location canadacentral --capacity 1 --sku basic
```

```json
{
  "createdAt": "2018-08-17T17:35:55.067000+00:00",
  "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-resource-group-name/providers/Microsoft.EventHub/namespaces/my-eventhub-namespace-name",
  "isAutoInflateEnabled": false,
  "location": "Canada Central",
  "maximumThroughputUnits": 0,
  "metricId": "00000000-0000-0000-0000-000000000000:my-eventhub-namespace-name",
  "name": "my-eventhub-namespace-name",
  "provisioningState": "Succeeded",
  "resourceGroup": "my-resource-group-name",
  "serviceBusEndpoint": "https://my-eventhub-namespace-name.servicebus.windows.net:443/",
  "sku": {
    "capacity": 1,
    "name": "Basic",
    "tier": "Basic"
  },
  "tags": {},
  "type": "Microsoft.EventHub/Namespaces",
  "updatedAt": "2018-08-17T17:36:17.887000+00:00"
}
```

Next, create the actual Event Hub. Note the name here is *important*. It can not be named anything other that `insights-operational-logs`. Read more about the naming quirk [here][Stream Azure monitoring data]. You don't *need* to do this step because it will automatically be created when the first message arrives but I think its better to make sure it exists.

```console
az eventhubs eventhub create --name insights-operational-logs --namespace-name my-eventhub-namespace-name --resource-group my-resource-group-name --message-retention 1 --status Active
```

```json
{
  "captureDescription": null,
  "createdAt": "2018-08-17T20:02:22.523000+00:00",
  "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-resource-group-name/providers/Microsoft.EventHub/namespaces/my-eventhub-namespace-name/eventhubs/insights-operational-logs",
  "location": "Canada Central",
  "messageRetentionInDays": 1,
  "name": "insights-operational-logs",
  "partitionCount": 4,
  "partitionIds": [
    "0",
    "1",
    "2",
    "3"
  ],
  "resourceGroup": "my-resource-group-name",
  "status": "Active",
  "type": "Microsoft.EventHub/Namespaces/EventHubs",
  "updatedAt": "2018-08-17T20:02:22.697000+00:00"
}
```

There are two ways to get Azure subscription monitoring data into and Event Hub: 

1) subscription diagnostic setting or;
2) log profile.

These two options are discussed in more detail in the blog post [Stream Azure monitoring data]. You can also read more on Azure Activity [here][Activity logs]. 

Create a monitoring log profile with the command below. When the first event is created it will automatically create an event hub named `insights-operational-logs` in the newly created namespace above.

```console
az monitor log-profiles create --name "default" --location null --locations "canadacentral" --categories "Delete" "Write" "Action" --enabled true --days 0 --service-bus-rule-id "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-resource-group-name/providers/Microsoft.EventHub/namespaces/my-eventhub-namespace-name/authorizationrules/RootManageSharedAccessKey"
```

```json
{
  "categories": [
    "Delete",
    "Write",
    "Action"
  ],
  "id": "/subscriptions/00000000-0000-0000-0000-000000000000/providers/microsoft.insights/logprofiles/default",
  "identity": null,
  "kind": null,
  "location": "null",
  "locations": [
    "canadacentral"
  ],
  "name": "default",
  "retentionPolicy": {
    "days": 0,
    "enabled": true
  },
  "serviceBusRuleId": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-resource-group-name/providers/Microsoft.EventHub/namespaces/my-eventhub-namespace-name/authorizationrules/RootManageSharedAccessKey",
  "storageAccountId": null,
  "tags": null,
  "type": null
}
```

## Sample Messages

Below are some sample messages created by Azure for creating and deleting storage accounts.'

### Create Storage Account

```json
[
  {
    "subject": "/subscriptions/09c62126-39f7-44fc-81bd-7bb17bf61abc/resourcegroups/bc-gov-aks-osba/providers/Microsoft.Storage/storageAccounts/aaabbb123xws",
    "eventType": "Microsoft.Resources.ResourceWriteSuccess",
    "eventTime": "2018-08-16T17:57:55.6104343Z",
    "id": "bd96de07-6ab6-46c7-b453-c51a0554c988",
    "data": {
      "authorization": {
        "scope": "/subscriptions/09c62126-39f7-44fc-81bd-7bb17bf61abc/resourcegroups/bc-gov-aks-osba/providers/Microsoft.Storage/storageAccounts/aaabbb123xws",
        "action": "Microsoft.Storage/storageAccounts/write",
        "evidence": {
          "role": "Owner",
          "roleAssignmentScope": "/subscriptions/09c62126-39f7-44fc-81bd-7bb17bf61abc",
          "roleAssignmentId": "7c9283d62e844fb88f452ed4d221bf86",
          "roleDefinitionId": "8e3af657a8ff443ca75c2fe8c4bcb635",
          "principalId": "3fb3e254bb544681982c1325502ca8a9",
          "principalType": "User"
        }
      },
      "claims": {
        "aud": "https://management.core.windows.net/",
        "iss": "https://sts.windows.net/6fdb5200-3d0d-4a8a-b036-d3685e359adc/",
        "iat": "1534439095",
        "nbf": "1534439095",
        "exp": "1534442995",
        "http://schemas.microsoft.com/claims/authnclassreference": "1",
        "aio": "42BgYKi7+5Pr33Fmi5cRjA797+1/b1ifz8Bbnc8aUFQbmzbH+5R3lsnNxKZqZVs7yZd/Q5iSAQ==",
        "altsecid": "5::10030000AD1D8F18",
        "http://schemas.microsoft.com/claims/authnmethodsreferences": "pwd",
        "appid": "c44b4083-3bb0-49c1-b47d-974e53cbdf3c",
        "appidacr": "2",
        "e_exp": "262800",
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress": "jason.leach@fullboar.ca",
        "http://schemas.microsoft.com/identity/claims/identityprovider": "https://sts.windows.net/aabf6335-c4c4-48ed-8cdd-cbfb4baeb603/",
        "ipaddr": "207.194.65.204",
        "name": "jason.leach",
        "http://schemas.microsoft.com/identity/claims/objectidentifier": "3fb3e254-bb54-4681-982c-1325502ca8a9",
        "puid": "1003BFFDAD2853E7",
        "http://schemas.microsoft.com/identity/claims/scope": "user_impersonation",
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier": "q5akcIxRLA00dlQpTEZRiD5Hc9LG94Kuhz6PzQqfgxY",
        "http://schemas.microsoft.com/identity/claims/tenantid": "6fdb5200-3d0d-4a8a-b036-d3685e359adc",
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name": "jason.leach@fullboar.ca",
        "uti": "l78lBQsynU2PJFd8LC8qAA",
        "ver": "1.0"
      },
      "correlationId": "4f8c6277-ce68-4c97-9f8f-e59aaaff2bef",
      "resourceProvider": "Microsoft.Storage",
      "resourceUri": "/subscriptions/09c62126-39f7-44fc-81bd-7bb17bf61abc/resourcegroups/bc-gov-aks-osba/providers/Microsoft.Storage/storageAccounts/aaabbb123xws",
      "operationName": "Microsoft.Storage/storageAccounts/write",
      "status": "Succeeded",
      "subscriptionId": "09c62126-39f7-44fc-81bd-7bb17bf61abc",
      "tenantId": "6fdb5200-3d0d-4a8a-b036-d3685e359adc"
    },
    "dataVersion": "2",
    "metadataVersion": "1",
    "topic": "/subscriptions/09c62126-39f7-44fc-81bd-7bb17bf61abc"
  }
]
```

### Delete Storage Account

```json
[
  {
    "subject": "/subscriptions/09c62126-39f7-44fc-81bd-7bb17bf61abc/resourceGroups/bc-gov-aks-osba/providers/Microsoft.Storage/storageAccounts/aaabbb123xws",
    "eventType": "Microsoft.Resources.ResourceDeleteSuccess",
    "eventTime": "2018-08-16T17:59:44.4653401Z",
    "id": "94d3b126-3646-4093-a94a-489cf47d2bd8",
    "data": {
      "authorization": {
        "scope": "/subscriptions/09c62126-39f7-44fc-81bd-7bb17bf61abc/resourceGroups/bc-gov-aks-osba/providers/Microsoft.Storage/storageAccounts/aaabbb123xws",
        "action": "Microsoft.Storage/storageAccounts/delete",
        "evidence": {
          "role": "Owner",
          "roleAssignmentScope": "/subscriptions/09c62126-39f7-44fc-81bd-7bb17bf61abc",
          "roleAssignmentId": "7c9283d62e844fb88f452ed4d221bf86",
          "roleDefinitionId": "8e3af657a8ff443ca75c2fe8c4bcb635",
          "principalId": "3fb3e254bb544681982c1325502ca8a9",
          "principalType": "User"
        }
      },
      "claims": {
        "aud": "https://management.core.windows.net/",
        "iss": "https://sts.windows.net/6fdb5200-3d0d-4a8a-b036-d3685e359adc/",
        "iat": "1534441818",
        "nbf": "1534441818",
        "exp": "1534445718",
        "http://schemas.microsoft.com/claims/authnclassreference": "1",
        "aio": "ATQAy/8IAAAAm4ZJcf3XY57cYnGCHGRGwrWVInUsXIPyiujga6JURU3qXme7yI8jUgEbG7+qg4rf",
        "altsecid": "5::10030000AD1D8F18",
        "http://schemas.microsoft.com/claims/authnmethodsreferences": "pwd",
        "appid": "c44b4083-3bb0-49c1-b47d-974e53cbdf3c",
        "appidacr": "2",
        "e_exp": "262800",
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress": "jason.leach@fullboar.ca",
        "http://schemas.microsoft.com/identity/claims/identityprovider": "https://sts.windows.net/aabf6335-c4c4-48ed-8cdd-cbfb4baeb603/",
        "ipaddr": "207.194.65.204",
        "name": "jason.leach",
        "http://schemas.microsoft.com/identity/claims/objectidentifier": "3fb3e254-bb54-4681-982c-1325502ca8a9",
        "puid": "1003BFFDAD2853E7",
        "http://schemas.microsoft.com/identity/claims/scope": "user_impersonation",
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier": "q5akcIxRLA00dlQpTEZRiD5Hc9LG94Kuhz6PzQqfgxY",
        "http://schemas.microsoft.com/identity/claims/tenantid": "6fdb5200-3d0d-4a8a-b036-d3685e359adc",
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name": "jason.leach@fullboar.ca",
        "uti": "QhBuqpJgmkmHhF2F1XAhAA",
        "ver": "1.0"
      },
      "correlationId": "94d3b126-3646-4093-a94a-489cf47d2bd8",
      "httpRequest": {
        "clientRequestId": "964331c5-5619-476e-b191-a3f8477bf041",
        "clientIpAddress": "207.194.65.204",
        "method": "DELETE",
        "url": "https://management.azure.com/subscriptions/09c62126-39f7-44fc-81bd-7bb17bf61abc/resourceGroups/bc-gov-aks-osba/providers/Microsoft.Storage/storageAccounts/aaabbb123xws?api-version=2018-02-01"
      },
      "resourceProvider": "Microsoft.Storage",
      "resourceUri": "/subscriptions/09c62126-39f7-44fc-81bd-7bb17bf61abc/resourceGroups/bc-gov-aks-osba/providers/Microsoft.Storage/storageAccounts/aaabbb123xws",
      "operationName": "Microsoft.Storage/storageAccounts/delete",
      "status": "Succeeded",
      "subscriptionId": "09c62126-39f7-44fc-81bd-7bb17bf61abc",
      "tenantId": "6fdb5200-3d0d-4a8a-b036-d3685e359adc"
    },
    "dataVersion": "2",
    "metadataVersion": "1",
    "topic": "/subscriptions/09c62126-39f7-44fc-81bd-7bb17bf61abc"
  }
]```

## Consuming Events

Google around and you'll find lots of examples of how to consume events from and event hub. Here is one such [example][Event Hubs with Node] of how to do it in node.




[Stream Azure monitoring data]: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitor-stream-monitoring-data-event-hubs

[Activity logs]: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-activity-logs

[Event Hubs with Node]:[https://github.com/Azure/azure-event-hubs-node/tree/master/client]

[Stream to Event Hub]: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-stream-activity-logs-event-hubs

[Unified Alerts]: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-unified-alerts
