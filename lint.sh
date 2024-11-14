#!/bin/sh

git diff --name-only | grep "\.swift" | while read filename; do
  swiftlint --fix --config .swiftlint_autofix.yml --path "$filename"
done
