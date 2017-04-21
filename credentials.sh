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
}

function updateUser() { 
	grep -rlE "initUser(.*)"  android | xargs sed -i '' "s/\(.initUser(\).[^)]*\(.*\)/\1\"$1\", \"$2\"\2/g"
}

function updateCompany() { 
	grep -rlE "initCompany(.*)" android | xargs sed -i '' "s/\(.initCompany(\).[^)]*\(.*\)/\1\"$1\"\2/g"
}

# [[[ATAdtagInitializer sharedInstance] configureUrlType:__PLATFORM__ andLogin:@"__USER__" andPassword:@"__PSWD__" andCompany:@"__COMPANY__"] synchronize];
# ATAdtagInitializer.sharedInstance().configureUrlType(__UrlType__, andLogin: "__USER__", andPassword: "__PSWD__", andCompany: "__COMPANY__").synchronize();

updateURLType $urltype
updateUser $user $pass
updateCompany $company
