# neoromantic/tap

[Homebrew](https://brew.sh) formulae for [neoromantic](https://github.com/neoromantic)'s command-line
tools. Every tool here ships prebuilt binaries from its own GitHub Releases, on macOS and Linux.

## Install

Install a formula by its full name. No other step is needed:

```sh
brew install neoromantic/tap/<formula>
```

Homebrew taps the repo on first use and trusts that one formula because you named it in full.
Use the full name with `brew upgrade` too: `brew upgrade neoromantic/tap/<formula>`.

### Short names

To use short names such as `brew install ai-usage`, tap the repo and trust it once. Since
Homebrew 6, formulae from an untrusted third-party tap are refused by short name:

```sh
brew tap neoromantic/tap
brew trust --tap neoromantic/tap
brew install <formula>
```

In a Brewfile:

```ruby
tap "neoromantic/tap", trusted: true
brew "neoromantic/tap/<formula>"
```

## Formulae

| Formula | What it is | Install |
|---|---|---|
| [`ai-usage`](https://github.com/neoromantic/ai-usage) | Quota left and token use for Claude Code, Codex, and Grok, per machine and team | `brew install neoromantic/tap/ai-usage` |

What to do after the install is in each tool's README.

## How formulae get here

Each tool's release workflow writes its formula in `Formula/<formula>.rb` after the GitHub
Release is published. Don't edit a formula by hand here: the next release overwrites it. Fix the
template in the tool's repo instead.

CI runs on every push and pull request: `brew style` on the tap, then `brew audit --strict
--online`, `brew install` and `brew test` on macOS and Linux for each formula that changed.

## License

[MIT](LICENSE)
