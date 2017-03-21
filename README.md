# PSPushBullet

A PowerShell module for invoking the Pushbullet API

## Supported Operations

### Pushes

* Create push types:
  * Note
  * Link
  * File (with existing file URL)
* Send push to targets:
  * User device
  * Channel

### Devices

* Get all devices for an account

### Channels

* Get channel information for a channel

## Usage

~~~~
New-PBPush -Title "Example" -Body "Push!" -Send
~~~~

~~~~
New-PBPush -Title "Example" -Body "Push!" | Send-PBPush -ChannelTag "ExampleChannel"
~~~~

~~~~
Get-PBDevices | where type -EQ "windows" | Send-PBPush -Push (New-PBPush -Title "Example" -Body "Push!")
~~~~