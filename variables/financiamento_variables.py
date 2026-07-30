"""Variáveis específicas do módulo de financiamento."""

import os
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MOCK_SIMULACAO = ROOT / "data" / "mock" / "simulacao_credito.html"

SIMULACAO_CREDITO_URL = os.getenv(
    "SIMULACAO_CREDITO_URL",
    MOCK_SIMULACAO.resolve().as_uri(),
)
RENDA_MINIMA_ELEGIBILIDADE = int(os.getenv("RENDA_MINIMA_ELEGIBILIDADE", "3000"))
