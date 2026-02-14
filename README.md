# openclaw-skill-siliconflow-audio-transcribe

基于 SiliconFlow `/v1/audio/transcriptions` 接口的语音转文字（STT）脚本示例，可作为 OpenClaw skill 使用或独立命令行工具使用。

> 本仓库为示例实现，使用者可按需调整脚本细节、目录结构与环境变量配置。

## 功能简介

- 调用模型：`FunAudioLLM/SenseVoiceSmall`
- 功能：将本地音频文件通过 SiliconFlow 接口转写为文本
- 无需上传代码，只需保证本机可以访问 `https://api.siliconflow.cn`

## 目录结构

```bash
siliconflow-audio-transcribe/
├── SKILL.md                 # Skill 说明与使用约定
└── scripts/
    └── transcribe_audio.sh  # 实际调用 SiliconFlow STT 接口的脚本
```

## 使用前准备

1. 在 SiliconFlow 控制台创建 API Key。
2. 在本机设置环境变量 `SILICONFLOW_API_KEY`，推荐写入：

   ```bash
   mkdir -p ~/.config/openclaw/secrets
   chmod 700 ~/.config/openclaw/secrets

   cat > ~/.config/openclaw/secrets/siliconflow.env <<'EOF'
   SILICONFLOW_API_KEY=your_api_key_here
   EOF

   chmod 600 ~/.config/openclaw/secrets/siliconflow.env
   ```

3. 使用前加载：

   ```bash
   set -a
   . ~/.config/openclaw/secrets/siliconflow.env
   set +a
   ```

## 命令行用法

```bash
cd siliconflow-audio-transcribe
scripts/transcribe_audio.sh <音频文件路径> [模型名]
```

示例：

```bash
# 使用默认 SenseVoiceSmall 模型
scripts/transcribe_audio.sh ./audio.mp3

# 显式指定模型
scripts/transcribe_audio.sh ./meeting.wav FunAudioLLM/SenseVoiceSmall
```

- 成功：stdout 输出转写文本，退出码为 `0`
- 失败：输出错误信息，退出码为非 `0`

## English

This is an example **Speech-to-Text (STT)** tool using SiliconFlow's `/v1/audio/transcriptions` endpoint. It can be used as an OpenClaw skill or as a standalone CLI helper.

> This repo is an example implementation. Users are expected to adjust scripts, paths and environment variable setup according to their own environment.

### Features

- Model: `FunAudioLLM/SenseVoiceSmall`
- Purpose: Transcribe local audio files into text via SiliconFlow API

### Directory

```bash
siliconflow-audio-transcribe/
├── SKILL.md
└── scripts/
    └── transcribe_audio.sh
```

### Setup

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

### Usage

```bash
cd siliconflow-audio-transcribe
scripts/transcribe_audio.sh <audio_file> [model]
```

On success, the script prints plain text and exits with code `0`. On failure, it prints error details and exits with non-zero code.
