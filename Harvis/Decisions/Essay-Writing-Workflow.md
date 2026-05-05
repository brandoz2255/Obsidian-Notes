# Decision: Essay Writing Workflow

**Date:** 2026-05-05
**Status:** Active

## Context
Dulc3 needed academic essays with strict style constraints, verified citations, and professional formatting.

## Decision
Built a complete essay generation workflow using python-docx with:
- Programmatic paragraph generation (no markdown)
- APA 7th edition in-text citations
- Crossref API for source verification
- Clickable hyperlinks via OxmlElement injection
- Style validation (banned words, punctuation, formatting)
- Hyperlink injection for references

## Why This Approach
- Guarantees style compliance through validation
- Verified sources prevent hallucinated citations
- python-docx gives precise Word formatting control
- Reusable via saved skill

## Implementation
- Skill: `dulc3-essay-writing`
- Generation script: `/tmp/build_cloud_essay_full.py`
- Validation: regex-based banned word/punctuation checks
- Output: 6+ page DOCX with hanging indent references

## Lessons Learned
- Banned word list needs word boundaries (`\b`) to avoid false positives
- Compound terms like "just-in-time" trigger banned word filters
- python-docx hyperlinks require OxmlElement injection
- Crossref API is reliable for academic source verification
