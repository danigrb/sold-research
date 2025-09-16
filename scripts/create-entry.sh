#!/bin/bash
# Shell script alternative for creating documentation entries

set -e

# Function to generate UUID (basic version)
generate_uuid() {
    cat /proc/sys/kernel/random/uuid 2>/dev/null || echo "$(date +%s)-$(shuf -i 1000-9999 -n 1)"
}

# Function to get current date
get_date() {
    date +%Y-%m-%d
}

# Function to get current month
get_month() {
    date +%Y-%m
}

# Parse command line arguments
TITLE=""
PROVIDER=""
TECHNIQUES=""
SUMMARY=""
SOURCES=""
TAGS=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --title)
            TITLE="$2"
            shift 2
            ;;
        --provider)
            PROVIDER="$2"
            shift 2
            ;;
        --techniques)
            TECHNIQUES="$2"
            shift 2
            ;;
        --summary)
            SUMMARY="$2"
            shift 2
            ;;
        --sources)
            SOURCES="$2"
            shift 2
            ;;
        --tags)
            TAGS="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 --title 'Title' --provider aws --techniques 'spot,rightsizing' --summary 'Summary text' --sources 'url1,url2' --tags 'roi:high,confidence:medium'"
            exit 0
            ;;
        *)
            echo "Unknown option $1"
            exit 1
            ;;
    esac
done

# Validate required arguments
if [[ -z "$TITLE" || -z "$PROVIDER" || -z "$TECHNIQUES" || -z "$SUMMARY" || -z "$SOURCES" || -z "$TAGS" ]]; then
    echo "Error: All arguments are required"
    echo "Usage: $0 --title 'Title' --provider aws --techniques 'spot,rightsizing' --summary 'Summary text' --sources 'url1,url2' --tags 'roi:high,confidence:medium'"
    exit 1
fi

# Generate entry details
ENTRY_ID=$(generate_uuid)
CURRENT_DATE=$(get_date)
CURRENT_MONTH=$(get_month)
TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# Create directories
mkdir -p "docs/$CURRENT_MONTH"
mkdir -p "metadata/entries"

# Create markdown file
MD_FILE="docs/$CURRENT_MONTH/$ENTRY_ID.md"
cat > "$MD_FILE" << EOF
# $TITLE

**Date**: $CURRENT_DATE  
**Provider**: $PROVIDER  
**Techniques**: [$TECHNIQUES]  
**Tags**: [$TAGS]

## Executive Summary

$SUMMARY

## Key Findings

- **Finding 1**: Description and impact
- **Finding 2**: Description and impact
- **Finding 3**: Description and impact

## Assumptions & Caveats

- Assumption 1
- Assumption 2
- Limitation 1

## Sources

$(echo "$SOURCES" | tr ',' '\n' | sed 's/^/- /')

## Related Entries

- [Related Entry 1](../path/to/entry.md)
- [Related Entry 2](../path/to/entry.md)

---

**Metadata**: See \`metadata/entries/$ENTRY_ID.json\`
EOF

# Create metadata file
METADATA_FILE="metadata/entries/$ENTRY_ID.json"
cat > "$METADATA_FILE" << EOF
{
  "id": "$ENTRY_ID",
  "title": "$TITLE",
  "date": "$CURRENT_DATE",
  "provider": "$PROVIDER",
  "techniques": [$(echo "$TECHNIQUES" | sed 's/,/", "/g' | sed 's/^/"/' | sed 's/$/"/')],
  "summary": "$SUMMARY",
  "sources": [$(echo "$SOURCES" | sed 's/,/", "/g' | sed 's/^/"/' | sed 's/$/"/')],
  "tags": [$(echo "$TAGS" | sed 's/,/", "/g' | sed 's/^/"/' | sed 's/$/"/')],
  "created_at": "$TIMESTAMP",
  "updated_at": "$TIMESTAMP"
}
EOF

echo "Created entry: $MD_FILE"
echo "Created metadata: $METADATA_FILE"
echo "Entry ID: $ENTRY_ID"