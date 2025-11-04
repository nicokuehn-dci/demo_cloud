"""Compatibility package to satisfy placeholder start commands.

This package provides a `your_application.wsgi` module so services that
use the default placeholder `gunicorn your_application.wsgi` will succeed
and forward to the real Django WSGI application (`core.wsgi.application`).
"""

__all__ = ["wsgi"]
