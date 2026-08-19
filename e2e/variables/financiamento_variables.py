"""Variáveis específicas do módulo de financiamento."""

import os
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
APP_PAGE = REPO_ROOT / "app" / "simulacao_credito.html"

SIMULACAO_CREDITO_URL = os.getenv(
    "SIMULACAO_CREDITO_URL",
    APP_PAGE.resolve().as_uri(),
)
RENDA_MINIMA_ELEGIBILIDADE = int(os.getenv("RENDA_MINIMA_ELEGIBILIDADE", "3000"))
