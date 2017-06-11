# git-pair [![Build Status][travis-image]][travis-link]

Bash-only git pairing script. No external dependencies on Ruby, Python, Node,
or any other runtime.

## Install

On macOS with [homebrew][]:

    brew tap spinningarrow/tap
    brew install git-pair

On other OSes and package managers, copy the `git-pair` script somewhere on
your `$PATH`.

## Use

- See usage information:

        git pair help

- Add a new person:

        git pair add

  and follow the prompts.

- List existing people:

        git pair list

- Set pairs:

        git pair set <nickname-1> [<nickname-2> <nickname-3> ... <nickname-n>]

  The nicknames are specified when adding a new person.

  By default, the script sets the configs globally. To set locally instead,
  pass the `--local` flag to `set`, e.g.

        git pair set --local person1 person2

- Reset name and email to what it was before `git pair` was first used:

        git pair reset

  NOTE: This will only work if both `name` and `email` were set before `git
  pair` was used.

- Show who is currently pairing:

        git pair show

Happy pairing!

[travis-image]: https://travis-ci.org/spinningarrow/git-pair.sh.svg?branch=master
[travis-link]: https://travis-ci.org/spinningarrow/git-pair.sh
[homebrew]: https://brew.sh/
