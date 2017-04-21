#!/bin/bash

read -ep "User name? " user 
read -ep "Password? " pass 
read -ep "Company key? " company
echo ""

function findAndReplace() {
	grep -rl $1 "android" | xargs sed -i '' "s/$1/$2/g"
	grep -rl $1 "ios" | xargs sed -i '' "s/$1/$2/g"
}

findAndReplace "__LOGIN__" $user
findAndReplace "__PSWD__" $pass
findAndReplace "__COMPANY__" $company
