---
name: siliconflow-audio-transcribe
description: Speech-to-text (STT)
homepage: https://api.siliconflow.cn
user-invocable: true
metadata: { "openclaw": { "emoji": "🎙️", "primaryEnv": "OPENCLAW_SILICONFLOW_API_KEY", "requires": { "env": ["OPENCLAW_SILICONFLOW_API_KEY"] } } }
---

# SiliconFlow Speech-to-Text (STT)

Prereq: `OPENCLAW_SILICONFLOW_API_KEY` must be set.

## Usage

```bash
cd skills/siliconflow-audio-transcribe
scripts/transcribe_audio.sh <audio_file> [model]
```

## Defaults

- Model: `FunAudioLLM/SenseVoiceSmall`

## Examples

```bash
cd skills/siliconflow-audio-transcribe

# Use default model
scripts/transcribe_audio.sh ./audio.mp3

# Specify model explicitly
scripts/transcribe_audio.sh ./meeting.wav FunAudioLLM/SenseVoiceSmall
```
