param(
  [string]$Workspace = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$utf8 = [Text.UTF8Encoding]::new($false)
$transcript = Join-Path $Workspace 'prepared/curator/extracted/hcrc/Transcripts/q1ec2.txt'
$outCurator = Join-Path $Workspace 'prepared/curator/examples'
$outObserver = Join-Path $Workspace 'prepared/initial_view/examples'
New-Item -ItemType Directory -Force $outCurator, $outObserver | Out-Null

$rows = @()
$n = 0
$physicalLine = 0
foreach ($line in [IO.File]::ReadAllLines($transcript)) {
  $physicalLine++
  if ($line -match '^([gf])\t([^\t]*)') {
    $n++
    $role = if ($Matches[1] -eq 'g') { 'giver' } else { 'follower' }
    $rows += [ordered]@{
      utterance_id = ('q1ec2.row.{0:D3}' -f $n)
      speaker = $role
      text = $Matches[2].Trim()
      source_line = $physicalLine
    }
  }
}

function PublicRows([int]$through) {
  @($rows[0..($through - 1)] | ForEach-Object {
    [ordered]@{ utterance_id = $_.utterance_id; speaker = $_.speaker; text = $_.text }
  })
}

function LaterRows([int]$after) {
  if ($after -ge $rows.Count) { return @() }
  @($rows[$after..($rows.Count - 1)] | ForEach-Object {
    [ordered]@{ utterance_id = $_.utterance_id; speaker = $_.speaker; text = $_.text }
  })
}

function WordCount($items) {
  $count = 0
  foreach ($item in $items) {
    if ($item.text) { $count += @($item.text -split '\s+' | Where-Object { $_ }).Count }
  }
  $count
}

$task = "One participant describes a route, and another attempts to reproduce it on their own map. Their maps may differ, and neither participant can see the other's map."
$participants = @(
  [ordered]@{ participant_id = 'giver'; known_role = 'giver' },
  [ordered]@{ participant_id = 'follower'; known_role = 'follower' }
)
$contexts = @(
  [ordered]@{ source_id = 'q1ec2.map9g'; content_or_path = 'context/map9g.png'; accessible_to_participants = @('giver') },
  [ordered]@{ source_id = 'q1ec2.map9f'; content_or_path = 'context/map9f.png'; accessible_to_participants = @('follower') }
)

function New-Sample($spec) {
  $prefix = @(PublicRows $spec.cutoff)
  $later = @(LaterRows $spec.cutoff)
  [ordered]@{
    sample_id = $spec.sample_id
    dataset = 'MapTask/GMMT'
    task_setting_id = 'maptask'
    source = [ordered]@{
      repository_url = 'https://github.com/chnln/grounded-misunderstandings-in-maptask'
      dialogue_id = 'q1ec2'
      source_file = 'prepared/curator/extracted/hcrc/Transcripts/q1ec2.txt'
      original_annotation_ids = @($spec.annotation_ids)
    }
    selection_metadata = [ordered]@{
      focal_episode_start_id = ('q1ec2.row.{0:D3}' -f $spec.start)
      focus_utterance_id = ('q1ec2.row.{0:D3}' -f $spec.focus)
      first_relevant_response_id = ('q1ec2.row.{0:D3}' -f $spec.cutoff)
      observation_cutoff_id = ('q1ec2.row.{0:D3}' -f $spec.cutoff)
      cutoff_reason = $spec.cutoff_reason
      prefix_utterance_count = $prefix.Count
      prefix_word_count = (WordCount $prefix)
    }
    observer_input = [ordered]@{
      overall_task = $task
      participants = $participants
      context_sources = $contexts
      dialogue_prefix = $prefix
    }
    manual_annotation = [ordered]@{
      subtask_hypotheses = @($spec.subtasks)
      focus = [ordered]@{
        quote = $spec.quote
        utterance_id = ('q1ec2.row.{0:D3}' -f $spec.focus)
        why_selected = $spec.why
      }
      participant_interpretations = @($spec.interpretations)
      consequence_analysis = @($spec.consequences)
      case_type = $spec.case_type
      explicit_misunderstanding_at_cutoff = $spec.explicit
      rationale = $spec.rationale
      selection_reason = $spec.selection_reason
    }
    later_evidence = [ordered]@{
      dialogue = $later
      observed_action_or_outcome = $spec.outcome
      what_it_supports = $spec.later_support
    }
    annotation_notes = [ordered]@{
      existing_labels_used = $spec.labels
      manual_additions = 'Generated transcript-row IDs, cutoff selection, prefix-only interpretation analysis, and consequence analysis. No text was added to or normalized within the verbatim transcript rows.'
      limitations = "The HCRC plain transcript supplies speaker roles and row text but no row IDs, so q1ec2.row.NNN IDs were generated in chronological file order. See row_crosswalk.csv for physical source lines. XML timing/utterance metadata is authoritative where needed. Word counts use whitespace-separated tokens. The two original task maps are privileged observer context under the proposed both-map condition. No completed follower map or path-deviation outcome was used. $($spec.limitations)"
    }
  }
}

$specs = @(
  [ordered]@{
    sample_id = 'EXAMPLE_q1ec2_slow_down'; start = 4; focus = 4; cutoff = 5
    annotation_ids = @('q1ec2.ref.0','q1ec2.g.ref.1')
    quote = 'the site of a plane crash'
    cutoff_reason = 'q1ec2.row.005 is the first follower response after the route instruction containing the focus. It requests slower delivery but does not restate the landmark.'
    why = 'The landmark anchors a route instruction, while the first response addresses delivery speed rather than revealing which plane-crash landmark the follower has in mind.'
    subtasks = @([ordered]@{ description = 'Follow the initial route from START, including navigating around the intended plane-crash site.'; evidence_ids = @('q1ec2.row.004','q1ec2.map9g','q1ec2.map9f') })
    interpretations = @(
      [ordered]@{ participant_id = 'giver'; supported_readings = @([ordered]@{ reading = 'The giver is directing the follower around the lower-left plane-crash site on the giver map as part of the initial route.'; evidence_ids = @('q1ec2.row.004','q1ec2.map9g') }); uncertainty = 'The prefix does not show how the giver interprets the follower request beyond its surface request to slow down.' },
      [ordered]@{ participant_id = 'follower'; supported_readings = @([ordered]@{ reading = 'The follower understood that instructions were being given but requested slower delivery.'; evidence_ids = @('q1ec2.row.005') }); uncertainty = 'The response does not establish which plane-crash site, if any, the follower linked to the expression.' }
    )
    consequences = @([ordered]@{ subtask_hypothesis = 'Follow the initial route from START.'; reading = 'The intended plane-crash landmark is not established for the follower at the cutoff.'; affected_judgment_or_action = 'Which landmark to approach and circle.'; expected_consequence = 'Unknown at cutoff; choosing the upper-right rather than lower-left plane-crash site would substantially change the route.'; evidence_ids = @('q1ec2.row.004','q1ec2.row.005','q1ec2.map9g','q1ec2.map9f') })
    case_type = 'unresolved'; explicit = $false
    rationale = 'The giver intention is supported by the instruction and route map, but the first response supplies no evidence of the follower landmark interpretation. A request to slow down is uptake of the instruction event, not evidence of a particular landmark grounding.'
    selection_reason = 'Shows why task engagement without semantic uptake should remain unresolved at the first-response cutoff.'
    outcome = $null
    later_support = 'Later dialogue records continued route repair and eventually makes the follower location relative to a plane-crash site clearer. It is stored separately and was not used to strengthen the cutoff judgment.'
    labels = 'Consulted after manual prefix analysis: human-verified q1ec2.ref.0 is pending/unaccommodated; the parallel LLM annotation is pending/unspecified. These labels were not included in observer_input.'
    limitations = 'The focus is a substring of row.004; observer_input contains no focus marker.'
  },
  [ordered]@{
    sample_id = 'EXAMPLE_q1ec2_turn_right'; start = 7; focus = 9; cutoff = 10
    annotation_ids = @()
    quote = 'and then turn right'
    cutoff_reason = 'q1ec2.row.010 is the giver first response to the follower proposed turn.'
    why = 'The follower says right after the giver initial instruction says left, and the giver response is only an ambiguous acknowledgment.'
    subtasks = @([ordered]@{ description = 'Confirm the first turns from START before continuing the route.'; evidence_ids = @('q1ec2.row.004','q1ec2.row.007','q1ec2.row.009') })
    interpretations = @(
      [ordered]@{ participant_id = 'giver'; supported_readings = @([ordered]@{ reading = 'The earlier instruction requires a left turn after going forward.'; evidence_ids = @('q1ec2.row.004') }); uncertainty = 'The later mmhmm may acknowledge the follower turn, signal listening, or inadvertently confirm it; the prefix does not disambiguate.' },
      [ordered]@{ participant_id = 'follower'; supported_readings = @([ordered]@{ reading = 'The follower proposes turning right after walking straight ahead from START.'; evidence_ids = @('q1ec2.row.007','q1ec2.row.009') }); uncertainty = 'The prefix does not show whether the follower has drawn or executed the turn.' }
    )
    consequences = @([ordered]@{ subtask_hypothesis = 'Confirm the first turns from START.'; reading = 'Giver instruction: left; follower restatement: right.'; affected_judgment_or_action = 'Direction of the follower route immediately after moving forward.'; expected_consequence = 'A left/right divergence can send the drawn route toward a different region of the map.'; evidence_ids = @('q1ec2.row.004','q1ec2.row.009','q1ec2.map9g','q1ec2.map9f') })
    case_type = 'potential_consequential_mismatch'; explicit = $false
    rationale = 'The prefix contains directly opposed direction words for the same early route sequence. The difference could alter the route, while the giver mmhmm does not explicitly identify or repair it.'
    selection_reason = 'Demonstrates a consequential directional mismatch with an ambiguous acknowledgment at cutoff.'
    outcome = $null
    later_support = 'Subsequent dialogue continues route coordination but does not retroactively make the cutoff acknowledgment unambiguous. Later material remains separate.'
    labels = 'None; this directional phrase is not used as a released landmark-reference label in the consulted files.'
    limitations = 'This episode overlaps the first teaching example and must not be counted as an independent final sample alongside it.'
  },
  [ordered]@{
    sample_id = 'EXAMPLE_q1ec2_below_springs'; start = 65; focus = 71; cutoff = 72
    annotation_ids = @('q1ec2.ref.23','q1ec2.ref.25','q1ec2.ref.26','q1ec2.ref.27','q1ec2.ref.28')
    quote = 'and down below the springs'
    cutoff_reason = 'q1ec2.row.072 is the first follower response and repeats the spatial instruction in paraphrased form.'
    why = 'The response provides positive evidence about both the landmark and the below relation.'
    subtasks = @([ordered]@{ description = 'Navigate at the height of the hot wells/hot springs, turn left after the giver self-correction, and move below the springs.'; evidence_ids = @('q1ec2.row.065','q1ec2.row.067','q1ec2.row.069','q1ec2.row.071','q1ec2.map9g','q1ec2.map9f') })
    interpretations = @(
      [ordered]@{ participant_id = 'giver'; supported_readings = @([ordered]@{ reading = 'Move into the area below the giver hot-wells landmark, expressed using the follower term springs.'; evidence_ids = @('q1ec2.row.065','q1ec2.row.067','q1ec2.row.071','q1ec2.map9g') }); uncertainty = 'Exact drawn path and distance below the landmark are not established by the words alone.' },
      [ordered]@{ participant_id = 'follower'; supported_readings = @([ordered]@{ reading = 'Move below the hot-springs landmark on the follower map.'; evidence_ids = @('q1ec2.row.072','q1ec2.map9f') }); uncertainty = 'The response does not specify exact distance or prove physical execution.' }
    )
    consequences = @([ordered]@{ subtask_hypothesis = 'Move below the corresponding hot-wells/hot-springs landmark.'; reading = 'Both participants use corresponding map labels for the same location and agree on the below relation.'; affected_judgment_or_action = 'Direction relative to the landmark.'; expected_consequence = 'Both supported readings prescribe movement below the corresponding landmark; no different immediate action is supported.'; evidence_ids = @('q1ec2.row.065','q1ec2.row.071','q1ec2.row.072','q1ec2.map9g','q1ec2.map9f') })
    case_type = 'aligned_or_harmless'; explicit = $false
    rationale = 'The preceding exchange establishes hot wells/hot springs as corresponding labels, and the follower repeats the below relation in the first response. Remaining distance uncertainty does not create a supported alternative immediate direction.'
    selection_reason = 'Shows alignment across a documented lexical variant and a spatial relation, without treating different landmark names as misunderstanding.'
    outcome = $null
    later_support = 'The giver immediately confirms with uh-huh and the conversation continues. This confirmation occurs after the cutoff and is not needed for the prefix-only classification.'
    labels = 'Consulted after manual analysis: GMMT lexical-variant metadata pairs m9 hot_wells/hot_springs; released human annotations for refs 23, 25, 26, 27 and 28 report grounded corresponding interpretations. Not included in observer_input.'
    limitations = 'The classification concerns the local below-springs action, not global route accuracy.'
  }
)

foreach ($spec in $specs) {
  $sample = New-Sample $spec
  $samplePath = Join-Path $outCurator ($spec.sample_id + '.json')
  [IO.File]::WriteAllText($samplePath, ($sample | ConvertTo-Json -Depth 20), $utf8)
  $observerPath = Join-Path $outObserver ($spec.sample_id + '.observer_input.json')
  [IO.File]::WriteAllText($observerPath, ($sample.observer_input | ConvertTo-Json -Depth 15), $utf8)
}

$crosswalk = @('generated_id,speaker,source_physical_line,text')
foreach ($r in $rows) {
  $escaped = '"' + $r.text.Replace('"','""') + '"'
  $crosswalk += "$($r.utterance_id),$($r.speaker),$($r.source_line),$escaped"
}
[IO.File]::WriteAllLines((Join-Path $outCurator 'q1ec2_row_crosswalk.csv'), $crosswalk, $utf8)
Write-Output 'Built three full curator examples, three observer-only inputs, and the q1ec2 row crosswalk.'
