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
2. Set `SILICONFLOW_API_KEY` on your machine, for example:

   ```bash
   mkdir -p ~/.config/openclaw/secrets
   chmod 700 ~/.config/openclaw/secrets

   cat > ~/.config/openclaw/secrets/siliconflow.env <<'EOF'
   SILICONFLOW_API_KEY=your_api_key_here
   EOF

   chmod 600 ~/.config/openclaw/secrets/siliconflow.env
   ```

3. Load it before running scripts:

   ```bash
   set -a
   . ~/.config/openclaw/secrets/siliconflow.env
   set +a
   ```

## Usage

```bash
cd siliconflow-audio-transcribe
scripts/transcribe_audio.sh <audio_file> [model]
```

On success, the script prints plain text and exits with code `0`. On failure, it prints error details and exits with non-zero code.
