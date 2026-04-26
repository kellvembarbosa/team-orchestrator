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
