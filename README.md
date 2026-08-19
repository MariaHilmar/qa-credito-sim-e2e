# QA Crédito Sim E2E

Projeto de estudo: **sistema** (formulário HTML de simulação de crédito) e **automação E2E**
(Robot Framework + Selenium) em árvores separadas, como em produto. Não é sistema de
instituição financeira.

[![CI](https://github.com/MariaHilmar/qa-credito-sim-e2e/actions/workflows/ci.yml/badge.svg)](https://github.com/MariaHilmar/qa-credito-sim-e2e/actions/workflows/ci.yml)

| Pasta | Papel |
|-------|--------|
| `app/` | Sistema sob teste (SUT). A automação só fala com a URL. |
| `e2e/` | Automação black-box: Page Object, keywords BDD, massa e suíte CT-FIN. |

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

Casos em `e2e/tests/financiamento/` (massa em `e2e/data/test_data.json`). Regras do sistema:
[docs/requisitos.md](docs/requisitos.md).

```powershell
# Suíte completa (Chrome headless por padrão)
.\scripts\run_tests.ps1 -Suite e2e/tests/financiamento/

# Demo com navegador visível
.\scripts\run_demo_financiamento.ps1

# Linux / macOS
./scripts/run_tests.sh financiamento e2e/tests/financiamento/
```

Relatórios: `results/report.html` e `results/log.html`.

### Sistema via HTTP (CI e Grid)

Por padrão a automação abre `app/simulacao_credito.html` em `file://`. No CI (e se quiser HTTP):

```powershell
.\scripts\serve_app.ps1
$env:SIMULACAO_CREDITO_URL = "http://127.0.0.1:8765/simulacao_credito.html"
.\scripts\run_tests.ps1 -Suite e2e/tests/financiamento/
```

## Variáveis de ambiente

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `SIMULACAO_CREDITO_URL` | `file://.../app/simulacao_credito.html` | URL do sistema |
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
├── app/                              # SISTEMA
│   └── simulacao_credito.html
├── e2e/                              # AUTOMAÇÃO
│   ├── tests/financiamento/          # Casos CT-FIN-*
│   ├── resources/pages/              # Page Object
│   ├── resources/keywords/           # Dado / Quando / Então
│   ├── resources/selenium/           # Browser
│   ├── data/test_data.json
│   └── variables/
├── docs/requisitos.md
├── scripts/
├── .github/workflows/ci.yml
└── .gitlab-ci.yml
```

## CI

Job `e2e`: sobe `app/` em HTTP (`127.0.0.1:8765`) e roda Robot em `e2e/` (Chrome headless, tag `financiamento`).
Artefatos: `log.html`, `report.html`, `results/junit.xml`.
