# team-orchestrator

> 在多个 AI 编码 CLI 中编排智能体团队。定义一次，到处运行。

**语言**: [English](../README.md) · [Português (BR)](pt-BR.md) · **简体中文** · [繁體中文](zh-TW.md) · [日本語](ja.md) · [한국어](ko.md) · [Türkçe](tr.md)

## 简介

Claude Code 插件，**只需定义一次智能体团队**，即可在以下平台同时使用：

- **Claude Code** — `/team:<name>` 斜杠命令（主要目标）
- **Codex** — `~/.codex/agents/<name>.toml` 子智能体
- **其他 CLI** — 欢迎提交 PR！请查看主 README 中的 "Add a new runtime" 章节。

## 安装

```bash
claude --plugin-dir /path/to/team-orchestrator
```

## 快速开始

```text
/team:setup-claude
/team:setup-codex          # 可选，启用 Codex 镜像
/team:new --name designers --instructions "UX 与设计系统团队" --model sonnet --size 3
/reload-plugins
/team:designers 专注于仪表板重设计
```

## 命令

| 命令 | 用途 |
|---|---|
| `/team:setup-claude` | 启用 `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` |
| `/team:setup-codex` | 启用 Codex 镜像 |
| `/team:new` | 创建团队 |
| `/team:delete <name>` | 从所有运行时中删除 |
| `/team:list` | 列出团队 |
| `/team:<name>` | 在 Claude Code 中生成团队 |

完整文档：[README.md](../README.md)。
