"""Variáveis globais do projeto."""

import os

ENVIRONMENT = os.getenv("TEST_ENV", "local")
BASE_URL = os.getenv("BASE_URL", "https://the-internet.herokuapp.com")
TIMEOUT = int(os.getenv("TEST_TIMEOUT", "10"))
IMPLICIT_WAIT = int(os.getenv("IMPLICIT_WAIT", "5"))

BROWSER = os.getenv("BROWSER", "chrome")
HEADLESS = os.getenv("HEADLESS", "true").lower() in ("1", "true", "yes")
SELENIUM_REMOTE_URL = os.getenv("SELENIUM_REMOTE_URL", "")
SELENIUM_SPEED = os.getenv("SELENIUM_SPEED", "")
# Ex.: /usr/bin/chromium no CI Debian/GitLab
CHROME_BINARY = os.getenv("CHROME_BINARY", "")
