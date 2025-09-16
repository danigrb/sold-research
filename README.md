# SOLD Research - Cloud Cost Optimization Documentation

A structured documentation system for cloud spending prediction, simulation, and optimization research.

## Purpose

This repository maintains a living, structured documentation space about cloud spending optimization, centered on how innovation can save businesses millions per year. The system persists, organizes, and synthesizes research inputs into a searchable knowledge base.

## Structure

```
├── docs/                    # Main documentation organized by date
│   ├── 2025-09/            # Monthly documentation folders
│   ├── 2025-10/
│   └── ...
├── sources/                 # Source materials and references
│   ├── whitepapers/        # Academic and industry whitepapers
│   ├── articles/           # Blog posts and articles
│   ├── datasets/           # Data sources and benchmarks
│   └── case-studies/       # Real-world implementation cases
├── metadata/               # Structured metadata and indexes
│   ├── entries/            # JSON metadata for each entry
│   └── indexes/            # Search indexes and cross-references
├── templates/              # Standard templates for documentation
├── scripts/                # Automation and utility scripts
└── config/                 # Configuration files
```

## Workflow

1. **Ingest** - Receive new inputs (sources, documents, notes)
2. **Summarize** - Create 150-300 word executive summaries
3. **Structure** - Generate JSON metadata with consistent tagging
4. **Persist** - Store in organized folder structure
5. **Review** - Deduplicate and cross-reference content

## Metadata Schema

Each entry includes structured metadata:

```json
{
  "id": "<uuid>",
  "title": "Short descriptive title",
  "date": "2025-09-16",
  "provider": "aws|gcp|azure|multi|n/a",
  "techniques": ["rightsizing", "spot"],
  "summary": "<150-300 word synthetic executive summary>",
  "sources": ["https://...", "Whitepaper name - 2024"],
  "tags": ["roi:high", "technique:spot"]
}
```

## Tags

- **Provider**: `provider:aws|gcp|azure|multi|n/a`
- **Technique**: `technique:spot|commitment|rightsizing|automation`
- **ROI**: `roi:low|medium|high`
- **Confidence**: `confidence:low|medium|high`
- **Date**: `date:YYYY-MM-DD`

## Getting Started

See `templates/` for standard formats and `scripts/` for automation tools.