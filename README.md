#RocketPoSh
This is a Powershell module that sends messages to RocketChat.

First, copy **integration.js** to an incoming webhook integration script in the RocketChat admin console. Make sure the script is enabled, and if you want to be able to control the emoji or alias from the module, leave those fields empty here. Also, copy the webhook URL.

As a test, we'll just send a basic text message. Open Powershell and import the module. Assign the webhook URL to **$webhook**. You can then send a RocketChat message using Send-RocketMessage.

```powershell
Send-RocketMessage  -Webhook $webhook `
                    -Text "This is a test message!"

Get-Help Send-RocketMessage -Full
```