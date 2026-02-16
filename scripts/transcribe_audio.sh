#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <audio_file> [model]" >&2
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
  usage
  exit 2
fi

audio_file="$1"
model="${2:-FunAudioLLM/SenseVoiceSmall}"
endpoint="https://api.siliconflow.cn/v1/audio/transcriptions"

if [[ -z "${OPENCLAW_SILICONFLOW_API_KEY:-}" ]]; then
  echo "OPENCLAW_SILICONFLOW_API_KEY is required." >&2
  exit 2
fi

if [[ ! -f "$audio_file" ]]; then
  echo "Audio file not found: $audio_file" >&2
  exit 2
fi

tmp_body="$(mktemp)"
cleanup() {
  rm -f "$tmp_body"
}
trap cleanup EXIT

http_status="$(
  curl -sS \
    -o "$tmp_body" \
    -w "%{http_code}" \
    --request POST "$endpoint" \
    -H "Authorization: Bearer $OPENCLAW_SILICONFLOW_API_KEY" \
    -F "file=@$audio_file" \
    -F "model=$model"
)"

if [[ "$http_status" != "200" ]]; then
  cat "$tmp_body"
  exit 1
fi

if ! python3 - "$tmp_body" <<'PY'
import json
import sys

path = sys.argv[1]
with open(path, "r", encoding="utf-8") as f:
    payload = json.load(f)

text = payload.get("text")
if isinstance(text, str):
    print(text)
    raise SystemExit(0)

print(json.dumps(payload, ensure_ascii=False))
raise SystemExit(1)
PY
then
  exit 1
fi
