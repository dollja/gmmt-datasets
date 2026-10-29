# Three completed examples

These examples use the original HCRC `q1ec2` transcript, giver/follower maps, GMMT annotations, and the first-relevant-response cutoff rule. The examples are not automatically part of the final 20.

| Example | Focus | Cutoff | Prefix | Case type | Curator record | Observer-only input |
|---|---|---|---:|---|---|---|
| `EXAMPLE_q1ec2_slow_down` | “the site of a plane crash” | first response requests slower speech | 5 rows / 55 words | `unresolved` | [full JSON](EXAMPLE_q1ec2_slow_down.json) | [observer JSON](../../initial_view/examples/EXAMPLE_q1ec2_slow_down.observer_input.json) |
| `EXAMPLE_q1ec2_turn_right` | “and then turn right” | giver responds “mmhmm” | 10 rows / 72 words | `potential_consequential_mismatch` | [full JSON](EXAMPLE_q1ec2_turn_right.json) | [observer JSON](../../initial_view/examples/EXAMPLE_q1ec2_turn_right.observer_input.json) |
| `EXAMPLE_q1ec2_below_springs` | “and down below the springs” | follower repeats the below-springs instruction | 72 rows / 362 words | `aligned_or_harmless` | [full JSON](EXAMPLE_q1ec2_below_springs.json) | [observer JSON](../../initial_view/examples/EXAMPLE_q1ec2_below_springs.observer_input.json) |

Each full JSON fills every required top-level section. `observer_input` contains only the fixed task description, participants, permitted maps, and dialogue prefix. Manual annotations, released labels, and complete post-cutoff dialogue remain in the curator record.

The HCRC text files have speaker roles and ordered transcript rows but no row IDs. The generated IDs `q1ec2.row.NNN` map back to physical source lines in [q1ec2_row_crosswalk.csv](q1ec2_row_crosswalk.csv). The original XML remains authoritative for timings and corpus utterance numbers.

The first two examples overlap within the same opening exchange. They illustrate different focal decisions but should not both be counted as independent episodes in the final dataset. The third is later in the same conversation. Final sampling should use multiple conversations.

Open a full curator JSON to see how to fill the requested schema. Open its observer-only companion to see exactly what may be supplied to the evaluated system.
