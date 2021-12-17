# ArgoCD Notifications

Applications in Argo CD may be configured to send a notification to a RocketChat channel or to an email address when a synchronization process fails.

See the [official documentation](https://argocd-notifications.readthedocs.io/en/stable/) for full details.

## Subscribe an application to a notification type
**RocketChat**

In order to send a notification to RocketChat, you must first [create an Integration](#create-webhook-integration).  This provides a unique webhook token used for posting messages to the given channel or user.

Using the Argo CD UI, edit the Application.
* In the Annotations section, click the Plus icon to add an annotation.
* To subscribe to a RocketChat alert, add two annotations:
    * Subscription
        * Key: `notifications.argoproj.io/subscribe.on-sync-failed.rocketchat-sync-failure`
        * Value: `""`
    * Webhook token
        * Key: `rocketchatWebhookToken`
        * Value: `YOUR-WEBHOOK-TOKEN`

**Email**

To configure an email alert, use the Argo CD UI to edit the Application and add one annotation:
* Key: `notifications.argoproj.io/subscribe.on-sync-failed.localsmtp`
* Value: `YOUR-EMAIL-ADDRESS`

Note that one application may have both subscriptions.

## Create a RocketChat webhook integration <a name="create-webhook-integration"></a>
For each RocketChat channel that will be used for notifications, create a webhook integration.  In the RocketChat app, go to:
Administration --> Integrations --> Incoming --> New

Enter the channel name to post to and post as `rocket.cat` (yes, that's rocket.CAT, not chat).

Click Save.

Copy the webhook URL for use in the configuration described above.

Once the setup is complete, you should receive the notification after the failure of a synchronization.

