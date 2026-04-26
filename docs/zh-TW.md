# team-orchestrator

> 在多個 AI 程式碼 CLI 中編排智能體團隊。定義一次，到處執行。

**語言**: [English](../README.md) · [Português (BR)](pt-BR.md) · [简体中文](zh-CN.md) · **繁體中文** · [日本語](ja.md) · [한국어](ko.md) · [Türkçe](tr.md)

## 簡介

Claude Code 外掛程式，**只需定義一次智能體團隊**，即可在以下平台同時使用：

- **Claude Code** — `/team:<name>` 斜線命令（主要目標）
- **Codex** — `~/.codex/agents/<name>.toml` 子智能體
- **其他 CLI** — 歡迎提交 PR！請查看主 README 中的 "Add a new runtime" 章節。

## 安裝

```bash
claude --plugin-dir /path/to/team-orchestrator
```

## 快速開始

```text
/team:setup-claude
/team:setup-codex          # 選用，啟用 Codex 鏡像
/team:new --name designers --instructions "UX 與設計系統團隊" --model sonnet --size 3
/reload-plugins
/team:designers 專注於儀表板重新設計
```

## 命令

| 命令 | 用途 |
|---|---|
| `/team:setup-claude` | 啟用 `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` |
| `/team:setup-codex` | 啟用 Codex 鏡像 |
| `/team:new` | 建立團隊 |
| `/team:delete <name>` | 從所有執行時中移除 |
| `/team:list` | 列出團隊 |
| `/team:<name>` | 在 Claude Code 中產生團隊 |

完整文件：[README.md](../README.md)。
