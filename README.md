# git-pair [![Build Status][travis-image]][travis-link]

Bash-only git pairing script. No external dependencies on Ruby, Python, Node,
or any other runtime.

**Archived**: This repository is no longer maintained since my git pairing
needs are now met by [git-coauthors][], which is stateless and more flexible
in comparison.

## Install

On macOS with [homebrew][]:

    brew install spinningarrow/tap/git-pair

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

## Alternatives

- [therubymug/hitch][]
- [pivotal/git_scripts][]
- [git-duet][]
- [square/pair][]

[travis-image]: https://travis-ci.org/spinningarrow/git-pair.svg?branch=master
[travis-link]: https://travis-ci.org/spinningarrow/git-pair
[homebrew]: https://brew.sh/
[therubymug/hitch]: https://github.com/therubymug/hitch
[pivotal/git_scripts]: https://github.com/pivotal/git_scripts
[git-duet]: https://github.com/git-duet/git-duet
[square/pair]: https://github.com/square/pair

Happy pairing!

[git-coauthors]: https://github.com/spinningarrow/git-coauthors
