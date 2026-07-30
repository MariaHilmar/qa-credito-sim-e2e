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
| Rastreio | Tags `REQ-FIN-*` ligadas a requisitos de negócio |
| Mock | `data/mock/simulacao_credito.html` - execução local sem ambiente externo |
| Demo | `run_demo_financiamento.ps1` - navegador visível para apresentação |

---

## Estrutura

```
qa-credito-sim-e2e/
├── tests/
│   ├── exemplo/              # Smoke sem browser
│   ├── web/                  # Exemplo Selenium (the-internet)
│   └── financiamento/        # Suíte principal (simulação de crédito)
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
│   └── run_tests.sh
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

# Suíte principal - simulação de crédito (5 cenários no JSON)
.\run_tests.ps1 -Tags financiamento -Suite tests/financiamento/

# Demo visual (Chrome visível, digitação lenta)
.\run_demo_financiamento.ps1

# Linux / macOS
./scripts/run_tests.sh smoke tests/exemplo/
./scripts/run_tests.sh financiamento tests/financiamento/
```

Relatórios Robot: `results/report.html` e `results/log.html`.

## Selenium

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `SIMULACAO_CREDITO_URL` | `file://.../data/mock/simulacao_credito.html` | Mock local (auto-detectado) |
| `BASE_URL` | `https://the-internet.herokuapp.com` | URL para testes web de exemplo |
| `BROWSER` | `chrome` | Browser |
| `HEADLESS` | `true` | Headless local |
| `SELENIUM_REMOTE_URL` | *(vazio)* | Grid remoto (CI) |
| `TEST_TIMEOUT` | `10` | Timeout (segundos) |
| `IMPLICIT_WAIT` | `5` | Wait implícito (segundos) |

**Local:** com `SELENIUM_REMOTE_URL` vazio, Selenium 4 gerencia o ChromeDriver.

**CI:** jobs E2E conectam ao `selenium/standalone-chrome` via `SELENIUM_REMOTE_URL`.

## CI/CD

GitHub Actions (padrão do portfólio) e GitLab CI (opcional):

| Job | Descrição |
|-----|-----------|
| `smoke` | Testes rápidos sem browser (tag `smoke`) |
| `e2e` | Selenium + mock local (tags `web` / `financiamento`) |

Artifacts: `log.html`, `report.html`, JUnit (`results/junit.xml`).

## Tags

| Tag | Uso |
|-----|-----|
| `smoke` | Validação rápida sem browser |
| `web` | Requer Selenium |
| `financiamento` | Suíte de simulação de crédito |
| `REQ-FIN-001` | Rastreio a requisito de negócio |

## Portfólio

Parte da família de repositórios `qa-*` no [GitHub MariaHilmar](https://github.com/MariaHilmar). Produtos de referência: [paycore](https://github.com/MariaHilmar/paycore), [juris-sync](https://github.com/MariaHilmar/juris-sync).
