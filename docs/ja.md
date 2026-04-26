# team-orchestrator

> 複数の AI コーディング CLI でエージェントチームをオーケストレート。一度定義すれば、どこでも実行。

**言語**: [English](../README.md) · [Português (BR)](pt-BR.md) · [简体中文](zh-CN.md) · [繁體中文](zh-TW.md) · **日本語** · [한국어](ko.md) · [Türkçe](tr.md)

## 概要

Claude Code プラグインで、**エージェントチームを一度だけ定義**し、以下のランタイムで同時に利用できます：

- **Claude Code** — `/team:<name>` スラッシュコマンド（メインターゲット）
- **Codex** — `~/.codex/agents/<name>.toml` サブエージェント
- **その他の CLI** — PR を歓迎します！メイン README の "Add a new runtime" を参照。

## インストール

```bash
claude --plugin-dir /path/to/team-orchestrator
```

## クイックスタート

```text
/team:setup-claude
/team:setup-codex          # オプション。Codex ミラーリングを有効化
/team:new --name designers --instructions "UX とデザインシステムチーム" --model sonnet --size 3
/reload-plugins
/team:designers ダッシュボード再設計に集中
```

## Codex での使い方

Codex は Claude のスラッシュコマンドを読み込みません。`/team:*` コマンドは
Claude Code プラグイン上の管理用インターフェイスです。Codex 向けには、この
プラグインが各チームを Codex ネイティブの subagent 設定へミラーします。

### 1. Codex ミラーリングを有効化

Claude Code で一度だけ実行します：

```text
/team:setup-codex
```

これにより `~/.codex/agents/` が作成され、`~/.codex/config.toml` に
`[agents]` ブロックが用意され、プラグイン状態で Codex が有効なターゲットに
なります。

### 2. チームを作成

ミラーリングを有効化した後、通常どおり作成します：

```text
/team:new --name designers \
  --instructions "Frontend, UX, and visual design team" \
  --model gpt-5.4 --size 3
```

Codex のみに書き込むこともできます：

```text
/team:new --name reviewers \
  --instructions "Review code for correctness, security, and missing tests." \
  --model gpt-5.4 --target codex
```

生成される Codex ファイル：

```text
~/.codex/agents/designers.toml
~/.codex/config.toml              # contains [agents.designers]
```

### 3. Codex を再起動

Codex はセッション開始時にエージェント定義を読み込みます。チームを作成または
削除した後は、Codex を再起動/再オープンして `~/.codex/config.toml` を再読み込み
してください。

### 4. 自然言語で呼び出す

Codex では subagent 名を指定して依頼します：

```text
Use the designers subagent to review this dashboard implementation.
```

```text
Spawn the reviewers agent and have it check the current diff.
```

```text
Use codex-demo to confirm which agent handled this task.
```

multi-agent UI が有効な Codex CLI では、`/agent` でも利用可能な agents を確認
できます。名前は `~/.codex/config.toml` の `[agents.<name>]` と一致します。

## コマンド

| コマンド | 用途 |
|---|---|
| `/team:setup-claude` | `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` を有効化 |
| `/team:setup-codex` | Codex ミラーリングを有効化 |
| `/team:new` | チーム作成 |
| `/team:delete <name>` | すべてのランタイムから削除 |
| `/team:list` | チーム一覧 |
| `/team:<name>` | Claude Code でチームをスポーン |

完全なドキュメント：[README.md](../README.md)。
