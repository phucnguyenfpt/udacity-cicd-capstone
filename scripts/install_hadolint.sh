#!/usr/bin/env bash

OS=$(uname)
VERSION="v1.22.1"
HADOLINT_FILE=https://github.com/hadolint/hadolint/releases/download/${VERSION}/hadolint-${OS}-x86_64

test -e ./scripts/hadolint ||
  {
    wget -qO ./scripts/hadolint "${HADOLINT_FILE}"
    chmod +x ./scripts/hadolint
  }

echo "./scripts/hadolint: $(./scripts/hadolint --version)"
