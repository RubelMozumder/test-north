#!/bin/bash

# Find tagged version or construct dynamic version from latest tag, number of commits since tag and git hash
set -euo pipefail

git_semver() {
  # Tagged version
  if git describe --tags --exact-match >/dev/null 2>&1; then
    git describe --tags --exact-match | sed 's/^v//'
    return
  fi
  # Declare local variable for tag, commits, and hash
  local tag commits hash

  tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "0.0.0")
  commits=$(git rev-list "${tag}"..HEAD --count 2>/dev/null || echo "0")
  hash=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")

  # Strip leading "v" if present
  tag=${tag#v}

  echo "${tag}+${commits}.g${hash}"
}

git_semver || echo "0.0.0+0.gunknown"