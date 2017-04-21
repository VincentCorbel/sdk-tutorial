#!/bin/bash

export LC_CTYPE=C
export LANG=C

read -ep "User name? " user 
read -ep "Password? " pass 
read -ep "Company key? " company
read -ep "UrlType (LOCAL, DEMO, DEV, ITG, PRE_PROD, PROD, PROD_US)? " urltype 
echo ""

function updateURLType() { 
	grep -rlE "initUrlType(.*)" android | xargs sed -i '' "s/\(.initUrlType(\).[^)]*\(.*\)/\1Url.UrlType.$1\2/g"

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

	grep -rlE "configureUrlType:.*" ios/ObjectiveC | xargs sed -i '' "s/\(configureUrlType:\).[^ ]*\(.*\)/\1$URLTYPE\2/g"

	grep -rlE "configureUrlType\(.*" ios/SWIFT | xargs sed -i '' "s/\(configureUrlType(\).[^,]*\(.*\)/\1$URLTYPE\2/g"
}

function updateUser() { 
	grep -rlE "initUser(.*)"  android | xargs sed -i '' "s/\(.initUser(\).[^)]*\(.*\)/\1\"$1\", \"$2\"\2/g"

	grep -rlE "andLogin:.*" ios/ObjectiveC | xargs sed -i '' "s/\(andLogin:\).[^ ]*\(.*\)/\1@\"$1\"\2/g"
	grep -rlE "andPassword:.*" ios/ObjectiveC | xargs sed -i '' "s/\(andPassword:\).[^ ]*\(.*\)/\1@\"$2\"\2/g"

	grep -rlE "andLogin:.*" ios/SWIFT | xargs sed -i '' "s/\(andLogin:\).[^,]*\(.*\)/\1 \"$1\"\2/g"
	grep -rlE "andPassword:.*" ios/SWIFT | xargs sed -i '' "s/\(andPassword:\).[^,]*\(.*\)/\1 \"$2\"\2/g"
}

function updateCompany() { 
	grep -rlE "initCompany(.*)" android | xargs sed -i '' "s/\(.initCompany(\).[^)]*\(.*\)/\1\"$1\"\2/g"

	grep -rlE "andCompany:.*" ios/ObjectiveC | xargs sed -i '' "s/\(andCompany:\).[^]]*\(.*\)/\1@\"$1\"\2/g"

	grep -rlE "andCompany:.*" ios/SWIFT | xargs sed -i '' "s/\(andCompany:\).[^)]*\(.*\)/\1 \"$1\"\2/g"
}

updateURLType $urltype
updateUser $user $pass
updateCompany $company

