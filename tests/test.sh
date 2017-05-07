#!/usr/bin/env bash

set -e
set -o pipefail

t() {
	echo -e "test: \033[1;32m$1\033[0m"
}

t "exits 1 when run without arguments"
! git pair

t "'add' creates ~/.gitpairables with one entry"
expect /tests/expect_add_test.exp >/dev/null
[ -e ~/.gitpairables ]
cat ~/.gitpairables | wc -l >/dev/null 2>&1

t "'list' prints details of pairs"
expect /tests/expect_add_test.exp >/dev/null
git pair list | grep test >/dev/null

t "'set' changes global config to provided pairs"
expect /tests/expect_add_one.exp >/dev/null
expect /tests/expect_add_two.exp >/dev/null
git pair set one two >/dev/null
[ "$(git config --global --get user.name)" = 'One and Two' ]
[ "$(git config --global --get user.email)" = 'one+two@one.com' ]
