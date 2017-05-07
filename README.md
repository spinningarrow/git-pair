# git-pair.sh [![Build Status](https://travis-ci.org/spinningarrow/git-pair.sh.svg?branch=master)](https://travis-ci.org/spinningarrow/git-pair.sh)

Bash-only git pairing script. No external dependencies on Ruby, Python, Node, or anything else.

## Install

Copy the `git-pair` script somewhere on your `$PATH`.

## Usage

- Add a new person:

        git pair add
    
  and follow the prompts.

- List existing people:

        git pair list
    
- Set pairs:

        git pair set <nickname-1> [<nickname-2> <nickname-3> ... <nickname-n>]
    
  The nicknames are specified when adding a new person.

  By default, the script sets the configs globally. To set locally instead, pass the `--local` flag to `set`, e.g.

        git pair set --local person1 person2
        
Happy pairing!
