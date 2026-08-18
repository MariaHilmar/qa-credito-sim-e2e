# QA Crédito Sim E2E

Projeto de estudo: automação web com Robot Framework e Selenium em um mock HTML de
simulação de crédito (CPF + renda). Não é sistema de instituição financeira.

[![CI](https://github.com/MariaHilmar/qa-credito-sim-e2e/actions/workflows/ci.yml/badge.svg)](https://github.com/MariaHilmar/qa-credito-sim-e2e/actions/workflows/ci.yml)

## Pré-requisitos

- Python 3.10+
- Google Chrome (execução local com Selenium)

## Instalação

```powershell
cd qa-credito-sim-e2e
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
copy .env.local.example .env.local
```

Linux / macOS: `python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt`

## Executar os testes

Os casos estão em `tests/financiamento/` (massa em `data/test_data.json`). Regras do mock:
[docs/requisitos.md](docs/requisitos.md).

```powershell
# Suíte completa (Chrome headless por padrão)
.\run_tests.ps1 -Suite tests/financiamento/

# Demo com navegador visível
.\run_demo_financiamento.ps1

# Linux / macOS
./scripts/run_tests.sh financiamento tests/financiamento/
```

Relatórios: `results/report.html` e `results/log.html`.

### Mock via HTTP (opcional)

Por padrão o mock abre em `file://`. No CI (e se quiser HTTP local):

```powershell
.\scripts\serve_mock.ps1
$env:SIMULACAO_CREDITO_URL = "http://127.0.0.1:8765/mock/simulacao_credito.html"
.\run_tests.ps1 -Suite tests/financiamento/
```

## Variáveis de ambiente

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `SIMULACAO_CREDITO_URL` | `file://.../data/mock/simulacao_credito.html` | Página do mock |
| `BROWSER` | `chrome` | Navegador |
| `HEADLESS` | `true` | Headless local |
| `SELENIUM_REMOTE_URL` | *(vazio)* | Grid remoto, se usar |
| `CHROME_BINARY` | *(vazio)* | Ex.: `/usr/bin/chromium` no CI |
| `TEST_TIMEOUT` | `10` | Timeout (segundos) |
| `IMPLICIT_WAIT` | `5` | Wait implícito (segundos) |

Definições em `.env.local` (veja `.env.local.example`).

## Estrutura

```
qa-credito-sim-e2e/
├── docs/requisitos.md
├── tests/financiamento/     # Casos CT-FIN-*
├── resources/pages/         # Page Object e keywords
├── resources/selenium/      # Browser
├── data/test_data.json
├── data/mock/               # HTML local
├── variables/
├── scripts/
├── .github/workflows/ci.yml
└── .gitlab-ci.yml
```

## CI

Job `e2e`: Chrome headless + mock HTTP em `127.0.0.1:8765` + tag `financiamento`.
Artefatos: `log.html`, `report.html`, `results/junit.xml`.
