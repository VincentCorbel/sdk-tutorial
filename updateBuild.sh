#!/bin/bash

echo -e "\t\t..:::: Update build ::::.." 
read -ep "OS (all [default], android [a], objectivec [o] and swift [s])? " os 
read -ep "Release version? " version 
echo ""

function updateAndroidBuild() {
	grep -r --include \*.gradle -lE "$1" android | xargs sed -i '' "s/\($1:\).[^\"]*\(.*\)/\1"$version"\2/g"
}

function updateIOSBuild() {
	grep -rlE "$1" "$2" | xargs sed -i '' "s/\($1, '~> \).[^\']*\(.*\)/\1"$version"\2/g"
}

case "$os" in
	"android" | "a" )
	updateAndroidBuild "com.connecthings.adtag:android-adtag-beacon"
	# updateAndroidBuild "com.android.support:appcompat-v7"
	exit 1;;

	"objectivec" | "o" )
	updateIOSBuild "pod \"AdtagLocationBeacon\"" "ios/ObjectiveC"
	updateIOSBuild "pod \'AdtagLocationBeacon\'" "ios/ObjectiveC"
	exit 1;;

	"swift" | "s" )
	updateIOSBuild "pod \"AdtagLocationBeacon\"" "ios/swift" 
	updateIOSBuild "pod \'AdtagLocationBeacon\'" "ios/swift" 
	exit 1;;
esac

updateAndroidBuild "com.connecthings.adtag:android-adtag-beacon"
updateIOSBuild "pod \"AdtagLocationBeacon\"" "ios/ObjectiveC" 
updateIOSBuild "pod \'AdtagLocationBeacon\'" "ios/ObjectiveC" 
updateIOSBuild "pod \"AdtagLocationBeacon\"" "ios/swift" 
updateIOSBuild "pod \'AdtagLocationBeacon\'" "ios/swift" 
