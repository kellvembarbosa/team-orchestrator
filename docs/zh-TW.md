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

## 在 Codex 中使用

Codex 不會載入 Claude 的斜線命令。`/team:*` 命令只是 Claude Code
外掛中的管理介面。對於 Codex，本外掛會把每個團隊鏡像為 Codex 原生的
subagent 設定。

### 1. 啟用 Codex 鏡像

在 Claude Code 中執行一次：

```text
/team:setup-codex
```

這會建立 `~/.codex/agents/`，確認 `~/.codex/config.toml` 中有
`[agents]` 區塊，並在外掛狀態中把 Codex 標記為啟用目標。

### 2. 建立團隊

啟用鏡像後正常建立：

```text
/team:new --name designers \
  --instructions "Frontend, UX, and visual design team" \
  --model gpt-5.4 --size 3
```

或只寫入 Codex：

```text
/team:new --name reviewers \
  --instructions "Review code for correctness, security, and missing tests." \
  --model gpt-5.4 --target codex
```

外掛會產生：

```text
~/.codex/agents/designers.toml
~/.codex/config.toml              # contains [agents.designers]
```

### 3. 重新啟動 Codex

Codex 會在工作階段啟動時讀取智能體定義。建立或刪除團隊後，請重新啟動/
重新開啟 Codex，以重新載入 `~/.codex/config.toml`。

### 4. 用自然語言呼叫

在 Codex 中用名稱請求 subagent：

```text
Use the designers subagent to review this dashboard implementation.
```

```text
Spawn the reviewers agent and have it check the current diff.
```

```text
Use codex-demo to confirm which agent handled this task.
```

在啟用了 multi-agent UI 的 Codex CLI 版本中，`/agent` 也可以顯示可用
agents。名稱應與 `~/.codex/config.toml` 中的 `[agents.<name>]` 一致。

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
