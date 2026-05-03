#!/bin/bash
# Harvis Tier 1 Auto-Scan
# Runs at session start to load relevant context

VAULT="/workspace/Obsidian-Notes"
TODAY=$(date +%Y-%m-%d)

echo "=== Harvis Auto-Scan ==="
echo ""

# 1. Today's daily note
echo "📅 Today's Daily Note:"
if [ -f "$VAULT/$TODAY.md" ]; then
    head -50 "$VAULT/$TODAY.md"
else
    echo "(no daily note for today)"
fi
echo ""

# 2. Last 5 modified notes
echo "📝 Last 5 Modified Notes:"
find "$VAULT" -name "*.md" -type f -not -path "*/.obsidian/*" -not -path "*/Harvis/*" | xargs ls -t 2>/dev/null | head -5 | while read file; do
    echo "--- $(basename $file) ---"
    head -10 "$file"
    echo ""
done

# 3. Harvis shared notes
echo "🤖 Harvis Shared Notes:"
if [ -d "$VAULT/Harvis" ]; then
    find "$VAULT/Harvis" -name "*.md" -type f | xargs cat 2>/dev/null
else
    echo "(no Harvis notes yet)"
fi
echo ""
echo "=== Auto-Scan Complete ==="
