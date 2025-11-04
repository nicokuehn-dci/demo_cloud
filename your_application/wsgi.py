"""WSGI shim for compatibility with placeholder commands.

When a deploy platform runs `gunicorn your_application.wsgi` this module
exposes the `application` WSGI callable by reusing the project's
`core.wsgi.application`.
"""

from core.wsgi import application

# Expose as module-level name expected by Gunicorn
__all__ = ["application"]
