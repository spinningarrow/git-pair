#!/usr/bin/env fish
set pairs_config_path ./.git-pairables.yaml

if [ $argv[1] = 'add' ]
	echo Nickname:
	read nickname
	echo Name:
	read name
	echo Email:
	read email

	echo "- nickname: $nickname" >> $pairs_config_path
	echo "  name: $name" >> $pairs_config_path
	echo "  email: $email" >> $pairs_config_path

	exit 0
end

if [ $argv[1] = 'set' ]
	grep "nickname: $argv[2]" $pairs_config_path > /dev/null; or exit 1
	grep "nickname: $argv[3]" $pairs_config_path > /dev/null; or exit 1

	set first (cat $pairs_config_path | grep -A2 "nickname: $argv[2]" | cut -d':' -f2 | sed s/^\ //)
	set second (cat $pairs_config_path | grep -A2 "nickname: $argv[3]" | cut -d':' -f2 | sed s/^\ //)

	git config user.name (echo $first[2] and $second[2])
	git config user.email (echo (echo $first[3] | cut -d'@' -f1)+$second[3])

	set_color -u bryellow; echo gitconfig updated; set_color normal
	echo Name: (git config --get user.name)
	echo Email: (git config --get user.email)
end

