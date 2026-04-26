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

## 명령

| 명령 | 용도 |
|---|---|
| `/team:setup-claude` | `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` 활성화 |
| `/team:setup-codex` | Codex 미러링 활성화 |
| `/team:new` | 팀 생성 |
| `/team:delete <name>` | 모든 런타임에서 제거 |
| `/team:list` | 팀 목록 |
| `/team:<name>` | Claude Code에서 팀 스폰 |

전체 문서: [README.md](../README.md).
