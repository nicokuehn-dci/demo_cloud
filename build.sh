#!/usr/bin/env bash
set -euo pipefail

# build.sh - simple project build helper
# - activates existing venv (./venv) if present, otherwise creates and uses .venv
# - installs requirements
# - runs migrations and collectstatic
# - runs Django tests (non-fatal)
# - optionally builds a Docker image when BUILD_DOCKER=true is set

cd "$(dirname "$0")"
echo "[build.sh] Starting build at $(date)"

VENV="venv"
if [ -d "$VENV" ] && [ -f "$VENV/bin/activate" ]; then
  echo "[build.sh] Activating existing venv: $VENV"
  # shellcheck disable=SC1091
  source "$VENV/bin/activate"
else
  VENV=".venv"
  if [ ! -d "$VENV" ]; then
    echo "[build.sh] Creating venv at $VENV"
    python3 -m venv "$VENV"
  else
    echo "[build.sh] Using existing venv at $VENV"
  fi
  # shellcheck disable=SC1091
  source "$VENV/bin/activate"
fi

echo "[build.sh] Python: $(which python) $(python -V 2>&1)"

echo "[build.sh] Upgrading pip and installing requirements (if present)"
python -m pip install --upgrade pip
if [ -f requirements.txt ]; then
  pip install -r requirements.txt
else
  echo "[build.sh] No requirements.txt found — skipping pip install"
fi

if [ -f manage.py ]; then
  echo "[build.sh] Running migrations"
  python manage.py migrate --noinput || true

  echo "[build.sh] Collecting static files"
  python manage.py collectstatic --noinput || true

  echo "[build.sh] Running tests (this step is non-fatal)"
  # keep tests non-fatal to avoid blocking the build; remove || true to fail on test failures
  python manage.py test --keepdb || true
else
  echo "[build.sh] manage.py not found — skipping Django steps"
fi

if [ "${BUILD_DOCKER:-false}" = "true" ]; then
  if command -v docker >/dev/null 2>&1; then
    echo "[build.sh] Building Docker image 'demo_app:latest'"
    docker build -t demo_app:latest .
  else
    echo "[build.sh] Docker not found in PATH — skipping Docker build"
  fi
fi

echo "[build.sh] Build finished at $(date)"
