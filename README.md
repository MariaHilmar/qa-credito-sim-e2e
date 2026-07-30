# QA Crédito Sim E2E

Automação web **BDD** (Robot Framework + Selenium) para elegibilidade em simulação de crédito: Page Objects, massa de dados em JSON com rastreio a requisitos, mock HTML local e pipeline CI.

[![CI](https://github.com/MariaHilmar/qa-credito-sim-e2e/actions/workflows/ci.yml/badge.svg)](https://github.com/MariaHilmar/qa-credito-sim-e2e/actions/workflows/ci.yml)
![Robot Framework](https://img.shields.io/badge/Robot_Framework-7%2B-blue)
![Selenium](https://img.shields.io/badge/Selenium-4-green)

> Projeto de **portfólio QA** (prefixo `qa-*`). Mock educacional de simulação de crédito - não é sistema de instituição financeira.

---

## Visão geral

| Aspecto | Detalhe |
|---------|---------|
| Domínio | Elegibilidade em simulação de crédito (CPF + renda) |
| Stack | Robot Framework 7, SeleniumLibrary, Python 3.10+ |
| Padrões | BDD (Dado/Quando/E/Então), Page Object, dados externalizados |
| Massa | `data/test_data.json` - 5 cenários (`CT-FIN-001` a `CT-FIN-005`) |
| Rastreio | Tags `REQ-FIN-*` + [docs/requisitos.md](docs/requisitos.md) |
| Mock | `data/mock/simulacao_credito.html` - local sem ambiente externo |
| Demo | `run_demo_financiamento.ps1` - navegador visível para apresentação |

---

## Estrutura

```
qa-credito-sim-e2e/
├── docs/
│   └── requisitos.md         # Regras de negócio + Gherkin + rastreio
├── tests/
│   ├── exemplo/              # Smoke sem browser
│   ├── web/                  # Exemplo Selenium (the-internet)
│   └── financiamento/        # Suíte principal (5 CTs)
├── resources/
│   ├── selenium/             # Setup/teardown do navegador
│   ├── pages/                # Page Objects + keywords BDD
│   └── common.robot
├── data/
│   ├── test_data.json        # Massa de dados + IDs de caso/requisito
│   └── mock/                 # HTML local (mock Caixa)
├── libraries/
├── variables/
├── scripts/
│   ├── run_tests.sh
│   └── serve_mock.ps1        # HTTP local do mock (porta 8765)
├── .github/workflows/ci.yml
├── .gitlab-ci.yml
├── run_tests.ps1
├── run_demo_financiamento.ps1
└── requirements.txt
```

---

## Pré-requisitos

- Python 3.10+
- Google Chrome (testes locais com Selenium)

## Instalação

```powershell
cd D:\git-portfolio\qa-credito-sim-e2e
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt

copy .env.local.example .env.local
```

## Executar testes

```powershell
# Todos os testes
.\run_tests.ps1

# Smoke (sem browser)
.\run_tests.ps1 -Tags smoke -Suite tests/exemplo/

# Suíte principal - 5 casos CT-FIN-*
.\run_tests.ps1 -Tags financiamento -Suite tests/financiamento/

# Demo visual (Chrome visível, digitação lenta)
.\run_demo_financiamento.ps1

# Linux / macOS
./scripts/run_tests.sh smoke tests/exemplo/
./scripts/run_tests.sh financiamento tests/financiamento/
```

Relatórios Robot: `results/report.html` e `results/log.html`.

### Mock via HTTP (opcional / CI)

Por padrão o mock usa `file://` (auto-detectado). No CI, o mock é servido em HTTP porque `file://` não funciona de forma confiável com browser remoto.

```powershell
# Terminal 1
.\scripts\serve_mock.ps1

# Terminal 2
$env:SIMULACAO_CREDITO_URL = "http://127.0.0.1:8765/mock/simulacao_credito.html"
.\run_tests.ps1 -Tags financiamento -Suite tests/financiamento/
```

## Selenium

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `SIMULACAO_CREDITO_URL` | `file://.../data/mock/simulacao_credito.html` | Mock local (auto) |
| `BASE_URL` | `https://the-internet.herokuapp.com` | URL dos testes web de exemplo |
| `BROWSER` | `chrome` | Browser |
| `HEADLESS` | `true` | Headless local |
| `SELENIUM_REMOTE_URL` | *(vazio)* | Grid remoto (opcional) |
| `CHROME_BINARY` | *(vazio)* | Ex.: `/usr/bin/chromium` no CI Debian |
| `TEST_TIMEOUT` | `10` | Timeout (segundos) |
| `IMPLICIT_WAIT` | `5` | Wait implícito (segundos) |

**Local / CI GitHub:** Chrome headless no runner + mock HTTP em `127.0.0.1:8765`.

## CI/CD

| Job | Descrição |
|-----|-----------|
| `smoke` | Testes rápidos sem browser (tag `smoke`) |
| `e2e` | Selenium headless + mock HTTP (tag `web`, inclui `financiamento`) |

Artifacts: `log.html`, `report.html`, JUnit (`results/junit.xml`).

## Tags

| Tag | Uso |
|-----|-----|
| `smoke` | Validação rápida sem browser |
| `web` | Requer Selenium |
| `financiamento` | Suíte de simulação de crédito |
| `REQ-FIN-001` / `002` / `003` | Rastreio a requisito de negócio |

## Documentação

- [Requisitos e cenários BDD](docs/requisitos.md)

## Portfólio

Parte da família de repositórios `qa-*` no [GitHub MariaHilmar](https://github.com/MariaHilmar). Produtos de referência: [paycore](https://github.com/MariaHilmar/paycore), [juris-sync](https://github.com/MariaHilmar/juris-sync).
