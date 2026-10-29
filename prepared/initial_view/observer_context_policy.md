# Proposed permitted observer context

Status: proposed policy for review. Three teaching-example inputs are populated under `examples/`; none is selected for the final 20.

Pass only the selected sample's `observer_input` object to the evaluated system. Keep source metadata, selection metadata, all manual annotations, source labels, and later evidence outside that payload. The preparation index is for the curator only.

Use one fixed task description per verified setting. Include stable participant/speaker IDs. MapTask giver/follower roles are task-public. Werewolf `known_role` stays null unless the protocol independently makes a role public; a spoken claim remains a claim in transcript text, not verified role metadata.

MapTask baseline proposal: permit the original giver and follower task maps, each identified with its actual participant access list; make clear the observer sees both while each participant sees only their own. This gives the observer privileged visual task context and must be reported as such. Use the original giver route, but exclude completed follower routes, path-deviation scores, landmark-discrepancy tables and annotation-based landmark interpretations. If a participant-limited observer protocol is preferred, run it as a separately named condition; never silently change map access among samples.

Werewolf baseline proposal: public rules and independently verified public setup only. Exclude true starting/ending roles, private night actions, role swaps recorded as ground truth, votes/outcomes not yet public, card reveals, and source screenshots exposing these. Preserve spontaneous identity claims in prefix text verbatim. Do not turn a claim into privileged context. Do not use game-specific setup inferred from hidden-role annotations.

The curator identifies the focus and first relevant response; initial cutoff is immediately after that response, consistently across case types. Observer sees the complete prefix from conversation start, without a special focus marker, annotation emphasis, current-subtask description or explicit decision prompt. Native transcript punctuation is retained. If no response exists, record that limitation; never fabricate a response or choose a convenient later cutoff.

Keep the complete original conversation in curator storage. Later text, actions, outcomes and corrections belong only in `later_evidence`; do not use them to justify a prefix interpretation. If the cutoff response explicitly detects the misunderstanding, record explicit detection in manual annotations. An acknowledgment alone does not prove an interpretation.

Record prefix utterance and word counts without truncation. Define word count as whitespace-separated tokens over prefix text, record the convention, and flag model capacity limits. Mark the shorter focal span only in selection metadata. Missing source utterance IDs require explicitly marked generated IDs plus a source line/timestamp crosswalk; never call generated IDs original. Retain overlap/timing order and speaker identity without silently merging distinct speakers. Validate each prefix against the complete transcript and its cutoff before export.

Before release, verify an allowlist of the four observer fields (`overall_task`, `participants`, `context_sources`, `dialogue_prefix`); inspect context files too. No released labels, RE tags, focus spans, hidden-state metadata or later turns may appear in context. This is a procedural requirement, not a completed audit of absent transcripts.
