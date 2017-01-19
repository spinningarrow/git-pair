#!/usr/bin/env fish

# for i in (expr (count $argv) - 1)
# 	echo $argv[$i]
# end

if [ $argv = 'add' ]
	# vim pairs.yaml
	echo Nickname:
	read nickname
	echo Name:
	read name
	echo Email:
	read email

	echo "- nickname: $nickname" >> pairs.yaml
	echo "  name: $name" >> pairs.yaml
	echo "  email: $email" >> pairs.yaml

	exit 0
end

grep "nickname: $argv[1]" pairs.yaml > /dev/null; or exit 1
grep "nickname: $argv[2]" pairs.yaml > /dev/null; or exit 1

set first (cat pairs.yaml | grep -A2 "nickname: $argv[1]" | cut -d':' -f2 | sed s/^\ //)
set second (cat pairs.yaml | grep -A2 "nickname: $argv[2]" | cut -d':' -f2 | sed s/^\ //)

git config user.name (echo $first[2] and $second[2])
git config user.email (echo (echo $first[3] | cut -d'@' -f1)+$second[3])

set_color -u bryellow; echo gitconfig updated; set_color normal
echo Name: (git config --get user.name)
echo Email: (git config --get user.email)
