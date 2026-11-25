# Vyuh Blueprint Project: Development Setup Guide

From an empty Linux machine to a working development setup for a Dart / Flutter project built with Vyuh Blueprint and PostgreSQL. Follow the steps in order. Every step ends with a check, so you know it worked before moving on.

Values written like `<this>` are yours to choose. Pick them once in step 1 and use the same values everywhere.

## 1. Choose your project values

| Value | Example | Rule |
|---|---|---|
| `<project>` | `inventory` | Short, lowercase, no spaces. Used to name the container and volume |
| `<repo-url>` | `https://github.com/you/inventory.git` | Your git repository |
| `<db-name>` | `inventory_dev` | Lowercase letters, digits and `_` |
| `<db-port>` | `55440` | A free port. Every project on your machine needs its own |
| `<api-port>` | `8030` | Port for the API server (later) |
| `<ui-port>` | `8031` | Port for the web UI (later) |

Check that a port is free (no output means free):

```bash
ss -ltn | grep ':55440'
```

## 2. What you will have at the end

| Part | What it is | Where |
|---|---|---|
| Flutter + Dart | Pinned to one version for the whole team | `.fvm/flutter_sdk`, managed by fvm |
| Vyuh Blueprint packages | The framework | Downloaded from `https://pub.vyuh.tech` |
| PostgreSQL 17 | The database, in Docker | `127.0.0.1:<db-port>`, database `<db-name>` |

How the pieces connect:

```
.fvmrc --> fvm install --> .fvm/flutter_sdk --> tools/sdk --> dart / flutter
.env   --> docker-compose.yml + tools/db  --> PostgreSQL container
.env   --> server config                   --> server connects to PostgreSQL
```

## 3. What you need before you start

| Need | Why | Check |
|---|---|---|
| Linux (Ubuntu 22.04 or newer) | The scripts are written for Linux | `lsb_release -a` |
| git | To download the code | `git --version` |
| curl | To install fvm | `curl --version` |
| python3 | Used by helper scripts | `python3 --version` |
| Docker Engine + Compose v2 | Runs PostgreSQL | `docker --version` and `docker compose version` |
| About 5 GB free disk | Flutter SDK (~1.5 GB) + database image + packages | `df -h ~` |
| Internet access | Downloads Flutter, packages and the database image | |
| A Vyuh package token (pro tier) | The Vyuh packages are private | Ask your team lead |

Docker must work without `sudo`:

```bash
docker ps
```

If it says "permission denied", add yourself to the docker group, then log out and log in again:

```bash
sudo usermod -aG docker $USER
```

## 4. Get the code

```bash
git clone <repo-url>
cd <project>
```

**Check:** `ls -a` shows `.fvmrc`, `docker-compose.yml`, `.env.example` and `tools/`.

## 5. Install fvm (Flutter Version Manager)

fvm downloads Flutter versions and links the right one into each project. The file `.fvmrc` in the project says which version to use.

```bash
curl -fsSL https://fvm.app/install.sh | bash
echo 'export PATH="$HOME/fvm/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Check:** `fvm --version` prints a version.

## 6. Install the project's Flutter version

Run these in the project root:

```bash
cat .fvmrc           # shows the pinned version, e.g. {"flutter": "3.50.0"}
fvm install          # downloads that version (a few minutes)
fvm use <version>    # e.g. fvm use 3.50.0 -> creates .fvm/flutter_sdk
```

If `fvm use` asks to update `.gitignore` or VS Code settings, answering yes is fine.

**Check:**

```bash
./tools/sdk dart --version       # the Dart version that ships with that Flutter
./tools/sdk flutter --version    # the version from .fvmrc
```

Always run Dart and Flutter through `./tools/sdk`, never a global `dart` or `flutter`. That guarantees everyone uses the same version.

## 7. Give Dart access to the Vyuh packages

The Vyuh packages are hosted on `https://pub.vyuh.tech` and need a token. Never paste the token into chat, email or git.

```bash
./tools/sdk dart pub token add https://pub.vyuh.tech
# paste the token when asked
```

**Check:** `./tools/sdk dart pub token list` shows `https://pub.vyuh.tech`.

**If the token is refused** ("authorization failed" for a package such as `vyuh_property`), the token does not have pro-tier access. If the exact package versions are already in `~/.pub-cache` (for example from another project on the same machine), you can continue with `--offline` (next step). Otherwise ask for a token with pro access.

## 8. Download the packages

Run `pub get` in every folder that has a `pubspec.yaml` (for example the shared model package and the server):

```bash
find . -name pubspec.yaml -not -path './.fvm/*'     # lists them
cd <folder-with-pubspec>
<path-to-root>/tools/sdk dart pub get               # or: dart pub get --offline
```

**Check:** each command ends with `Got dependencies!` or `Changed N dependencies!`. A line such as "1 package has newer versions" is only information, not an error.

## 9. Configure the database (.env)

All database settings live in one file, `.env`. It is never committed, because it holds the password. The repository contains a template, `.env.example`.

The first run of `./tools/db up` copies the template to `.env` and fills in a random password. Before that first run, open `.env.example` (or `.env` afterwards) and set your values from step 1:

