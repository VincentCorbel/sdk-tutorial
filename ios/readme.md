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
