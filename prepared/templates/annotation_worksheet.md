Blank annotation worksheet

Use alongside `blank_sample.json`. All answers start blank; no sample or label has been selected.

See the [three completed source-backed examples](../curator/examples/README.md). Each has a full curator JSON and a separate observer-only JSON. Released labels stay in curator materials.


## Identity and source (`sample_id`, `dataset`, `task_setting_id`, `source`)

- Sample ID: ______
- Dataset and verified task setting: ______
- Repository URL, original dialogue/game ID and complete transcript relative path: ______
- Original annotation IDs consulted (or empty list): ______

## Episode and cutoff (`selection_metadata`)

- Focal episode first utterance ID: ______
- Focus utterance ID: ______
- First relevant response ID (null if absent): ______
- Observation cutoff ID and reason under the first-response rule: ______
- Prefix utterance count: ______; whitespace-token word count: ______
- Missing response or context-capacity limitation: ______

## Observer material only (`observer_input`)

- Fixed overall task description: ______
- Participants: original participant ID and permitted known role (or null), repeated as needed: ______
- Permitted context: unique source ID, content/path, and IDs of participants who can access it: ______
- Complete prefix from conversation start through cutoff: utterance ID, speaker ID, verbatim text for every utterance: ______

Do not include the focus, local subtask, labels or later evidence in this section.

## Evaluation only (`manual_annotation`)

- Plausible current subtasks and supporting utterance/context IDs (repeat as needed): ______
- Focus: exact quote, original utterance ID and why selected: ______
- Each relevant participant: ID, supported reading(s), evidence IDs, and what remains uncertain: ______
- For each consequence analysis: assumed subtask, reading, affected judgment/action, specific expected consequence or unknown, evidence IDs: ______
- Case type (leave blank until your analysis): ______
- Allowed values: `potential_consequential_mismatch`, `aligned_or_harmless`, `unresolved`.
- Did the cutoff already explicitly detect misunderstanding? yes/no/unknown: ______
- Prefix-only rationale for case type: ______
- Why this episode is representative: ______

Do not equate different landmark names with different locations, or disagreement/deception with misunderstanding. A short acknowledgment does not establish a particular reading. The approximate 4/3/3 per-dataset selection targets are guidance, not quotas.

## Later evidence only (`later_evidence`)

- Every subsequent utterance: ID, speaker, verbatim text: ______
- Observed action or outcome (null if unavailable): ______
- What later evidence establishes and its limits: ______

## Notes (`annotation_notes`)

- Existing labels consulted, or none: ______
- Manual additions: ______
- Limitations, generated-ID provenance, missing evidence, capacity flags: ______

Only export `observer_input`. Do not export this worksheet. Use null or empty lists for missing information and explain limitations. `null` booleans/counts in the blank JSON mean unfilled, not false/zero; replace with actual values when known.
