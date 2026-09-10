#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
documentation_root=$(cd -- "$script_dir/.." && pwd)
workspace_root=$(cd -- "$documentation_root/.." && pwd)
spec_root=${GSM_SPECIFICATIONS_ROOT:-"$workspace_root/gsm/gsm-specifications"}
research_root=${GSM_RESEARCH_LAB_ROOT:-"$workspace_root/gsm/gsm-research-lab"}

if [[ ! -d "$research_root/docs" ]]; then
  echo "Missing GSM Research Lab docs: $research_root/docs" >&2
  exit 1
fi
for required in model schemas; do
  if [[ ! -d "$spec_root/$required" ]]; then
    echo "Missing GSM source directory: $spec_root/$required" >&2
    exit 1
  fi
done

research_target="$documentation_root/gsm/research-lab/programs"
model_target="$documentation_root/gsm/specifications/model"
schemas_target="$documentation_root/gsm/specifications/schemas"

mkdir -p "$research_target/generative-governance" "$model_target" "$schemas_target"

cp "$research_root/docs/README.md" "$research_target/index.md"
cp "$research_root/docs/archetype-referential-model.md" "$research_target/"
cp "$research_root/docs/generative-governance/README.md" \
  "$research_target/generative-governance/index.md"
for chapter in causal-model governance-chain dna-production cases decision-register; do
  cp "$research_root/docs/generative-governance/$chapter.md" \
    "$research_target/generative-governance/"
done

cp "$spec_root/model/"*.py "$model_target/"

cp "$spec_root/schemas/README.md" "$schemas_target/index.md"
cp "$spec_root/schemas/"*.json "$schemas_target/"

research_pages=$(find "$research_target" -name '*.md' | wc -l)
model_artifacts=$(find "$model_target" -maxdepth 1 -type f | wc -l)
schema_artifacts=$(find "$schemas_target" -maxdepth 1 -type f | wc -l)

[[ "$research_pages" -eq 8 ]] || {
  echo "Expected 8 research pages, found $research_pages" >&2
  exit 1
}
[[ "$model_artifacts" -eq 2 ]] || {
  echo "Expected 2 model files, found $model_artifacts" >&2
  exit 1
}
[[ "$schema_artifacts" -eq 9 ]] || {
  echo "Expected 9 schema files, found $schema_artifacts" >&2
  exit 1
}

echo "Synchronized GSM content: $research_pages research pages, $model_artifacts model files, $schema_artifacts schema files"