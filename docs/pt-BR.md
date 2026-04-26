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

## Como usar no Codex

O Codex não carrega os slash commands do Claude. Os comandos `/team:*` servem
para gerenciar os times pelo plugin no Claude Code. Para o Codex, o plugin
espelha cada time para a configuração nativa de subagents.

### 1. Ative o espelhamento

Rode uma vez no Claude Code:

```text
/team:setup-codex
```

Isso cria `~/.codex/agents/`, prepara o bloco `[agents]` em
`~/.codex/config.toml` e marca o Codex como alvo habilitado.

### 2. Crie um time

Depois do setup, crie normalmente:

```text
/team:new --name designers \
  --instructions "Time de frontend, UX e design system" \
  --model gpt-5.4 --size 3
```

Ou crie somente no Codex:

```text
/team:new --name reviewers \
  --instructions "Revise código procurando bugs, riscos de segurança e testes faltando" \
  --model gpt-5.4 --target codex
```

O plugin gera:

```text
~/.codex/agents/designers.toml
~/.codex/config.toml              # com [agents.designers]
```

### 3. Reinicie o Codex

O Codex lê os agentes no início da sessão. Depois de criar ou remover um time,
reinicie/reabra o Codex para recarregar `~/.codex/config.toml`.

### 4. Invoque por linguagem natural

No Codex, chame o subagente pelo nome:

```text
Use o subagente designers para revisar esta implementação do dashboard.
```

```text
Spawn the reviewers agent and have it check the current diff.
```

```text
Use codex-demo para confirmar qual agente executou esta tarefa.
```

Em versões do Codex CLI com UI multi-agent habilitada, `/agent` também pode
mostrar os agentes disponíveis. Os nomes devem bater com os blocos
`[agents.<nome>]` em `~/.codex/config.toml`.

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
