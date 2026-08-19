# Requisitos - Simulação de Crédito (mock local)

Documento das regras usadas pelo sistema `app/simulacao_credito.html` e pela suíte
`e2e/tests/financiamento/elegibilidade.robot`.

Projeto de estudo. O HTML não replica sistema de instituição financeira.

## 1. Objetivo

Exercitar automação web (Robot Framework + Selenium) num formulário de elegibilidade
com CPF e renda mensal bruta.

## 2. Regras do mock

| ID | Regra |
|----|--------|
| RN01 | CPF deve ter 11 dígitos e dígitos verificadores válidos |
| RN02 | Renda mínima de elegibilidade: **R$ 3.000,00** |
| RN03 | Renda exatamente no limite (R$ 3.000,00) é elegível |
| RN04 | Renda abaixo do limite (mesmo R$ 2.999,99) é negada |
| RN05 | CPF ou renda em branco pedem preenchimento antes das demais validações |
| RN06 | Renda aceita formato `3000.00` ou `3.000,00` |

## 3. Requisitos rastreados

| Requisito | Descrição | Casos |
|-----------|-----------|-------|
| REQ-FIN-001 | Elegibilidade por renda mínima | CT-FIN-001, CT-FIN-002, CT-FIN-004, CT-FIN-008 |
| REQ-FIN-002 | Validação de CPF | CT-FIN-003 |
| REQ-FIN-003 | Limite inferior estrito (borda) | CT-FIN-005 |
| REQ-FIN-004 | Campos obrigatórios | CT-FIN-006, CT-FIN-007 |

## 4. Mensagens esperadas

| Resultado | Mensagem |
|-----------|----------|
| `aprovado` | Parabéns! Você está elegível para simulação de crédito. |
| `negado_renda` | Renda insuficiente para o produto selecionado. |
| `negado_cpf` | CPF inválido ou não encontrado. |
| `campo_cpf_vazio` | Informe o CPF. |
| `campo_renda_vazio` | Informe a renda mensal. |

## 5. Cenários (Gherkin)

```gherkin
# language: pt
Funcionalidade: Elegibilidade na simulação de crédito
  Como usuário do simulador
  Quero validar CPF e renda no mock
  Para ver se a elegibilidade está correta

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

  @REQ-FIN-004 @CT-FIN-006
  Cenário: CPF vazio deve pedir preenchimento
    Quando deixo o CPF vazio e preencho renda "6000.00"
    E solicito a simulação de crédito
    Então o resultado da simulação deve ser "campo_cpf_vazio"

  @REQ-FIN-004 @CT-FIN-007
  Cenário: Renda vazia deve pedir preenchimento
    Quando preencho CPF válido "52998224725" e deixo a renda vazia
    E solicito a simulação de crédito
    Então o resultado da simulação deve ser "campo_renda_vazio"

  @REQ-FIN-001 @CT-FIN-008
  Cenário: Renda no formato brasileiro no limite deve ser elegível
    Quando preencho CPF válido "11144477735" e renda "3.000,00"
    E solicito a simulação de crédito
    Então o resultado da simulação deve ser "aprovado"
```

## 6. Arquivos relacionados

| Artefato | Caminho |
|----------|---------|
| Sistema (SUT) | `app/simulacao_credito.html` |
| Massa de dados | `e2e/data/test_data.json` |
| Page Object | `e2e/resources/pages/financiamento_page.robot` |
| Keywords BDD | `e2e/resources/keywords/simulacao_credito_keywords.robot` |
| Suíte Robot | `e2e/tests/financiamento/elegibilidade.robot` |

## 7. Como apontar o mock

| Situação | URL |
|----------|-----|
| Padrão local | `file://.../app/simulacao_credito.html` (automático) |
| Servidor HTTP | `http://127.0.0.1:8765/simulacao_credito.html` (`SIMULACAO_CREDITO_URL`) |

No CI o sistema sobe com `python -m http.server --directory app` porque `file://` falha com browser remoto. A automação não lê o HTML do disco: só a URL.
