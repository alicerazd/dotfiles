---
title: "bootstrap-nightly drift detected"
labels: ci-drift
---

The nightly cold-install bootstrap matrix failed.

Common causes:
- Upstream oh-my-zsh / Powerlevel10k / asdf plugin archive format changed.
- A Homebrew formula in `dot_Brewfile` was renamed or removed.
- A chezmoi template now references a variable the runner doesn't supply.
- Wasabi / Datadog / 1Password action versions shifted.

Run logs: see the failing workflow run linked from this issue's workflow
activity.

Triage checklist:
- [ ] Reproduce locally with `act` or a fresh VM.
- [ ] Identify which `setup_*` function in `executable_dotfiles.sh` regressed.
- [ ] Patch + PR. CI on the PR (`bootstrap.yml`) should pass.
- [ ] After merge, re-dispatch `bootstrap-nightly.yml` to confirm green.
