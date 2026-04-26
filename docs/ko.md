# team-orchestrator

> 여러 AI 코딩 CLI에서 에이전트 팀을 오케스트레이션. 한 번 정의하고 어디서나 실행.

**언어**: [English](../README.md) · [Português (BR)](pt-BR.md) · [简体中文](zh-CN.md) · [繁體中文](zh-TW.md) · [日本語](ja.md) · **한국어** · [Türkçe](tr.md)

## 개요

Claude Code 플러그인으로 **에이전트 팀을 한 번만 정의**하면 다음 런타임에서 동시에 사용할 수 있습니다:

- **Claude Code** — `/team:<name>` 슬래시 명령 (기본 타겟)
- **Codex** — `~/.codex/agents/<name>.toml` 서브에이전트
- **기타 CLI** — PR 환영! 메인 README의 "Add a new runtime" 섹션 참조.

## 설치

```bash
claude --plugin-dir /path/to/team-orchestrator
```

## 빠른 시작

```text
/team:setup-claude
/team:setup-codex          # 선택사항. Codex 미러링 활성화
/team:new --name designers --instructions "UX 및 디자인 시스템 팀" --model sonnet --size 3
/reload-plugins
/team:designers 대시보드 재설계에 집중
```

## Codex에서 사용하기

Codex는 Claude 슬래시 명령을 로드하지 않습니다. `/team:*` 명령은 Claude Code
플러그인에서 팀을 관리하기 위한 인터페이스입니다. Codex에서는 이 플러그인이 각
팀을 Codex 네이티브 subagent 설정으로 미러링합니다.

### 1. Codex 미러링 활성화

Claude Code에서 한 번 실행합니다:

```text
/team:setup-codex
```

이 명령은 `~/.codex/agents/`를 만들고, `~/.codex/config.toml`에 `[agents]`
블록이 있도록 준비하며, 플러그인 상태에서 Codex를 활성 타겟으로 저장합니다.

### 2. 팀 생성

미러링을 활성화한 뒤 일반적으로 생성합니다:

```text
/team:new --name designers \
  --instructions "Frontend, UX, and visual design team" \
  --model gpt-5.4 --size 3
```

Codex에만 쓸 수도 있습니다:

```text
/team:new --name reviewers \
  --instructions "Review code for correctness, security, and missing tests." \
  --model gpt-5.4 --target codex
```

생성되는 Codex 파일:

```text
~/.codex/agents/designers.toml
~/.codex/config.toml              # contains [agents.designers]
```

### 3. Codex 재시작

Codex는 세션이 시작될 때 에이전트 정의를 읽습니다. 팀을 만들거나 삭제한 뒤에는
Codex를 재시작/다시 열어 `~/.codex/config.toml`을 다시 로드하세요.

### 4. 자연어로 호출

Codex에서는 subagent 이름을 말해서 요청합니다:

```text
Use the designers subagent to review this dashboard implementation.
```

```text
Spawn the reviewers agent and have it check the current diff.
```

```text
Use codex-demo to confirm which agent handled this task.
```

multi-agent UI가 활성화된 Codex CLI에서는 `/agent`로 사용 가능한 agents를 볼 수도
있습니다. 이름은 `~/.codex/config.toml`의 `[agents.<name>]`와 일치해야 합니다.

## 명령

| 명령 | 용도 |
|---|---|
| `/team:setup-claude` | `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` 활성화 |
| `/team:setup-codex` | Codex 미러링 활성화 |
| `/team:new` | 팀 생성 |
| `/team:seed` | 24 개의 기본 팀(UX, 프로덕트, 엔지니어링, 그로스, 비즈니스, 리스크, 보안)을 일괄 생성. 멱등 — 이미 존재하면 건너뜁니다. |
| `/team:delete <name>` | 모든 런타임에서 제거 |
| `/team:list` | 팀 목록 |
| `/team:uninstall [--yes] [--dry-run] [--keep-teams] [--purge-codex-config] [--purge-claude-env]` | 생성된 팀과 플러그인 상태 제거. `--dry-run` 미리보기. `--keep-teams` 팀 파일 유지. `--purge-codex-config` `~/.codex/config.toml` 의 `[agents]` 블록 제거. `--purge-claude-env` `~/.claude/settings.json` 의 실험 플래그 제거. |
| `/team:<name>` | Claude Code에서 팀 스폰 |

전체 문서: [README.md](../README.md).
