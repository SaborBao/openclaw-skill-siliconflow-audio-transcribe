# openclaw-skill-siliconflow-audio-transcribe

This is an example **Speech-to-Text (STT)** tool using SiliconFlow's `/v1/audio/transcriptions` endpoint. It can be used as an OpenClaw skill or as a standalone CLI helper.

> This repo is an example implementation. Users are expected to adjust scripts, paths and environment variable setup according to their own environment.

## Features

- Model: `FunAudioLLM/SenseVoiceSmall`
- Purpose: Transcribe local audio files into text via SiliconFlow API

## Directory

```bash
siliconflow-audio-transcribe/
├── SKILL.md
└── scripts/
    └── transcribe_audio.sh
```

## Setup

1. Create an API key in SiliconFlow console.
2. Set `OPENCLAW_SILICONFLOW_API_KEY` on your machine (standardized location):

   ```bash
   mkdir -p ~/.openclaw
   chmod 700 ~/.openclaw

   cat >> ~/.openclaw/.env <<'EOF'
   OPENCLAW_SILICONFLOW_API_KEY=your_api_key_here
   EOF

   chmod 600 ~/.openclaw/.env
   ```

3. Note: OpenClaw loads `~/.openclaw/.env` automatically on startup (no manual `source` needed).

## Usage

```bash
cd siliconflow-audio-transcribe
scripts/transcribe_audio.sh <audio_file> [model]
```

On success, the script prints plain text and exits with code `0`. On failure, it prints error details and exits with non-zero code.
