#!/usr/bin/env bash

PAIRS_CONFIG_PATH=.gitpairables

command=$1

if [ $command = 'list' ]; then
	cat $PAIRS_CONFIG_PATH
	exit $?
fi

if [ $command = 'add' ]; then
	read -p 'Nickname: ' nickname
	read -p 'Name: ' name
	read -p 'Email: ' email

	echo "$nickname,$name,$email" >> $PAIRS_CONFIG_PATH
	exit $?
fi

if [ $command = 'set' ]; then
	if [ $2 = '--local' ]; then
		num_args_to_drop=3
		is_local=true
	else
		num_args_to_drop=2
		is_local=false
	fi

	pair_nicks=(${@:$num_args_to_drop})

	names=()
	emails=()

	for nick in ${pair_nicks[*]}; do
		found_line=$(grep ^$nick, $PAIRS_CONFIG_PATH) || exit 1
		names+=("`echo $found_line | cut -d',' -f2`")
		emails+=("`echo $found_line | cut -d',' -f3`")
	done

	names_joined=`printf "%s\n" "${names[@]}" | paste -d+ -s - | sed 's/+/ and /g'`

	email_ids=`printf "%s\n" "${emails[@]}" | cut -d@ -f1 | paste -d+ -s -`
	email_host=`echo ${emails[0]} | cut -d@ -f2`

	if $is_local; then
		git config user.name "$names_joined"
		git config user.email "$email_ids@$email_host"
	else
		git config --unset user.name &> /dev/null
		git config --unset user.email &> /dev/null
		git config --global user.name "$names_joined"
		git config --global user.email "$email_ids@$email_host"
	fi

	git config --get user.name
	git config --get user.email
	exit $?
fi

exit 1
