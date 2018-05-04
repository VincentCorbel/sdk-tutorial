## Migrate from 3.0

* In the Podfile, replace the current dependencie by pod "AdtagLocationDetection", '3.1.X'
* The "@import AdtagLocationBeacon;" must be replaced by "@import AdtagLocationDetection;"
* The AdtagBeaconManager must be replaced by the "AdtagPlaceDetectionManager"

## GDPR and Opt-in

* The SDK comes with a set of methods which helps you to manage the opt-ins to make your application GDPR compliant.
* You could find these methods with a description about "the how to use them" in the Optin class

## Disable the location permission when the application QuickStartTests

* Add a connectplace-settings.plist file to your pods_project
* Insert a askLocationPermissionAtStart parameter as boolean and set it to NO
* There is an example in the quickstart project

## Configure the permissions in the info.plist

In your info.plist add the following permissions
<key>NSBluetoothPeripheralUsageDescription</key>
<string>To detect the bluetooth status</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>To detect your location and beacons  on foreground and background</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>To detect your location and beacons  on foreground and background</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>To detect your location and beacons  on foreground</string>
<key>NSMotionUsageDescription</key>
<string>To display more accurate information associate to your location</string>

## In the application capabilities

* Activate the "location updates" in the background mode section

## When publishing

* refer to the following document https://docs.connecthings.com/3.0/ios/to-publish-an-ios-application.html
* In the App review section,

"Dear iOS App Review team,

Please note that our application is made to interact with beacons. You may test these interactions with a beacon configured with the following UUID / Major / Minor: [X / X / X]. You may discover all of the possible interactions between our application and the beacons in the following video: [video link].
The application is using geofences (CLCircularRegion) with location update in background to
give information about relevant point of interests when no beacons are available.
Using the location update in background permits to the app to display notifications only when a user is closed to the relevant point of interests"
