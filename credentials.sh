#!/bin/bash

export LC_CTYPE=C
export LANG=C

echo -e "\t\t..:::: Update Credentials ::::.."
read -ep "User name? " user 
read -ep "Password? " pass 
read -ep "Company key? " company
read -ep "UrlType (LOCAL, DEMO, DEV, ITG, PRE_PROD, PROD, PROD_US)? " urltype 
read -ep "OS (all [default], android [a], objectivec [o] and swift [s])? " os 
echo ""

function updateURLType() { 
	URLTYPE=$(buildURLType $1)

	case "$2" in
		"android" | "a" )
		grep -r --include \*.java -lE "initUrlType(.*)" android | xargs sed -i '' "s/\(.initUrlType(\).[^)]*\(.*\)/\1Url.UrlType.$1\2/g"
		return 1;;

		"objectivec" | "o" )
		grep -rlE "configureUrlType:.*" ios/ObjectiveC | xargs sed -i '' "s/\(configureUrlType:\).[^ ]*\(.*\)/\1$URLTYPE\2/g"
		return 1;;

		"swift" | "s" )
		grep -rlE "configureUrlType\(.*" ios/SWIFT | xargs sed -i '' "s/\(configureUrlType(\).[^,]*\(.*\)/\1$URLTYPE\2/g"
		return 1;;
	esac

	grep -r --include \*.java -lE "initUrlType(.*)" android | xargs sed -i '' "s/\(.initUrlType(\).[^)]*\(.*\)/\1Url.UrlType.$1\2/g"
	grep -rlE "configureUrlType:.*" ios/ObjectiveC | xargs sed -i '' "s/\(configureUrlType:\).[^ ]*\(.*\)/\1$URLTYPE\2/g"
	grep -rlE "configureUrlType\(.*" ios/SWIFT | xargs sed -i '' "s/\(configureUrlType(\).[^,]*\(.*\)/\1$URLTYPE\2/g"
}

function buildURLType() {
	case "$1" in
        LOCAL)
			URLTYPE="ATUrlTypeLocal"
            ;;
        DEMO)
			URLTYPE="ATUrlTypeDemo"
            ;;
        DEV)
			URLTYPE="ATUrlTypeDev"
            ;;
        ITG)
			URLTYPE="ATUrlTypeItg"
            ;;
        PRE_PROD)
			URLTYPE="ATUrlTypePreprod"
            ;;
        PROD)
			URLTYPE="ATUrlTypeProd"
            ;;
        PROD_US)
			URLTYPE="ATUrlTypeProdUs"
            ;;
        *)
			URLTYPE="ATUrlTypeDev"
            ;;
	esac
	echo $URLTYPE
}

function updateUser() { 
	case "$3" in
		"android" | "a" )
		grep -r --include \*.java -lE "initUser(.*)"  android | xargs sed -i '' "s/\(.initUser(\).[^)]*\(.*\)/\1\"$1\", \"$2\"\2/g"
		return 1;;

		"objectivec" | "o" )
		grep -rlE "andLogin:.*" ios/ObjectiveC | xargs sed -i '' "s/\(andLogin:\).[^ ]*\(.*\)/\1@\"$1\"\2/g"
		grep -rlE "andPassword:.*" ios/ObjectiveC | xargs sed -i '' "s/\(andPassword:\).[^ ]*\(.*\)/\1@\"$2\"\2/g"
		return 1;;

		"swift" | "s" )
		grep -rlE "andLogin:.*" ios/SWIFT | xargs sed -i '' "s/\(andLogin:\).[^,]*\(.*\)/\1 \"$1\"\2/g"
		grep -rlE "andPassword:.*" ios/SWIFT | xargs sed -i '' "s/\(andPassword:\).[^,]*\(.*\)/\1 \"$2\"\2/g"
		return 1;;
	esac

	grep -r --include \*.java -lE "initUser(.*)"  android | xargs sed -i '' "s/\(.initUser(\).[^)]*\(.*\)/\1\"$1\", \"$2\"\2/g"

	grep -rlE "andLogin:.*" ios/ObjectiveC | xargs sed -i '' "s/\(andLogin:\).[^ ]*\(.*\)/\1@\"$1\"\2/g"
	grep -rlE "andPassword:.*" ios/ObjectiveC | xargs sed -i '' "s/\(andPassword:\).[^ ]*\(.*\)/\1@\"$2\"\2/g"

	grep -rlE "andLogin:.*" ios/SWIFT | xargs sed -i '' "s/\(andLogin:\).[^,]*\(.*\)/\1 \"$1\"\2/g"
	grep -rlE "andPassword:.*" ios/SWIFT | xargs sed -i '' "s/\(andPassword:\).[^,]*\(.*\)/\1 \"$2\"\2/g"
}

function updateCompany() { 
	case "$2" in
		"android" | "a" )
		grep -r --include \*.java -lE "initCompany(.*)" android | xargs sed -i '' "s/\(.initCompany(\).[^)]*\(.*\)/\1\"$1\"\2/g"
		return 1;;

		"objectivec" | "o" )
		grep -rlE "andCompany:.*" ios/ObjectiveC | xargs sed -i '' "s/\(andCompany:\).[^]]*\(.*\)/\1@\"$1\"\2/g"
		return 1;;

		"swift" | "s" )
		grep -rlE "andCompany:.*" ios/SWIFT | xargs sed -i '' "s/\(andCompany:\).[^)]*\(.*\)/\1 \"$1\"\2/g"
		return 1;;
	esac

	grep -r --include \*.java -lE "initCompany(.*)" android | xargs sed -i '' "s/\(.initCompany(\).[^)]*\(.*\)/\1\"$1\"\2/g"

	grep -rlE "andCompany:.*" ios/ObjectiveC | xargs sed -i '' "s/\(andCompany:\).[^]]*\(.*\)/\1@\"$1\"\2/g"

	grep -rlE "andCompany:.*" ios/SWIFT | xargs sed -i '' "s/\(andCompany:\).[^)]*\(.*\)/\1 \"$1\"\2/g"
}

updateURLType $urltype $os
updateUser $user $pass $os
updateCompany $company $os

