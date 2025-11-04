<<<<<<< HEAD
# demo_cloud
=======
# demo — Django app (back_and_front)

Short, readable instructions to run and develop this project locally or with Docker.
# demo — Django app (back_and_front)

Short, readable instructions to run and develop this project locally or with Docker.

## What this repo contains
- Django project `core/` (Django 5.2.7)
- Django app `posts/` (models, serializers, views, migrations)
- `Dockerfile` and `docker-compose.yml` for containerized development
- `nginx/` config used for reverse proxy/static serving
- `requirements.txt` for Python dependencies

## Quick start — local (recommended for quick dev/testing)
These steps use the included virtualenv (if present) or a new venv.

1. Activate venv (if available):

```bash
source venv/bin/activate
```

2. Install dependencies (if you haven't already):

```bash
pip install -r requirements.txt
```

3. Optional: use the included SQLite DB for quick local tests (no Postgres required).
   The repo contains `db.sqlite3` and the default settings will fall back to localhost Postgres unless env vars are set. To run with SQLite, set these env vars in the same shell before running the server:

```bash
# ensure Django will use the local sqlite file by unsetting Postgres vars
unset POSTGRES_DB POSTGRES_USER POSTGRES_PASSWORD DB_HOST POSTGRES_PORT
```

4. Run migrations (or skip if using the included `db.sqlite3`):

```bash
python3 manage.py migrate
```

5. Start dev server:

```bash
python3 manage.py runserver
```

Open http://127.0.0.1:8000

## Using Docker (recommended for parity with production)

1. Ensure Docker and Docker Compose are installed.
2. Create a `.env` file or set environment variables expected by `docker-compose.yml` (POSTGRES_DB, POSTGRES_USER, POSTGRES_PASSWORD, etc.).
3. Start services:

```bash
docker-compose up -d
```

4. Check logs:

```bash
docker-compose logs -f
```

When running in Docker the DB host inside the network is typically `db`. The Django settings in `core/settings.py` read `DB_HOST` and default to `127.0.0.1` for local runs, so when using Docker set `DB_HOST=db`.

## Environment variables (important)
- POSTGRES_DB — database name (for Postgres)
- POSTGRES_USER — DB user
- POSTGRES_PASSWORD — DB password
- DB_HOST — Postgres host (set to `db` when using docker-compose)
- POSTGRES_PORT — default `5432`
- DJANGO_SECRET_KEY — (optional) override secret key

## Pushing changes
You're currently working on branch `back_and_front`. To push additional commits:

```bash
git add .
git commit -m "Describe your change"
git push
```

To create a pull request, visit the repository on GitHub (the `back_and_front` branch already exists on origin).

## Notes
- The repo includes `requirements.txt` and a `venv/` folder (local virtualenv). If you prefer a fresh venv: `python3 -m venv .venv && source .venv/bin/activate`.
- I added `docs/nginx-practical-guide.md` with a short summary of a Medium Nginx guide.

If you want, I can also:
- Add a short script to create a `.env.example` from current settings
- Add a SQLite fallback in `core/settings.py` that only activates in `DEBUG` when Postgres env vars are missing

---
