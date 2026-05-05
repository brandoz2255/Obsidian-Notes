# Playbook: Essay Generation

## When to Use
- Academic essays, reports, technical documents
- Any writing with style constraints and citation requirements

## Steps

1. **Load the skill**
   ```
   skill_view(name='dulc3-essay-writing')
   ```

2. **Verify sources**
   - Query Crossref API for academic citations
   - Confirm DOIs resolve
   - Reject hallucinated sources

3. **Generate content**
   - Use python-docx script
   - Inject hyperlinks via OxmlElement
   - Apply APA 7th formatting

4. **Validate**
   - Check banned words (regex with `\b`)
   - Check prohibited punctuation (`, ;`)
   - Verify you/your addressing
   - Confirm page length

5. **Deliver**
   - Send DOCX via MEDIA:
   - Include style check summary

## Key Constraints
- No banned words (60+ list)
- No em dashes, semicolons, lists
- Short sentences, active voice
- Spartan, informative style
- APA 7th citations with hyperlinks
- Minimum 6 pages

## Template
See `dulc3-essay-writing` skill for full generation script.
