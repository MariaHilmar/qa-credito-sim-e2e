# Requisitos - Simulação de Crédito (Mock QA)

> Documento canônico de requisitos e cenários BDD para a suíte
> `tests/financiamento/elegibilidade.robot`. O mock em
> `data/mock/simulacao_credito.html` implementa estas regras para execução
> reproduzível sem ambiente externo.

## 1. Objetivo

Validar a **elegibilidade** de um cliente na simulação de crédito imobiliário
com base em CPF (dígitos verificadores) e renda mensal bruta mínima.

## 2. Regras de negócio

| ID | Regra |
|----|--------|
| RN01 | CPF deve ter 11 dígitos e dígitos verificadores válidos |
| RN02 | Renda mínima de elegibilidade: **R$ 3.000,00** |
| RN03 | Renda exatamente no limite (R$ 3.000,00) é elegível |
| RN04 | Renda abaixo do limite (mesmo R$ 2.999,99) é negada |

## 3. Requisitos rastreados

| Requisito | Descrição | Casos |
|-----------|-----------|-------|
| REQ-FIN-001 | Elegibilidade por renda mínima | CT-FIN-001, CT-FIN-002, CT-FIN-004 |
| REQ-FIN-002 | Validação de CPF | CT-FIN-003 |
| REQ-FIN-003 | Limite inferior estrito (borda) | CT-FIN-005 |

## 4. Mensagens esperadas (contrato do mock)

| Resultado | Mensagem |
|-----------|----------|
| `aprovado` | Parabéns! Você está elegível para simulação de crédito. |
| `negado_renda` | Renda insuficiente para o produto selecionado. |
| `negado_cpf` | CPF inválido ou não encontrado. |

## 5. Cenários BDD (Gherkin)

```gherkin
# language: pt
Funcionalidade: Elegibilidade na simulação de crédito
  Como analista de crédito
  Quero validar CPF e renda na simulação
  Para decidir se o cliente está elegível ao produto

  Contexto:
    Dado que estou na página de simulação de crédito

  @REQ-FIN-001 @CT-FIN-001
  Cenário: Renda acima do mínimo deve ser elegível
    Quando preencho CPF válido "52998224725" e renda "8500.00"
    E solicito a simulação de crédito
    Então o resultado da simulação deve ser "aprovado"

  @REQ-FIN-001 @CT-FIN-002
  Cenário: Renda abaixo do mínimo deve ser negada
    Quando preencho CPF válido "52998224725" e renda "2500.00"
    E solicito a simulação de crédito
    Então o resultado da simulação deve ser "negado_renda"

  @REQ-FIN-002 @CT-FIN-003
  Cenário: CPF inválido deve impedir a simulação
    Quando preencho CPF inválido "12345678900" e renda "6000.00"
    E solicito a simulação de crédito
    Então o resultado da simulação deve ser "negado_cpf"

  @REQ-FIN-001 @CT-FIN-004
  Cenário: Renda exatamente no limite deve ser elegível
    Quando preencho CPF válido "11144477735" e renda "3000.00"
    E solicito a simulação de crédito
    Então o resultado da simulação deve ser "aprovado"

  @REQ-FIN-003 @CT-FIN-005
  Cenário: Renda um centavo abaixo do limite deve ser negada
    Quando preencho CPF válido "11144477735" e renda "2999.99"
    E solicito a simulação de crédito
    Então o resultado da simulação deve ser "negado_renda"
```

## 6. Rastreabilidade

| Artefato | Caminho |
|----------|---------|
| Massa de dados | `data/test_data.json` (`simulacao_credito`) |
| Keywords BDD | `resources/pages/financiamento_page.robot` |
| Suíte Robot | `tests/financiamento/elegibilidade.robot` |
| Mock HTML | `data/mock/simulacao_credito.html` |

## 7. Ambiente de execução

| Ambiente | URL do mock |
|----------|-------------|
| Local (padrão) | `file://.../data/mock/simulacao_credito.html` (auto) |
| Local / CI com HTTP | `http://127.0.0.1:8765/mock/simulacao_credito.html` |
| SIT/UAT | Definir `SIMULACAO_CREDITO_URL` no `.env.local` |

No CI, o mock é servido via `python -m http.server` porque `file://` não é
confiável com browser remoto / Grid.
