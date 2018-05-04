## Migrate from 3.0

* In the build.gradle, replace your current dependency by: implementation "com.connecthings.adtag:android-adtag-detection:3.1.xx"
* The package com.connecthings.util.adtag.beacon has been renamed com.connecthings.util.adtag.detection
* The AdtagBeaconManager from the package com.connecthings.util.adtag.beacon is now the AdtagPlaceDetectionManager from the package com.connecthings.util.adtag.detection

## GDPR and Opt-in

* The SDK comes with a set of methods which helps you to manage the opt-ins to make your application GDPR compliants.
* You could find these methods with a description about the how to use them in the Optin class

## Android 8+, Location and Foreground Notification

* On Android 8+, to be able to get precise location data, the SDK uses a foreground notification that is shown for a few seconds
* The title and description of the foreground notification can be customized declaring in your string resources xml file:

```xml
<string name="foreground_notification_title">QuickStart</string>
<string name="foreground_notification_description">Looking for nearby points of interests</string>
```

## Customizing the Place Notification

* You can customize quickly the options of the current place notification (icon of the notification, the options of the NotificationChannel) with dedicated resources content
* You can learn more reading [our documentation](https://docs.connecthings.com/3.0/android/creating-beacon-notification.html#personalizing-the-notification-icon)
