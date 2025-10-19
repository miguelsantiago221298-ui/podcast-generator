
#!/bin/bash
set -euo pipefail

echo "=============================="

git config --global user.name "${GITHUB_ACTOR:-github-action}"
git config --global user.email "${INPUT_EMAIL:-action@local}"
git config --global --add safe.directory /github/workspace

# Use the virtualenv python that was set in the image PATH
python /usr/bin/feed.py

git add -A && git commit -m "Update Feed" || true
git push --set-upstream origin main || true

echo "=============================="
