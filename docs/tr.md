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

## Codex'te Kullanım

Codex, Claude slash komutlarını yüklemez. `/team:*` komutları yalnızca Claude
Code eklentisinin yönetim yüzeyidir. Codex için bu eklenti her takımı Codex'in
yerel subagent yapılandırmasına aynalar.

### 1. Codex aynalamasını etkinleştirin

Claude Code içinde bir kez çalıştırın:

```text
/team:setup-codex
```

Bu komut `~/.codex/agents/` dizinini oluşturur, `~/.codex/config.toml` içinde
`[agents]` bloğunun olmasını sağlar ve Codex'i eklenti durumunda etkin hedef
olarak kaydeder.

### 2. Takım oluşturun

Aynalama etkinleştirildikten sonra takımı normal şekilde oluşturun:

```text
/team:new --name designers \
  --instructions "Frontend, UX, and visual design team" \
  --model gpt-5.4 --size 3
```

Veya yalnızca Codex'e yazın:

```text
/team:new --name reviewers \
  --instructions "Review code for correctness, security, and missing tests." \
  --model gpt-5.4 --target codex
```

Oluşturulan Codex dosyaları:

```text
~/.codex/agents/designers.toml
~/.codex/config.toml              # contains [agents.designers]
```

### 3. Codex'i yeniden başlatın

Codex, ajan tanımlarını oturum başlangıcında okur. Bir takım oluşturduktan veya
sildikten sonra `~/.codex/config.toml` dosyasını yeniden yüklemesi için Codex'i
yeniden başlatın/açın.

### 4. Doğal dille çağırın

Codex'te subagent'ı adıyla isteyin:

```text
Use the designers subagent to review this dashboard implementation.
```

```text
Spawn the reviewers agent and have it check the current diff.
```

```text
Use codex-demo to confirm which agent handled this task.
```

Multi-agent UI etkin Codex CLI sürümlerinde `/agent` komutu da mevcut agents
listesini gösterebilir. İsimler `~/.codex/config.toml` içindeki
`[agents.<name>]` girdileriyle eşleşmelidir.

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