| Setting | Set it to | Meaning |
|---|---|---|
| COMPOSE_PROJECT_NAME | `<project>` | Groups this project's containers |
| DB_CONTAINER | `<project>-postgres` | Container name |
| DB_VOLUME | `<project>_postgres_data` | Where the data is stored (survives restarts) |
| DB_IMAGE | `public.ecr.aws/supabase/postgres:17.6.1.167` | PostgreSQL 17 image (keep unless told otherwise) |
| DB_HOST | `127.0.0.1` | Only this machine can connect |
| DB_PORT | `<db-port>` | Port on your machine |
| DB_NAME | `<db-name>` | Database name |
| DB_USER | `postgres` | Database user |
| DB_PASSWORD | (random) | Created for you by `tools/db`; never commit it |

Example `.env` for a project called `inventory`:

```
COMPOSE_PROJECT_NAME=inventory
DB_CONTAINER=inventory-postgres
DB_VOLUME=inventory_postgres_data
DB_IMAGE=public.ecr.aws/supabase/postgres:17.6.1.167
DB_HOST=127.0.0.1
DB_PORT=55440
DB_NAME=inventory_dev
DB_USER=postgres
DB_PASSWORD=<generated>
```

## 10. Start the database (Docker)

```bash
./tools/db up
```

What happens:

1. `.env` is created from `.env.example` (first time only).
2. Docker starts the container described in `docker-compose.yml`.
3. The script waits until PostgreSQL is healthy.
4. The database `<db-name>` is created if it is missing.

**Check:** the last line is `PostgreSQL ready at 127.0.0.1:<db-port>, database <db-name> (container <project>-postgres).`

Then look inside:

```bash
./tools/db status     # <project>-postgres ... Up ... (healthy)
./tools/db shell      # opens psql inside the container
```

Inside psql: type `\l` to list databases (you should see `<db-name>`), then `\q` to quit. If the screen shows `(END)`, press `q`.

**Changed a value after the first start?** Container name, volume and password are fixed when the container is first created. Run `./tools/db reset` (deletes the data) so Docker recreates it with the new values. A changed `DB_PORT` only needs `./tools/db up` again.

## 11. Check the server reaches its settings

The server reads the same `.env` as Docker, so both always agree on port, database and password. In the server folder:

```bash
<path-to-root>/tools/sdk dart analyze      # No issues found!
```

On first use the server also creates a git-ignored `.local/` folder with a local development token.

## 12. Daily commands

| You want to | Run (from the project root) |
|---|---|
| Start the database | `./tools/db up` |
| Stop the database (data is kept) | `./tools/db down` |
| See whether it is running | `./tools/db status` |
| Open the database console | `./tools/db shell` |
| Delete all data and start fresh | `./tools/db reset` (asks first) |
| Run Dart / Flutter | `./tools/sdk dart ...` / `./tools/sdk flutter ...` |
| Stop this project's running servers | `./tools/stop` |

## 13. Files that are NOT in git (and why)

| File / folder | Why it is ignored | How you get it |
|---|---|---|
| `.env` | Contains the database password | `./tools/db up` creates it |
| `server/.local/` | Contains the local dev token | Created on first server use |
| `.fvm/` | Link to the 1.5 GB Flutter SDK | `fvm use <version>` |
| `.dart_tool/`, `build/` | Generated by Dart and Flutter | `dart pub get` / builds |

## 14. Troubleshooting

| Problem | Cause | Fix |
|---|---|---|
| `fvm: command not found` | PATH not reloaded | Open a new terminal or run `source ~/.bashrc` |
| `Flutter ... is required at .../.fvm/flutter_sdk` | Flutter not linked | Run `fvm install` and `fvm use <version>` in the project root |
| `authorization failed` during `pub get` | Vyuh token missing or not pro tier | Step 7, or use `--offline` |
| `permission denied` from docker | User not in the docker group | `sudo usermod -aG docker $USER`, then log in again |
| `port is already allocated` | `<db-port>` used by something else | Choose another `DB_PORT` in `.env`, then `./tools/db up` |
| `container name ... is already in use` | Another project uses the same `DB_CONTAINER` | Choose a unique `DB_CONTAINER` and `DB_VOLUME` |
| `Set DB_PASSWORD in .env` | `.env` has no password | Delete `.env` and run `./tools/db up` again |
| `Missing .env` from the server | Database never set up | Run `./tools/db up` from the project root |
| psql shows `(END)` | Output opened in a pager | Press `q` |

## 15. Starting a brand-new project with this setup

1. Copy `docker-compose.yml`, `.env.example`, `tools/db`, `tools/sdk` and `tools/stop` into the new repository.
2. Create `.fvmrc` with the Flutter version you want, for example `{"flutter": "3.50.0"}`.
3. Edit `.env.example` with the new project's values (step 9). Each project needs its own `DB_PORT`, `DB_CONTAINER` and `DB_VOLUME`.
4. Add `.env`, `.fvm/` and `server/.local/` to `.gitignore`.
5. Follow steps 5 to 11.
