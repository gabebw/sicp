# SICP

Working my way through [SICP] again.

[SICP]: http://mitpress.mit.edu/sicp/

## Installing Scheme on OSX

You can use Homebrew to install `gambit-scheme` (which has paren-matching and
readline support), or `plt-racket`.

Invoke `gambit-scheme` with `scheme-r5rs`, or `plt-racket` with `racket`

## mit-scheme

Sometimes you actually need MIT scheme for the exercises because `gambit-scheme`
gives you a warning. In that case:

```bash
$ brew install cask
$ brew cask install xquartz
$ brew install homebrew/x11/mit-scheme
```

Invoke it with `scheme`.
