## Migrate from 3.0

* The package com.connecthings.util.adtag.beacon has been renamed com.connecthings.util.adtag.detection
* The AdtagBeaconManager from the package com.connecthings.util.adtag.beacon is now the AdtagPlaceDetectionManager from the package com.connecthings.util.adtag.detection

## GDPR and Opt-in

* The SDK comes with a set of methods which helps you to manage the opt-ins to make your application GDPR compliants.
* You could find these methods with a description about the how to use them in the Optin class

## Android 8+, Location and Foreground Notification

* On Android 8+, to be able to get precise location data, the SDK uses a foreground notification that is shown for few seconds
* The icon of the notification can be customized
* The title and description of the foreground notification can be customized declaring in your string resources xml file:

## Customizing the place Notification

* You can customize quickly the options of the current place notification (Icon of the notification, Notification Channel) with dedicated resources content
* You can learn more reading https://docs.connecthings.com/3.0/android/creating-beacon-notification.html#personalizing-the-notification-icon
