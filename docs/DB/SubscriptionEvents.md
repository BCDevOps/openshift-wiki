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

## Consuming Events

Google around and you'll find lots of examples of how to consume events from and event hub. Here is one such [example][Event Hubs with Node] of how to do it in node.




[Stream Azure monitoring data]: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitor-stream-monitoring-data-event-hubs

[Activity logs]: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-activity-logs

[Event Hubs with Node]:[https://github.com/Azure/azure-event-hubs-node/tree/master/client]

[Stream to Event Hub]: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-stream-activity-logs-event-hubs

[Unified Alerts]: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-unified-alerts
