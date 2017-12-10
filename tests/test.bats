#!/usr/bin/env bats

teardown() {
	git config --global --unset user.name
	git config --global --unset user.email
	if [ -e ~/.gitpairables ]; then rm ~/.gitpairables; fi
}

@test "exits 1 when run without arguments" {
	run git pair

	[ "$status" -eq 1 ]
}

@test "prints help when run without arguments" {
	run git pair

	[ "${lines[0]}" = "Usage:" ]
}

@test "'help' prints something helpful" {
	run git pair help

	[ "${lines[0]}" = "Usage:" ]
}

@test "'add' creates ~/.gitpairables with one entry" {
	run expect /tests/expect_add_test.exp

	[ "$(cat ~/.gitpairables | wc -l)" = "1" ]
}

@test "'add' stores the original name and email if run the first time" {
	run git config --global user.name 'Original Name'
	run git config --global user.email 'original@email.com'
	run expect /tests/expect_add_test.exp

	[ "$(cat ~/.gitpairables | grep -o __original__)" = "__original__" ]
}

@test "'add' does not re-add if the nickname already exists" {
	run expect /tests/expect_add_test.exp
	run expect /tests/expect_add_test_different_case.exp

	[ "$(cat ~/.gitpairables | grep test | wc -l | tr -d ' ')" -eq 1 ]
}

@test "'list' prints details of pairs" {
	run expect /tests/expect_add_test.exp
	run git pair list

	[ "$(echo ${lines[2]} | grep -o 'test@tester.com')" = "test@tester.com" ]
}

@test "'set' changes global config to provided pairs" {
	run expect /tests/expect_add_one.exp
	run expect /tests/expect_add_two.exp
	run git pair set one two

	[ "$(git config --global --get user.name)" = 'One and Two' ]
	[ "$(git config --global --get user.email)" = 'one+two@one.com' ]
}

@test "'set' ignores the case of pair nicknames" {
	run expect /tests/expect_add_one.exp
	run expect /tests/expect_add_two.exp
	run git pair set OnE tWo

	[ "$(git config --global --get user.name)" = 'One and Two' ]
	[ "$(git config --global --get user.email)" = 'one+two@one.com' ]
}

@test "'set' does nothing if the provided nicknames don't exist" {
	run git config --global user.name original
	run git config --global user.email original@local
	run git pair set blah bleh

	[ "$(git config --global --get user.name)" = "original" ]
	[ "$(git config --global --get user.email)" = "original@local" ]
}

@test "'reset' sets name and email back to the original settings" {
	run git config --global user.name 'Original Name'
	run git config --global user.email 'original@email.com'
	run expect /tests/expect_add_one.exp
	run git pair set one
	run git pair reset

	[ "$(git config --get --global user.name)" = 'Original Name' ]
	[ "$(git config --get --global user.email)" = 'original@email.com' ]
}

@test "'reset' exits 1 if there is no original name set" {
	run git config --global --unset user.name
	run git config --global --unset user.email
	run expect /tests/expect_add_one.exp
	run git pair reset

	[ "$status" -eq 1 ]
}
