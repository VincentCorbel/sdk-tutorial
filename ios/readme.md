## Migrate from 3.0

* In the Podfile, replace the current dependencie by pod "AdtagLocationDetection", '3.1.X'
* The "@import AdtagLocationBeacon;" must be replaced by "@import AdtagLocationDetection;"
* The AdtagBeaconManager must be replaced by the "AdtagPlaceDetectionManager"
