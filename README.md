# Library Management — a Vyuh Blueprint learning build

A small web app where a **Category** has many **Books**, and a **Book** has many
**Chapters**. It is built step by step to learn the 8 Vyuh Blueprint concepts:
Blueprint · Modules · Entities & Descriptors · Facets · Properties ·
Lifecycles & Revisions · Actions, Rules & Effects · Queries & Views.

Out of scope: users/login, roles, approvals, borrowing, delete, revision-history storage.

## Stack
| Part | Version / value |
|---|---|
| Flutter / Dart | 3.50.0 / 3.14.0, pinned in `.fvmrc` (managed by fvm) |
| Vyuh packages | 0.64.0 from https://pub.vyuh.tech |
| Database | PostgreSQL in Docker: container `library-postgres`, port `55433`, db `library_dev` |
| API server | http://localhost:8024/api |
| Web UI | http://localhost:8023 |

## First-time setup
```bash
# 1. Install fvm and put it on PATH
curl -fsSL https://fvm.app/install.sh | bash
echo 'export PATH="$HOME/fvm/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc

# 2. Install the pinned Flutter and link it into the repo (.fvm/flutter_sdk)
fvm install
fvm use 3.50.0

# 3. Check
./tools/sdk dart --version      # Dart SDK version: 3.14.0
```

## Tools
Always run Dart/Flutter through the wrapper, never a global `dart`/`flutter`.

| Command | What it does |
|---|---|
| `./tools/sdk dart …` / `./tools/sdk flutter …` | Runs the pinned SDK from `.fvm/flutter_sdk` |
| `./tools/stop` | Stops this repo's listeners on ports 8023/8024 only (other projects are left alone) |

## Layout
```
shared/library_model/   Blueprint definition shared by server and client
server/                 Blueprint API server + PostgreSQL migrations   (Phase 2–4)
client/                 Flutter web UI                                (Phase 5–6)
tools/                  sdk, stop (later: reset-db, check)
```

## Decisions
_Filled in as we go. Phase 1 records the lifecycle decision here._

- **Ports:** UI 8023, API 8024 (instead of 8081/8091), chosen by the developer.
- **Offline packages:** the current pub.vyuh.tech token is refused for the pro-tier
  packages (`vyuh_property`: authorization failed). The pinned 0.64.0 packages are
  already in `~/.pub-cache`, so run `./tools/sdk dart pub get --offline`.
  With a working token, a plain `pub get` resolves the same 0.64.0 versions.
