# Initial dataset preparation

Open [the three completed examples](curator/examples/README.md) first. They show one example of each case type using the original `q1ec2` transcript and maps.

Use [the blank worksheet](templates/annotation_worksheet.md) with [the blank JSON](templates/blank_sample.json) to prepare additional episodes. Review [the observer-context policy](initial_view/observer_context_policy.md) before exporting any observer input, and use [the fixed task descriptions](initial_view/task_descriptions.md).

The source package now contains all 128 HCRC plain-text transcripts, all 256 per-side timed-unit XML files, and all 32 original giver/follower task maps. GMMT repository annotations and reconstruction metadata are preserved separately. Werewolf transcripts and annotations are still not acquired; the supplied PersuationGames repository contains code and current dataset links only.

`curator/` contains originals, released annotations, complete post-cutoff dialogue, manual analysis, and provenance. `initial_view/examples/` contains observer-only inputs and the relevant converted task maps. Only the `observer_input` object should be passed to the evaluated system.

The examples are instructional and do not select episodes for the final 20. The first two overlap and must not both be treated as independent samples. Episode selection and final research labels remain the researcher's responsibility.

Source archive filenames, sizes, hashes, and acquisition dates are in [original_files.csv](provenance/original_files.csv). Revision information and access/license notes are in `provenance/`.
