# 🎯 GSD (Get Stuff Done) Documentation System

Welcome to the **.gsd** documentation and state tracking system for **Dodis Godis Mobile**.

This directory serves as the single source of truth for AI agents, developers, and maintainers. It implements a spec-driven development methodology: **Discuss → Plan → Execute → Verify**.

---

## 📂 Directory Index

| File | Purpose |
| :--- | :--- |
| [**STATE.md**](./STATE.md) | **Current Project State:** Active milestones, completed features, health metrics, and active blockers. |
| [**FLOW.md**](./FLOW.md) | **Application & System Flows:** User journeys, navigation graphs, game loops, and data flow. |
| [**CHANGELOG.md**](./CHANGELOG.md) | **Chronological History:** Comprehensive log of versions, migrations, refactors, and feature additions. |
| [**ROADMAP.md**](./ROADMAP.md) | **Future Planning:** Immediate priorities, upcoming sprint goals, and long-term features. |
| [**ARCHITECTURE.md**](./ARCHITECTURE.md) | **System Architecture:** Clean Architecture layers, BLoC pattern, dependency injection, and UI design system. |
| [**DECISIONS.md**](./DECISIONS.md) | **Architecture Decision Records (ADRs):** Rationale behind critical architectural and design choices. |

---

## 🛠️ Operating Principles

1. **Keep in Sync**: Whenever an architectural change, new feature, or major refactor occurs, update the relevant files in `.gsd/`.
2. **Context Integrity**: Before starting complex refactoring or feature development, consult [STATE.md](./STATE.md) and [ARCHITECTURE.md](./ARCHITECTURE.md) to avoid context rot.
3. **Spec-Driven**: Changes should follow defined decisions in [DECISIONS.md](./DECISIONS.md) and align with user journeys in [FLOW.md](./FLOW.md).
