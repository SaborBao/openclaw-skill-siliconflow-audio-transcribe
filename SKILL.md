---
name: siliconflow-audio-transcribe
description: Speech-to-text (STT)
homepage: https://api.siliconflow.cn
user-invocable: true
metadata: { "openclaw": { "emoji": "🎙️", "primaryEnv": "OPENCLAW_SILICONFLOW_API_KEY", "requires": { "env": ["OPENCLAW_SILICONFLOW_API_KEY"] } } }
---

# SiliconFlow Speech-to-Text (STT)

Use this skill to call SiliconFlow transcription and convert an audio file into text.

## Credential management

1. If `OPENCLAW_SILICONFLOW_API_KEY` is missing, ask the user whether to save the key for future OpenClaw usage at `~/.openclaw/.env`.
2. After user confirmation, save the key with strict permissions:
```bash
mkdir -p ~/.openclaw
chmod 700 ~/.openclaw
# append or write as you prefer; keep permissions strict
printf 'OPENCLAW_SILICONFLOW_API_KEY=%s\n' "$USER_KEY" >> ~/.openclaw/.env
chmod 600 ~/.openclaw/.env
```
3. OpenClaw loads `~/.openclaw/.env` automatically on startup (no manual `source` needed).
4. Never print the full API key in logs or output.
5. Never commit API keys to repository files.

## Workflow

1. Ensure the API key is present in `OPENCLAW_SILICONFLOW_API_KEY` (via `~/.openclaw/.env`).
2. Run `scripts/transcribe_audio.sh <audio_file> [model]`.
3. Read stdout:
- HTTP 200: print transcribed text only.
- Non-200: print raw error body (for example `Forbidden`) and exit with non-zero status.

## Script contract

- Entry point: `scripts/transcribe_audio.sh`
- Endpoint: `https://api.siliconflow.cn/v1/audio/transcriptions`
- Default model: `FunAudioLLM/SenseVoiceSmall`
- Parameters:
  - required: local audio file path
  - optional: model name
- Exit behavior:
  - `0` on success (text printed)
  - non-zero on failures (validation, network, non-200, malformed JSON response)

## Examples

```bash
# Ensure API key is present in ~/.openclaw/.env (auto-loaded by OpenClaw)
scripts/transcribe_audio.sh ./audio.mp3
scripts/transcribe_audio.sh ./meeting.wav FunAudioLLM/SenseVoiceSmall
```
