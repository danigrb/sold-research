#!/usr/bin/env python3
"""
Script to create a new documentation entry with proper structure and metadata.
"""

import json
import uuid
from datetime import datetime
from pathlib import Path
import argparse

def create_entry(title, provider, techniques, summary, sources, tags):
    """Create a new documentation entry with metadata."""
    
    # Generate unique ID
    entry_id = str(uuid.uuid4())
    current_date = datetime.now().strftime("%Y-%m-%d")
    current_month = datetime.now().strftime("%Y-%m")
    
    # Create metadata
    metadata = {
        "id": entry_id,
        "title": title,
        "date": current_date,
        "provider": provider,
        "techniques": techniques,
        "summary": summary,
        "sources": sources,
        "tags": tags,
        "created_at": datetime.now().isoformat() + "Z",
        "updated_at": datetime.now().isoformat() + "Z"
    }
    
    # Create file paths
    docs_dir = Path(f"docs/{current_month}")
    metadata_dir = Path("metadata/entries")
    
    # Ensure directories exist
    docs_dir.mkdir(parents=True, exist_ok=True)
    metadata_dir.mkdir(parents=True, exist_ok=True)
    
    # Create markdown file
    md_filename = f"{entry_id}.md"
    md_path = docs_dir / md_filename
    
    # Load template and populate
    template_path = Path("templates/entry-template.md")
    if template_path.exists():
        with open(template_path, 'r') as f:
            template = f.read()
        
        # Replace template placeholders
        content = template.replace("[Entry Title]", title)
        content = content.replace("YYYY-MM-DD", current_date)
        content = content.replace("aws|gcp|azure|multi|n/a", provider)
        content = content.replace("[technique1, technique2]", ", ".join(techniques))
        content = content.replace("[roi:level, confidence:level, technique:type]", ", ".join(tags))
        content = content.replace("[150-300 word synthetic summary highlighting:", summary)
        
        with open(md_path, 'w') as f:
            f.write(content)
    
    # Create metadata file
    metadata_path = metadata_dir / f"{entry_id}.json"
    with open(metadata_path, 'w') as f:
        json.dump(metadata, f, indent=2)
    
    print(f"Created entry: {md_path}")
    print(f"Created metadata: {metadata_path}")
    print(f"Entry ID: {entry_id}")
    
    return entry_id, md_path, metadata_path

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create a new documentation entry")
    parser.add_argument("--title", required=True, help="Entry title")
    parser.add_argument("--provider", required=True, choices=["aws", "gcp", "azure", "multi", "n/a"], help="Cloud provider")
    parser.add_argument("--techniques", nargs="+", required=True, help="Optimization techniques")
    parser.add_argument("--summary", required=True, help="Executive summary (150-300 words)")
    parser.add_argument("--sources", nargs="+", required=True, help="Source URLs or references")
    parser.add_argument("--tags", nargs="+", required=True, help="Tags (roi:level, confidence:level, etc.)")
    
    args = parser.parse_args()
    
    create_entry(
        title=args.title,
        provider=args.provider,
        techniques=args.techniques,
        summary=args.summary,
        sources=args.sources,
        tags=args.tags
    )