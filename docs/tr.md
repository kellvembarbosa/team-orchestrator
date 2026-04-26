# team-orchestrator

> Birden fazla AI kodlama CLI'ında ajan takımlarını orkestre edin. Bir kez tanımla, her yerde çalıştır.

**Diller**: [English](../README.md) · [Português (BR)](pt-BR.md) · [简体中文](zh-CN.md) · [繁體中文](zh-TW.md) · [日本語](ja.md) · [한국어](ko.md) · **Türkçe**

## Genel Bakış

Claude Code eklentisi: **ajan takımlarını bir kez tanımlayın**, aynı anda şu çalışma zamanlarında kullanın:

- **Claude Code** — `/team:<name>` slash komutları (ana hedef)
- **Codex** — `~/.codex/agents/<name>.toml` alt-ajanları
- **Diğer CLI'lar** — PR'ları memnuniyetle karşılarız! Ana README'deki "Add a new runtime" bölümüne bakın.

## Kurulum

```bash
claude --plugin-dir /path/to/team-orchestrator
```

## Hızlı Başlangıç

```text
/team:setup-claude
/team:setup-codex          # opsiyonel. Codex aynalamasını etkinleştirir
/team:new --name designers --instructions "UX ve tasarım sistemi takımı" --model sonnet --size 3
/reload-plugins
/team:designers dashboard yeniden tasarımına odaklan
```

## Komutlar

| Komut | Amaç |
|---|---|
| `/team:setup-claude` | `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` ayarlar |
| `/team:setup-codex` | Codex aynalamasını etkinleştirir |
| `/team:new` | Takım oluşturur |
| `/team:delete <name>` | Tüm çalışma zamanlarından kaldırır |
| `/team:list` | Takımları listeler |
| `/team:<name>` | Claude Code'da takımı spawn eder |

Tam dokümantasyon: [README.md](../README.md).
