# team-orchestrator

> Orquestre times de agentes em múltiplas CLIs de codificação com IA. Defina uma vez, rode em qualquer lugar.

**Idiomas**: [English](../README.md) · **Português (BR)** · [简体中文](zh-CN.md) · [繁體中文](zh-TW.md) · [日本語](ja.md) · [한국어](ko.md) · [Türkçe](tr.md)

## O que é

Plugin do Claude Code que define **times de agentes uma única vez** e os disponibiliza simultaneamente em:

- **Claude Code** — slash commands `/team:<nome>` (alvo principal)
- **Codex** — subagents em `~/.codex/agents/<nome>.toml`
- **Outras CLIs** — abra um PR! Veja "Add a new runtime" no README principal.

## Instalação

```bash
claude --plugin-dir /caminho/para/team-orchestrator
```

## Início rápido

```text
/team:setup-claude
/team:setup-codex          # opcional, ativa espelhamento Codex
/team:new --name designers --instructions "Time de UX e design system" --model sonnet --size 3
/reload-plugins
/team:designers foco no redesign do dashboard
```

## Comandos

| Comando | Função |
|---|---|
| `/team:setup-claude` | Ativa `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` |
| `/team:setup-codex` | Habilita espelhamento para Codex |
| `/team:new` | Cria um time |
| `/team:delete <nome>` | Remove de todas as runtimes |
| `/team:list` | Lista times |
| `/team:<nome>` | Spawna o time no Claude Code |

Documentação completa: [README.md](../README.md).
