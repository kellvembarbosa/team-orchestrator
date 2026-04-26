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

## 在 Codex 中使用

Codex 不会加载 Claude 的斜杠命令。`/team:*` 命令只是在 Claude Code
插件中的管理界面。对于 Codex，本插件会把每个团队镜像为 Codex 原生的
subagent 配置。

### 1. 启用 Codex 镜像

在 Claude Code 中运行一次：

```text
/team:setup-codex
```

这会创建 `~/.codex/agents/`，确保 `~/.codex/config.toml` 中有
`[agents]` 块，并在插件状态中把 Codex 标记为启用目标。

### 2. 创建团队

启用镜像后正常创建：

```text
/team:new --name designers \
  --instructions "Frontend, UX, and visual design team" \
  --model gpt-5.4 --size 3
```

或者只写入 Codex：

```text
/team:new --name reviewers \
  --instructions "Review code for correctness, security, and missing tests." \
  --model gpt-5.4 --target codex
```

插件会生成：

```text
~/.codex/agents/designers.toml
~/.codex/config.toml              # contains [agents.designers]
```

### 3. 重启 Codex

Codex 在会话启动时读取智能体定义。创建或删除团队后，重启/重新打开
Codex，以重新加载 `~/.codex/config.toml`。

### 4. 用自然语言调用

在 Codex 中按名称请求 subagent：

```text
Use the designers subagent to review this dashboard implementation.
```

```text
Spawn the reviewers agent and have it check the current diff.
```

```text
Use codex-demo to confirm which agent handled this task.
```

在启用了 multi-agent UI 的 Codex CLI 版本中，`/agent` 也可以显示可用
agents。名称应与 `~/.codex/config.toml` 中的 `[agents.<name>]` 一致。

## 命令

| 命令 | 用途 |
|---|---|
| `/team:setup-claude` | 启用 `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` |
| `/team:setup-codex` | 启用 Codex 镜像 |
| `/team:new` | 创建团队 |
| `/team:seed` | 一键创建 24 个默认团队（UX、产品、工程、增长、商业、风险、安全）。幂等 — 已存在则跳过。 |
| `/team:delete <name>` | 从所有运行时中删除 |
| `/team:list` | 列出团队 |
| `/team:uninstall [--yes] [--dry-run] [--keep-teams] [--purge-codex-config] [--purge-claude-env]` | 移除生成的团队和插件状态。`--dry-run` 仅预览；`--keep-teams` 保留团队文件；`--purge-codex-config` 清理 `~/.codex/config.toml` 的 `[agents]` 段；`--purge-claude-env` 移除 `~/.claude/settings.json` 中的实验性环境变量。 |
| `/team:<name>` | 在 Claude Code 中生成团队 |

完整文档：[README.md](../README.md)。
