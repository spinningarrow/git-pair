#!/usr/bin/env bash

set -e
set -o pipefail

t() {
	[ -e ~/.gitpairables ] && rm ~/.gitpairables
	echo -e "test: \033[1;32m$1\033[0m"
}

t "exits 1 when run without arguments"
(! git pair >/dev/null)

t "prints help when run without arguments"
output=$(! git pair)
echo $output | grep Usage >/dev/null

t "'help' prints something helpful"
git pair help | grep Usage >/dev/null

t "'add' creates ~/.gitpairables with one entry"
expect /tests/expect_add_test.exp >/dev/null
[ -e ~/.gitpairables ]
cat ~/.gitpairables | wc -l >/dev/null 2>&1

t "'add' stores the original name and email if run the first time"
git config --global user.name 'Original Name'
git config --global user.email 'original@email.com'
expect /tests/expect_add_test.exp >/dev/null
cat ~/.gitpairables | grep __original__ >/dev/null

t "'add' does not re-add if the nickname already exists"
expect /tests/expect_add_test.exp >/dev/null
expect /tests/expect_add_test_different_case.exp >/dev/null
[ $(git pair list | grep test | wc -l | tr -d ' ') = 1 ]

t "'list' prints details of pairs"
expect /tests/expect_add_test.exp >/dev/null
git pair list | grep test >/dev/null

t "'set' changes global config to provided pairs"
expect /tests/expect_add_one.exp >/dev/null
expect /tests/expect_add_two.exp >/dev/null
git pair set one two >/dev/null
[ "$(git config --global --get user.name)" = 'One and Two' ]
[ "$(git config --global --get user.email)" = 'one+two@one.com' ]

t "'set' ignores the case of pair nicknames"
expect /tests/expect_add_one.exp >/dev/null
expect /tests/expect_add_two.exp >/dev/null
git pair set OnE tWo >/dev/null
[ "$(git config --global --get user.name)" = 'One and Two' ]
[ "$(git config --global --get user.email)" = 'one+two@one.com' ]

t "'set' does nothing if the provided nicknames don't exist"
original_name=$(git config --global --get user.name)
original_email=$(git config --global --get user.email)
! git pair set blah bleh &>/dev/null
[ "$original_name" = "$(git config --global --get user.name)" ]
[ "$original_email" = "$(git config --global --get user.email)" ]

t "'reset' sets name and email back to the original settings"
git config --global user.name 'Original Name'
git config --global user.email 'original@email.com'
expect /tests/expect_add_one.exp >/dev/null
git pair set one >/dev/null
git pair reset >/dev/null
[ "$(git config --get --global user.name)" = 'Original Name' ]
[ "$(git config --get --global user.email)" = 'original@email.com' ]

t "'reset' exits 1 if there is no original name set"
git config --global --unset user.name
git config --global --unset user.email
expect /tests/expect_add_one.exp >/dev/null
git pair set one >/dev/null
(! git pair reset)
