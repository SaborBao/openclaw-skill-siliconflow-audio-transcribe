# openclaw-skill-siliconflow-audio-transcribe

基于 SiliconFlow `/v1/audio/transcriptions` 接口的语音转文字（STT）脚本示例，可作为 OpenClaw skill 使用或独立命令行工具使用。

> 本仓库为示例实现，使用者可按需调整脚本细节、目录结构与环境变量配置。
>
> English version: see [README.en.md](README.en.md).

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
2. 在本机设置环境变量 `OPENCLAW_SILICONFLOW_API_KEY`，**统一写入**：

   ```bash
   mkdir -p ~/.openclaw
   chmod 700 ~/.openclaw

   cat >> ~/.openclaw/.env <<'EOF'
   OPENCLAW_SILICONFLOW_API_KEY=your_api_key_here
   EOF

   chmod 600 ~/.openclaw/.env
   ```

3. 说明：OpenClaw 会自动加载 `~/.openclaw/.env`（无需手动 `source`）。

## 额外说明：SiliconFlow 推广链接

如果你是第一次使用 SiliconFlow，可以通过以下链接注册，每人都可以获取 16 元额度（可用来体验除免费模型之外的其他模型）：

- 推荐链接：https://cloud.siliconflow.cn/i/QcpkcG5j

> 说明：这是作者使用的推广链接，不影响你正常使用免费模型，只是多拿一份初始额度。

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
