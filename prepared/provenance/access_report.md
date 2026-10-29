# Source acquisition status

Checked 2026-10-28. All user-supplied archives were copied unchanged into `curator/originals` and SHA-256 hashed in `original_files.csv`.

## MapTask / GMMT

Repository: https://github.com/chnln/grounded-misunderstandings-in-maptask

Acquired:

- GMMT repository at archive revision `de31ce29b0387e2fa6ab9f96ebaeb6d0f91b1cbc`.
- HCRC v2.1 XML/annotation archive, containing 128 giver and 128 follower timed-unit XML files.
- HCRC plain-text archive, containing 128 dialogue transcripts.
- HCRC task-map archive, containing 16 giver/follower GIF pairs.

The original bytes remain in `curator/originals`; extracted source files remain under `curator/extracted`. The PNG files in `initial_view/examples/context` are derived copies of the corresponding original `map9g.gif` and `map9f.gif` for observer use. Completed follower maps were not acquired or exposed.

The current HCRC download page states CC BY 4.0. The downloaded v2.1 archive itself contains `00LICENSE.html`, which says Attribution–NonCommercial–ShareAlike 2.5. This package records both statements without resolving their legal relationship. Preserve attribution and consult the source owner if the applicable license matters to redistribution.

## Werewolf Among Us

Repository: https://github.com/SALT-NLP/PersuationGames

Acquired: the code repository at archive revision `f0ba30b39ba485ae25856865572687babc5863b6`.

Still missing: the actual Hugging Face `Werewolf-Among-Us` transcripts, split/annotation JSON, outcome/role files, timestamps, and URL inventory. The repository ZIP contains code and current links, not the dataset records needed to prepare Werewolf episodes.

The current repository points to https://huggingface.co/datasets/bolinlai/Werewolf-Among-Us and https://bolinlai.github.io/projects/Werewolf-Among-Us/. Relevant folders are `Youtube/transcripts`, `Youtube/split`, `Youtube/vote_outcome_youtube_released`, `Ego4D/transcripts`, `Ego4D/split`, `Ego4D/vote_outcome_ego4d`, and `Ego4D/game_timestamp`. Split and outcome files must remain curator-only because they contain labels, roles, votes, and later outcomes.

## Remaining access blocker

Command-line HTTPS still points to proxy `127.0.0.1:9`, so direct Hugging Face downloads fail with curl exit code 7. The supplied local archives resolved the MapTask blocker. To prepare Werewolf examples, provide the relevant Hugging Face folders as an archive or restore HTTPS access.
