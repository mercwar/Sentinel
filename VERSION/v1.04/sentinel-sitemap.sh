#!/bin/bash
# sentinel-sitemap.sh
# Generates an XML sitemap for the current GitHub repo with URLs pointing to files in the main branch

set -euo pipefail

# 1. Get the base GitHub URL from your git config
# Converts 'git@github.com:user/repo.git' or 'https://github.com/user/repo' 
# into 'https://github.com/user/repo/blob/main'
REPO_URL=$(git config --get remote.origin.url | sed -E 's/\.git$//' | sed -E 's#git@github.com:(.*)#https://github.com/\1#')
BRANCH="main"
BASE_URL="${REPO_URL}/blob/${BRANCH}"

OUTPUT_FILE="sitemap.xml"

echo "Generating sitemap for: ${BASE_URL}"

# 2. Start the XML structure
{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
} > "$OUTPUT_FILE"

# 3. Find all files excluding .git directory
find . -type f -not -path '*/.git/*' | while read -r file; do
    # Remove the leading './'
    CLEAN_PATH="${file#./}"

    # URL encode spaces (replace space with %20)
    ENCODED_PATH="${CLEAN_PATH// /%20}"

    # Write the URL entry
    {
      echo "  <url>"
      echo "    <loc>${BASE_URL}/${ENCODED_PATH}</loc>"
      echo "  </url>"
    } >> "$OUTPUT_FILE"
done

# 4. Close the XML tag
echo '</urlset>' >> "$OUTPUT_FILE"

echo "Done! Full sitemap saved to $OUTPUT_FILE"
