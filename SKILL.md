---
name: siliconflow-audio-transcribe
description: Transcribe audio files through the SiliconFlow `/v1/audio/transcriptions` API using `FunAudioLLM/SenseVoiceSmall` by default. Use this skill when asked to convert an audio file (such as mp3/wav/m4a/flac) into text, to call SiliconFlow transcription directly from terminal scripts, or to handle HTTP error responses from this endpoint.
---

# SiliconFlow Audio Transcribe

Use this skill to run a deterministic terminal workflow for SiliconFlow audio transcription.

## Credential Management (Ubuntu)

1. If `SILICONFLOW_API_KEY` is missing, ask the user whether to save the key for future OpenClaw usage at `~/.config/openclaw/secrets/siliconflow.env`.
2. After user confirmation, save the key with strict permissions:
```bash
mkdir -p ~/.config/openclaw/secrets
chmod 700 ~/.config/openclaw/secrets
printf 'SILICONFLOW_API_KEY=%s\n' "$USER_KEY" > ~/.config/openclaw/secrets/siliconflow.env
chmod 600 ~/.config/openclaw/secrets/siliconflow.env
```
3. Before transcription or OpenClaw startup, load the file:
```bash
set -a
. ~/.config/openclaw/secrets/siliconflow.env
set +a
```
4. Never print the full API key in logs or output.
5. Never commit API keys to repository files.

## Workflow

1. Ensure the API key is present in `SILICONFLOW_API_KEY`; if not, load `~/.config/openclaw/secrets/siliconflow.env`.
2. Run `scripts/transcribe_audio.sh <audio_file> [model]`.
3. Read stdout:
- HTTP 200: print transcribed text only.
- Non-200: print raw error body (for example `Forbidden`) and exit with non-zero status.

## Script Contract

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
set -a && . ~/.config/openclaw/secrets/siliconflow.env && set +a
scripts/transcribe_audio.sh ./audio.mp3
scripts/transcribe_audio.sh ./meeting.wav FunAudioLLM/SenseVoiceSmall
```
