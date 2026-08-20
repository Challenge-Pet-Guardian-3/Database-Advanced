# 📋 Backlog Master Azure Boards — Sprint 3: Database Advanced
> **Projeto:** Pet Guardian (Challenge Clyvo 2026 - 2º Semestre)  
> **Disciplina:** Mastering Relational and Non-Relational Database (FIAP - 2TDSPG)  
> **Referência Oficial:** Manual do Challenge 2026 — Páginas 23 a 30  
> **Formato:** Scrum / Azure DevOps (Azure Boards)  

---

## 🎯 1. Diagnóstico dos Requisitos da Sprint 3 (Páginas 23 a 30)

Com base nas especificações das páginas 23 a 30 do manual oficial, a Sprint 3 exige a evolução da base de dados relacional (Oracle) com foco em **lógica procedural avançada, tratamento rigoroso de exceções, auditoria DML e manipulação manual de dados**:

| Componente | Requisito Oficial | Pontuação | Regras Críticas / Anti-Padrões |
| :--- | :--- | :---: | :--- |
| **Procedimento 1** | JOIN entre 2+ tabelas + exibição em JSON (string) via Função 1 | **30 pts** (dividido c/ Proc 2) | Mínimo 5 registros válidos por tabela; Tratar **no mínimo 3 exceções distintas** (`EXCEPTION WHEN`). |
| **Procedimento 2** | Tabela de fatos com 2 colunas categóricas e 1 numérica. Subtotal por categoria + Total Geral no formato tabular especificado | *(incluso acima)* | **PROIBIDO** uso de `ROLLUP`, `CUBE`, `GROUPING SETS`, `GROUPING`. Somatório 100% manual via PL/SQL. Tratar **3 exceções distintas**. |
| **Função 1** | Recebe dados relacionais e retorna string JSON formatada manualmente | **30 pts** (dividido c/ Func 2) | **PROIBIDO** funções built-in (`TO_JSON`, `JSON_OBJECT`, `JSON_VALUE`, etc. Desconto de -10 pts por ocorrência!). Tratar **3 exceções distintas**. |
| **Função 2** | Substitui processo lógico de negócio (validação de regras, cálculo de pontuação/descontos, etc.) | *(incluso acima)* | Regra alinhada ao domínio PetGuardian. Tratar **no mínimo 3 exceções distintas**. |
| **Trigger DML** | Trigger de auditoria DML (`AFTER INSERT OR UPDATE OR DELETE`) | **30 pts** | Gravar em tabela de auditoria: Usuário, Tipo de Operação, Data/Hora, Valores Anteriores (`:OLD`) e Valores Novos (`:NEW`). |
| **Documentação & Entregáveis** | Arquivo PDF (`2TDSPG_2026_Proj_BD.pdf`) e Arquivo SQL (`2TDSPG_2026_CodigoSql_PetGuardian.sql`) | **10 pts** | Capa c/ integrantes em ordem alfabética; Prints de execução com sucesso E de **erros tratados**; Código 100% comentado. |

---

## 🗂️ 2. Mapeamento e Ciclo de Vida dos Arquivos do Repositório

### ❌ Arquivos Obsoletos da Sprint 1 a serem Removidos / Substituídos
| Arquivo Atual | Motivo da Remoção / Ação |
| :--- | :--- |
| `06_consulta_valor_anterior_proximo.sql` | **APAGAR:** Script com funções analíticas `LAG` e `LEAD`, requisito exclusivo da Sprint 1 que não faz parte do escopo avaliativo da Sprint 3. |
| `05_consultas_joins.sql` | **APAGAR / SUBSTITUIR:** Consultas soltas de joins da Sprint 1. O Procedimento 1 da Sprint 3 agora encapsula a lógica de JOIN com saída JSON. |
| `07_relatorios_cursors.sql` | **APAGAR / SUBSTITUIR:** Relatórios em blocos anônimos da Sprint 1 serão substituídos pelos novos Procedimentos e Funções estruturados. |
| `challenge_clyvo_completo.sql` | **SUBSTITUIR:** Script unificado antigo da Sprint 1. Será substituído pelo script consolidado oficial da Sprint 3 (`2TDSPG_2026_CodigoSql_PetGuardian.sql`). |

---

### 🔄 Arquivos a Manter e Refatorar
| Arquivo | Ação de Refatoração |
| :--- | :--- |
| `01_ddl_tabelas.sql` | **MANTER E REVISAR:** Manter as 16 tabelas de negócio do PetGuardian em 3FN, garantindo integridade referencial, constraints e índices. |
| `02_ddl_logs.sql` | **REFATORAR E EXPANDIR:** Renomear/expandir para incluir a nova tabela `TAB_AUDITORIA_DML` (para a Trigger de auditoria) além de manter a tabela `LOG_ERROS` para registro de exceções. |
| `03_procedures_carga.sql` | **REVISAR:** Garantir que todas as tabelas recebam no mínimo **5 registros válidos e consistentes** para permitir os cálculos de subtotal e total geral. |
| `04_blocos_anonimos_insercao.sql` | **MANTER:** Bloco de execução da carga de dados via procedures. |
| `run_all.sql` | **ATUALIZAR:** Orquestrador mestre atualizado para rodar todos os novos scripts da Sprint 3 na ordem correta de dependências. |
| `README.md` | **ATUALIZAR:** Documentar os novos requisitos da Sprint 3, instruções de execução e links atualizados. |

---

### ✨ Novos Arquivos a Criar na Sprint 3
| Novo Arquivo | Finalidade |
| :--- | :--- |
| `05_funcoes_plsql.sql` | Implementação da **Função 1** (JSON manual) e **Função 2** (regra de negócio), ambas com 3 tratamentos de exceção. |
| `06_procedimentos_plsql.sql` | Implementação do **Procedimento 1** (JOIN + JSON) e **Procedimento 2** (Matriz de Subtotal/Total sem ROLLUP), ambos com 3 tratamentos de exceção. |
| `07_trigger_auditoria.sql` | Implementação do DDL da tabela de auditoria e da **Trigger DML** (`AFTER INSERT OR UPDATE OR DELETE`). |
| `08_testes_validacao_excecoes.sql` | Scripts de teste para demonstrar casos felizes e disparar intencionalmente as exceções tratadas (geração de prints para o PDF). |
| `2TDSPG_2026_CodigoSql_PetGuardian.sql` | Script consolidado oficial contendo DDL, Cargas, Funções, Procedures e Triggers em arquivo único para entrega. |
| `docs/2TDSPG_2026_Proj_BD.pdf` | Documento PDF final com capa em ordem alfabética, prints das execuções, prints de todas as exceções tratadas e código comentado. |

---

## 👑 3. Estrutura do Backlog no Azure Boards (Scrum)

```
[EPIC-03] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON
│
├── [FEAT-01] Refatoração da Base de Dados, Auditoria DML e Higienização de Arquivos
│   ├── [PBI-01] Auditoria de Arquivos e Limpeza dos Scripts Legados da Sprint 1
│   ├── [PBI-02] DDL das Tabelas de Negócio e Estruturação da Tabela de Auditoria DML
│   └── [PBI-03] Carga de Dados Consistentes (Mínimo 5 Registros por Tabela)
│
├── [FEAT-02] Funções PL/SQL e Serialização Customizada sem Built-ins
│   ├── [PBI-04] Função 1 - Serializador Relacional para JSON Manual com 3 Exceções
│   └── [PBI-05] Função 2 - Cálculo de Regra de Negócio (Gamificação/Descontos) com 3 Exceções
│
├── [FEAT-03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais
│   ├── [PBI-06] Procedimento 1 - Consulta Multitabelas (JOIN) e Exportação JSON com 3 Exceções
│   └── [PBI-07] Procedimento 2 - Relatório Tabular com Subtotal e Total Geral sem ROLLUP com 3 Exceções
│
├── [FEAT-04] Trigger de Auditoria DML e Rastreabilidade Transacional
│   └── [PBI-08] Trigger DML Multi-Operação (INSERT, UPDATE, DELETE) com Captura de :OLD e :NEW
│
└── [FEAT-05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF
    ├── [PBI-09] Roteiro de Testes e Evidências de Disparo de Exceções Tratadas
    └── [PBI-10] Consolidação do Script Mestre SQL e Relatório Técnico PDF (2TDSPG_2026_Proj_BD.pdf)
```

---

## 📄 4. Detalhamento dos Product Backlog Items (PBIs) e Child Tasks

---

### 🔹 [PBI-01] Auditoria de Arquivos e Limpeza dos Scripts Legados da Sprint 1
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-01] Refatoração da Base de Dados, Auditoria DML e Higienização de Arquivos`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `2`
* **Tags:** `Database-Advanced`, `Oracle-SQL`, `Sprint3`, `CleanCode`

#### Descrição (História de Usuário)
> **Como** desenvolvedor de banco de dados do time Pet Guardian,  
> **Eu quero** auditar o repositório e remover scripts legados da Sprint 1 que não fazem mais parte do escopo avaliativo da Sprint 3,  
> **Para que** o repositório fique limpo, organizado e atenda estritamente aos critérios de avaliação sem arquivos redundantes ou confusos.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Arquivo `06_consulta_valor_anterior_proximo.sql` (LAG/LEAD da Sprint 1) identificado e removido.
- [ ] Arquivos `05_consultas_joins.sql` e `07_relatorios_cursors.sql` arquivados/removidos para dar lugar aos novos módulos da Sprint 3.
- [ ] Estrutura de pastas reorganizada e documentada.
- [ ] Nenhum script remanescente causa conflito com os novos objetos PL/SQL da Sprint 3.

#### Tarefas Técnicas (Child Tasks)
* **Task 1.1:** Deletar arquivos obsoletos da Sprint 1 (`06_consulta_valor_anterior_proximo.sql`, `05_consultas_joins.sql`, `07_relatorios_cursors.sql`). *(Estimativa: 1h)*
  * *Descrição:* Remover com segurança os arquivos legados da Sprint 1 que foram superados pelos novos requisitos da Sprint 3.
* **Task 1.2:** Reestruturar nomenclatura dos scripts e preparar o pipeline local de execução. *(Estimativa: 1h)*
  * *Descrição:* Renomear e indexar os novos arquivos (`05_funcoes_plsql.sql`, `06_procedimentos_plsql.sql`, `07_trigger_auditoria.sql`, `08_testes_validacao_excecoes.sql`).

---

### 🔹 [PBI-02] DDL das Tabelas de Negócio e Estruturação da Tabela de Auditoria DML
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-01] Refatoração da Base de Dados, Auditoria DML e Higienização de Arquivos`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Tags:** `Database-Advanced`, `Oracle-SQL`, `DDL`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** arquiteto de dados,  
> **Eu quero** manter o modelo 3FN do PetGuardian e criar a tabela de auditoria DML (`TAB_AUDITORIA_DML`) com campos específicos,  
> **Para que** o banco esteja preparado para persistir as entidades de negócio e auditar todas as mutações de dados da aplicação.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Manutenção de todas as tabelas do PetGuardian (`USUARIO`, `VETERINARIO`, `CLINICA`, `PET`, `RACA`, `ATENDIMENTO`, `TAREFA`, etc.) em conformidade com a 3FN.
- [ ] Criação da tabela `TAB_AUDITORIA_DML` contendo obrigatoriamente:
  - `ID_AUDITORIA NUMBER` (PK com sequence/identity)
  - `NOME_USUARIO VARCHAR2(100)` (usuário da sessão Oracle)
  - `TIPO_OPERACAO VARCHAR2(10)` (`INSERT`, `UPDATE`, `DELETE`)
  - `DATA_HORA_OPERACAO TIMESTAMP`
  - `VALORES_ANTERIORES VARCHAR2(4000)` (valores `:OLD`)
  - `VALORES_NOVOS VARCHAR2(4000)` (valores `:NEW`)
- [ ] Manutenção da tabela `LOG_ERROS` para registro de exceções tratadas nas procedures e funções.
- [ ] Script `01_ddl_tabelas.sql` e `02_ddl_logs.sql` revisados e executando sem erros.

#### Tarefas Técnicas (Child Tasks)
* **Task 2.1:** Revisar DDL das tabelas de negócio e integridade referencial (PKs, FKs, Checks). *(Estimativa: 2h)*
  * *Descrição:* Garantir que todas as tabelas atendam à 3FN e possuam tipos adequados (`NUMBER`, `VARCHAR2`, `TIMESTAMP`).
* **Task 2.2:** Implementar o DDL da tabela `TAB_AUDITORIA_DML` e sequence associada. *(Estimativa: 1h)*
  * *Descrição:* Criar a estrutura física de auditoria DML com todas as colunas exigidas pela página 28 do manual.
* **Task 2.3:** Integrar tabela de auditoria e tabela de logs no script DDL inicial. *(Estimativa: 1h)*
  * *Descrição:* Testar a criação completa das tabelas em ordem estrita de dependência no Oracle SQL Developer.

---

### 🔹 [PBI-03] Carga de Dados Consistentes (Mínimo 5 Registros por Tabela)
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-01] Refatoração da Base de Dados, Auditoria DML e Higienização de Arquivos`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Tags:** `Database-Advanced`, `Oracle-SQL`, `DML`, `DataSeeding`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** analista de dados,  
> **Eu quero** popular o banco com no mínimo 5 registros válidos e contextuais em cada tabela,  
> **Para que** todas as rotinas analíticas, agregações e conversões JSON possuam massa de dados suficiente para validação sem penalidades.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] **Todas** as tabelas do sistema populadas com no mínimo 5 registros válidos (regra estrita da pág. 24, 26, 29, 30 — infração acarreta -5 pts por tabela).
- [ ] Dados de `ATENDIMENTO` e `TAREFA` distribuídos entre diferentes veterinários, clínicas e tipos de atendimento para viabilizar agrupamento e subtotais no Procedimento 2.
- [ ] Valores numéricos (`VALOR` em atendimentos e `PONTOS_TAREFA`) representativos para testes de somatório manual.
- [ ] Scripts `03_procedures_carga.sql` e `04_blocos_anonimos_insercao.sql` devidamente validados.

#### Tarefas Técnicas (Child Tasks)
* **Task 3.1:** Elaborar massa de dados contextualizada para pets, tutores, veterinários e clínicas. *(Estimativa: 2h)*
  * *Descrição:* Criar 5+ registros consistentes para as tabelas dimensionais e associativas (`ESTADO`, `CIDADE`, `BAIRRO`, `ENDERECO`, `TELEFONE`, `USUARIO`, `VETERINARIO`, `CLINICA`, `RACA`, `PET`, `USUARIO_PET`, `USUARIO_ENDERECO`, `STATUS`, `TIPO_ATEND`).
* **Task 3.2:** Gerar dados transacionais para a tabela de fatos `ATENDIMENTO` e `TAREFA`. *(Estimativa: 2h)*
  * *Descrição:* Criar 10+ atendimentos cobrindo diferentes veterinários e tipos de atendimento para demonstrar o Procedimento 2 com subtotais ricos.
* **Task 3.3:** Validar contagem e integridade dos registros via queries de conferência. *(Estimativa: 1h)*
  * *Descrição:* Executar `SELECT COUNT(*)` em todas as tabelas para garantir cumprimento do critério de avaliação.

---

### 🔹 [PBI-04] Função 1 - Serializador Relacional para JSON Manual com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-02] Funções PL/SQL e Serialização Customizada sem Built-ins`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `5`
* **Tags:** `Database-Advanced`, `PLSQL`, `Functions`, `JSON`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** desenvolvedor backend de banco de dados,  
> **Eu quero** criar uma função PL/SQL (`FN_FORMATAR_JSON_PET` ou `FN_SERIALIZAR_ATENDIMENTO_JSON`) que transforme registros relacionais em strings JSON de forma 100% manual,  
> **Para que** os dados sejam exportados para integração sem o uso de funções built-in do Oracle, atendendo estritamente ao manual da Sprint 3.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] A função recebe atributos/identificadores e retorna um `CLOB` ou `VARCHAR2` formatado no padrão JSON (ex: `{"id": 1, "nome": "Rex", ...}`).
- [ ] **ZERO uso de funções automáticas/built-in** (`TO_JSON`, `JSON_OBJECT`, `JSON_VALUE`, `JSON_QUERY`, `JSON_ARRAY`, etc. - penalidade de -10 pts evitada).
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas** com blocos `EXCEPTION WHEN`:
  - 1. Exceção de registro não encontrado (`NO_DATA_FOUND` ou personalizada para ID inválido/nulo).
  - 2. Exceção de dados inconsistentes / violação de formato (ex: `VALUE_ERROR` ou validação de string nula).
  - 3. Exceção genérica / inesperada (`WHEN OTHERS` com gravação na tabela `LOG_ERROS`).
- [ ] Código amplamente comentado explicando cada etapa da concatenação de strings e escape de caracteres.

#### Tarefas Técnicas (Child Tasks)
* **Task 4.1:** Desenvolver o algoritmo de concatenação e escape de JSON manual em PL/SQL. *(Estimativa: 2h)*
  * *Descrição:* Criar a lógica de montagem de chaves e valores `{"chave": "valor"}` utilizando operadores de concatenação `||` e tratamento de tipos (números, strings, timestamps).
* **Task 4.2:** Implementar os 3 tratamentos de exceção específicos na função. *(Estimativa: 2h)*
  * *Descrição:* Adicionar validações de parâmetros, tratamento de `NO_DATA_FOUND`, `VALUE_ERROR` e `WHEN OTHERS` com log.
* **Task 4.3:** Criar bloco de teste unitário para validar JSON gerado e casos de erro. *(Estimativa: 1h)*
  * *Descrição:* Testar a função passando IDs válidos, IDs inexistentes e parâmetros nulos para validar o retorno e as exceções.

---

### 🔹 [PBI-05] Função 2 - Cálculo de Regra de Negócio com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-02] Funções PL/SQL e Serialização Customizada sem Built-ins`
* **State:** `New`
* **Priority:** `2 - High`
* **Effort (Story Points):** `3`
* **Tags:** `Database-Advanced`, `PLSQL`, `Functions`, `BusinessRules`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** analista de regras de negócio da Pet Guardian,  
> **Eu quero** criar uma função PL/SQL (`FN_CALCULAR_PONTOS_GAMIFICACAO` ou `FN_CALCULAR_DESCONTO_ATENDIMENTO`) que substitua e centralize um processo lógico do sistema,  
> **Para que** regras de gamificação/cálculos financeiros sejam processados de forma atômica e segura no banco de dados.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Implementação de lógica de negócio real: cálculo dinâmico de pontuação de tarefas por porte do pet / prioridade, ou cálculo de desconto progressivo por quantidade de atendimentos no histórico.
- [ ] Retorno com tipagem consistente (`NUMBER` ou `VARCHAR2`).
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas**:
  - 1. Parâmetro nulo ou valor negativo (`e_valor_invalido EXCEPTION` / `PRAGMA EXCEPTION_INIT`).
  - 2. Violação de limite de negócio (ex: pet não encontrado ou desconto superior ao teto permitido).
  - 3. Tratamento de erro geral (`WHEN OTHERS` com log de auditoria).
- [ ] Código modular e de fácil reutilização pela aplicação (.NET / Java / Mobile).

#### Tarefas Técnicas (Child Tasks)
* **Task 5.1:** Definir a especificação matemática e lógica da regra de negócio da função. *(Estimativa: 1h)*
  * *Descrição:* Mapear regras de pontuação de cuidados do pet com base em porte, tipo de tarefa e prazo cumprido.
* **Task 5.2:** Escrever o código PL/SQL da função com cálculo e validações de negócio. *(Estimativa: 2h)*
  * *Descrição:* Implementar a função garantindo cálculos precisos com arredondamento e verificações de integridade.
* **Task 5.3:** Implementar as 3 exceções e testes unitários de casos de borda. *(Estimativa: 1h)*
  * *Descrição:* Testar entradas válidas, entradas zeradas/negativas e limites estourados.

---

### 🔹 [PBI-06] Procedimento 1 - Consulta Multitabelas (JOIN) e Exportação JSON com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `5`
* **Tags:** `Database-Advanced`, `PLSQL`, `Procedures`, `JOIN`, `JSON`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** desenvolvedor de integrações do sistema,  
> **Eu quero** criar uma procedure PL/SQL (`PRC_EXPORTAR_ATENDIMENTOS_JSON`) que realize JOIN entre múltiplas tabelas e utilize a Função 1 para exibir os dados no formato JSON via `DBMS_OUTPUT`,  
> **Para que** possamos disponibilizar um payload estruturado para alimentar outros serviços ou o MongoDB sem depender de funções built-in.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Realização de `JOIN` entre 3 ou mais tabelas relacionais do PetGuardian (ex: `ATENDIMENTO`, `PET`, `VETERINARIO`, `TIPO_ATEND`, `CLINICA`).
- [ ] Utilização obrigatória da **Função 1** para a formatação de cada linha em JSON.
- [ ] Exibição completa da string JSON estruturada no console (`DBMS_OUTPUT.PUT_LINE`).
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas**:
  - 1. Nenhum registro encontrado para o filtro informado (`NO_DATA_FOUND` / cursor vazio).
  - 2. Erro de buffer ou overflow de saída (`e_buffer_overflow` ou `VALUE_ERROR`).
  - 3. Exceção não mapeada (`WHEN OTHERS` com gravação na tabela `LOG_ERROS`).
- [ ] Mínimo de 5 registros retornados e exibidos na demonstração.

#### Tarefas Técnicas (Child Tasks)
* **Task 6.1:** Estruturar a consulta SQL com múltiplos JOINs e cursor explícito. *(Estimativa: 2h)*
  * *Descrição:* Criar a query relacionando Atendimentos, Pets, Veterinários e Tipos de Atendimento com ordenação consistente.
* **Task 6.2:** Integrar o cursor com a chamada da Função 1 (Serializador JSON manual). *(Estimativa: 2h)*
  * *Descrição:* Iterar sobre os registros, montar o array JSON `[ { ... }, { ... } ]` manualmente e imprimir no console.
* **Task 6.3:** Implementar os 3 tratamentos de exceção e testes com cenários de falha. *(Estimativa: 1h)*
  * *Descrição:* Testar execução com filtro válido, filtro inexistente e forçar erro para validar o bloco de exceção.

---

### 🔹 [PBI-07] Procedimento 2 - Relatório Tabular com Subtotal e Total Geral sem ROLLUP com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `8`
* **Tags:** `Database-Advanced`, `PLSQL`, `Procedures`, `Aggregation`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** gestor da clínica veterinária,  
> **Eu quero** um procedimento PL/SQL (`PRC_RELATORIO_FINANCEIRO_ATENDIMENTOS`) que calcule e exiba valores agrupados por duas categorias, com linhas de "Sub Total" por categoria e "Total Geral" ao final,  
> **Para que** eu tenha um relatório financeiro analítico detalhado sem depender de funções automáticas do Oracle.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Utilização de tabela de fatos do projeto (`ATENDIMENTO`) com 2 categorias (ex: `VETERINARIO` e `TIPO_ATEND`) e 1 métrica numérica (`VALOR`).
- [ ] Cálculo 100% manual em PL/SQL de:
  1. Soma detalhada por combinação de (Categoria 1, Categoria 2);
  2. Linha de **Sub Total** para cada quebra da Categoria 1 (com colunas de agrupamento ausentes/nulas);
  3. Linha de **Total Geral** ao final de todo o processamento.
- [ ] **PROIBIDO** o uso de `ROLLUP`, `CUBE`, `GROUPING SETS`, `GROUPING` ou cláusulas semelhantes (regra estrita da pág. 25).
- [ ] Formatação visual da saída idêntica ao padrão da página 26 do manual (alinhamento de colunas, cabeçalho e tracejados).
- [ ] Mínimo de 5 linhas detalhadas na massa de dados para evidenciar a quebra de subtotais.
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas**:
  - 1. Ausência de movimentação financeira no período (`NO_DATA_FOUND` / cursor vazio).
  - 2. Inconsistência de valor numérico nulo/negativo (`e_valor_invalido`).
  - 3. Exceção geral (`WHEN OTHERS` com persistência em `LOG_ERROS`).

#### Tarefas Técnicas (Child Tasks)
* **Task 7.1:** Desenvolver algoritmo de controle de quebra (Control Break) manual em PL/SQL. *(Estimativa: 3h)*
  * *Descrição:* Criar variáveis acumuladoras (`v_subtotal`, `v_total_geral`), variáveis de controle de quebra (`v_cat1_anterior`) e loops via cursor ordenado.
* **Task 7.2:** Formatar a saída de dados em texto tabulado com `RPAD`/`LPAD` conforme layout do manual. *(Estimativa: 2h)*
  * *Descrição:* Implementar a exibição no padrão: `Categoria1 | Categoria2 | Valor`, seguido de `Sub Total | [vazio] | Valor_Subtotal` e `Total Geral | [vazio] | Valor_Geral`.
* **Task 7.3:** Implementar tratamento das 3 exceções e testes de validação com dados reais. *(Estimativa: 2h)*
  * *Descrição:* Validar a integridade das somas contra consultas `SUM()` externas para comprovar a exatidão matemática dos subtotais manuais.

---

### 🔹 [PBI-08] Trigger DML Multi-Operação com Captura de :OLD e :NEW
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-04] Trigger de Auditoria DML e Rastreabilidade Transacional`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `5`
* **Tags:** `Database-Advanced`, `PLSQL`, `Triggers`, `Audit`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** oficial de segurança e compliance,  
> **Eu quero** criar uma trigger DML (`TRG_AUDITORIA_ATENDIMENTO_DML`) acionada após `INSERT`, `UPDATE` ou `DELETE` na tabela transacional `ATENDIMENTO`,  
> **Para que** todas as alterações cadastrais e financeiras sejam gravadas automaticamente na tabela de auditoria com seus valores anteriores e novos.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Trigger criada com a especificação `AFTER INSERT OR UPDATE OR DELETE ON ATENDIMENTO FOR EACH ROW`.
- [ ] Identificação dinâmica da operação (`INSERTING`, `UPDATING`, `DELETING`).
- [ ] Persistência de:
  - `USER` (usuário de sessão Oracle)
  - `SYSTIMESTAMP` (data/hora exata)
  - Tipo da operação executada
  - Valores antigos (`:OLD.coluna`) em formato textual estruturado
  - Valores novos (`:NEW.coluna`) em formato textual estruturado
- [ ] Não interferir na execução da transação principal em caso de sucesso.
- [ ] Comentários no código explicando a finalidade e funcionamento da trigger.

#### Tarefas Técnicas (Child Tasks)
* **Task 8.1:** Escrever o código da trigger com condicionais `IF INSERTING`, `IF UPDATING`, `IF DELETING`. *(Estimativa: 2h)*
  * *Descrição:* Capturar os atributos relevantes da tabela `ATENDIMENTO` (ID, Data, Valor, Status, Pet, Veterinário) concatenando valores `:OLD` e `:NEW`.
* **Task 8.2:** Criar script de testes DML (Insert, Update e Delete de registros de teste). *(Estimativa: 1h)*
  * *Descrição:* Executar operações de DML para disparar a trigger e comprovar a inserção de registros na tabela `TAB_AUDITORIA_DML`.
* **Task 8.3:** Validar integridade dos logs gerados através de consultas de auditoria. *(Estimativa: 1h)*
  * *Descrição:* Realizar `SELECT * FROM TAB_AUDITORIA_DML ORDER BY DATA_HORA_OPERACAO DESC` para evidenciar o funcionamento.

---

### 🔹 [PBI-09] Roteiro de Testes e Evidências de Disparo de Exceções Tratadas
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF`
* **State:** `New`
* **Priority:** `2 - High`
* **Effort (Story Points):** `3`
* **Tags:** `Database-Advanced`, `Oracle-SQL`, `Testing`, `Exceptions`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** analista de testes de banco de dados,  
> **Eu quero** um script SQL dedicado a executar todos os procedimentos, funções e triggers, incluindo testes com dados inválidos para disparar as exceções tratadas,  
> **Para que** possamos capturar os prints comprobatórios exigidos pela página 29 do manual sem falhas na avaliação.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Criação do arquivo `08_testes_validacao_excecoes.sql`.
- [ ] Testes de sucesso para:
  - Função 1 (JSON gerado corretamente);
  - Função 2 (Cálculo de regra de negócio retornado com exatidão);
  - Procedimento 1 (JOIN e exibição JSON no console);
  - Procedimento 2 (Relatório de Subtotal e Total Geral perfeitamente tabulado);
  - Trigger DML (Auditoria preenchida após INSERT, UPDATE e DELETE).
- [ ] Testes de disparo de **ao menos uma exceção tratada para cada função e procedimento** (exigência estrita da pág. 29 — desconto de -5 pts por ausência).
- [ ] Registro das mensagens de erro tratadas no console e na tabela `LOG_ERROS`.

#### Tarefas Técnicas (Child Tasks)
* **Task 9.1:** Escrever blocos anônimos para execução de casos felizes (Happy Path). *(Estimativa: 2h)*
  * *Descrição:* Executar chamadas válidas de todas as rotinas com saída no `DBMS_OUTPUT`.
* **Task 9.2:** Escrever blocos anônimos para induzir e evidenciar as exceções tratadas. *(Estimativa: 2h)*
  * *Descrição:* Passar parâmetros nulos, IDs inexistentes e violar regras de negócio para comprovar os blocos `EXCEPTION WHEN`.
* **Task 9.3:** Capturar screenshots em alta definição dos resultados no Oracle SQL Developer. *(Estimativa: 1h)*
  * *Descrição:* Salvar as imagens organizadas para inclusão no documento PDF de entrega.

---

### 🔹 [PBI-10] Consolidação do Script Mestre SQL e Relatório Técnico PDF
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Tags:** `Database-Advanced`, `Documentation`, `Deliverable`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** líder técnico do grupo Pet Guardian,  
> **Eu quero** consolidar todo o código no arquivo SQL único e redigir o relatório PDF com capa alfabética e prints de evidência,  
> **Para que** a entrega final cumpra 100% das normas avaliativas da FIAP e garanta a nota máxima.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] **Arquivo SQL Consolidado:** `2TDSPG_2026_CodigoSql_PetGuardian.sql`
  - Contém todo o DDL (tabelas e auditoria), DML de carga (mínimo 5 por tabela), Funções 1 e 2, Procedimentos 1 e 2, Trigger DML e chamadas de teste.
  - Código 100% comentado indicando a finalidade de cada bloco.
- [ ] **Arquivo PDF Oficial:** `docs/2TDSPG_2026_Proj_BD.pdf`
  - Capa contendo nomes e RMs em **ordem alfabética**:
    1. Enzo Okuizumi — RM 561432
    2. Gustavo Okada — RM 563428
    3. Lucas Barros Gouveia — RM 566422
    4. Luna de Carvalho Guimarães — RM 562290
    5. Milton Marcelino — RM 564836
  - Prints nítidos da execução de cada função, procedimento e trigger.
  - Prints das exceções tratadas sendo capturadas.
  - Explicação técnica da arquitetura, 3FN e regras de negócio.
- [ ] `README.md` do repositório atualizado com orientações completas de execução e sumário dos artefatos.

#### Tarefas Técnicas (Child Tasks)
* **Task 10.1:** Gerar o script SQL consolidado único e testar execução do início ao fim em banco limpo. *(Estimativa: 2h)*
  * *Descrição:* Unificar DDL, Carga, Funções, Procedures e Triggers em `2TDSPG_2026_CodigoSql_PetGuardian.sql` e rodar teste de ponta a ponta.
* **Task 10.2:** Redigir o documento técnico PDF e diagramar com as evidências e capa oficial. *(Estimativa: 3h)*
  * *Descrição:* Montar o PDF contendo a capa alfabética, descrição das rotinas, diagramas lógicos/relacionais e todos os prints.
* **Task 10.3:** Atualizar `README.md` com guia de execução, badges e tabela de integrantes. *(Estimativa: 1h)*
  * *Descrição:* Atualizar a documentação do repositório GitHub com a visão consolidada da Sprint 3.

---

## 📊 5. Tabela Resumo do Backlog (Azure Boards)

| ID | Título do PBI | Feature Pai | Story Points | Prioridade | Horas Estimadas |
| :--- | :--- | :--- | :---: | :---: | :---: |
| **PBI-01** | Auditoria de Arquivos e Remoção de Scripts Legados | `[FEAT-01]` Refatoração Base | 2 pts | 1 - Critical | 2h |
| **PBI-02** | DDL das Tabelas e Tabela de Auditoria DML | `[FEAT-01]` Refatoração Base | 3 pts | 1 - Critical | 4h |
| **PBI-03** | Carga de Dados Consistentes (Mín. 5 registros) | `[FEAT-01]` Refatoração Base | 3 pts | 1 - Critical | 5h |
| **PBI-04** | Função 1 - Serializador JSON Manual c/ 3 Exceções | `[FEAT-02]` Funções PL/SQL | 5 pts | 1 - Critical | 5h |
| **PBI-05** | Função 2 - Lógica de Negócio (Gamificação) c/ 3 Exceções | `[FEAT-02]` Funções PL/SQL | 3 pts | 2 - High | 4h |
| **PBI-06** | Procedimento 1 - JOIN e Exportação JSON c/ 3 Exceções | `[FEAT-03]` Procedimentos PL/SQL | 5 pts | 1 - Critical | 5h |
| **PBI-07** | Procedimento 2 - Relatório Subtotal/Total sem ROLLUP c/ 3 Exceções | `[FEAT-03]` Procedimentos PL/SQL | 8 pts | 1 - Critical | 7h |
| **PBI-08** | Trigger DML de Auditoria (:OLD e :NEW) | `[FEAT-04]` Trigger Auditoria | 5 pts | 1 - Critical | 4h |
| **PBI-09** | Bateria de Testes e Evidências de Exceções | `[FEAT-05]` Validação & Docs | 3 pts | 2 - High | 5h |
| **PBI-10** | Consolidação SQL e Relatório Técnico PDF | `[FEAT-05]` Validação & Docs | 3 pts | 1 - Critical | 6h |
| **TOTAL** | **10 PBIs / 26 Child Tasks** | **5 Features / 1 Epic** | **40 pts** | — | **47h** |

---

## ⚠️ 6. Guia de Riscos e Penalidades a Evitar

| Risco / Item Avaliativo | Penalidade no Manual | Mitigação no Backlog |
| :--- | :---: | :--- |
| **Uso de funções built-in para JSON** (`JSON_OBJECT`, `TO_JSON`, etc.) | **-10 pts** por ocorrência | PBI-04 e PBI-06 utilizam concatenação e parsing 100% manual em PL/SQL. |
| **Falta de tratamento de exceções** | **-5 pts** por item | Todos os PBIs (04, 05, 06, 07) exigem no mínimo 3 cláusulas `EXCEPTION WHEN`. |
| **Ausência de prints com exceções tratadas** | **-5 pts** por item | PBI-09 e PBI-10 incluem bloco específico para forçar e printar os erros tratados. |
| **Uso de `ROLLUP`, `CUBE`, `GROUPING SETS`** | **Desconsideração da questão** | PBI-07 implementa quebra de subtotal e total geral com variáveis acumuladoras manuais. |
| **Tabelas com menos de 5 registros** | **-5 pts** por tabela | PBI-03 garante 5+ registros válidos em todas as tabelas do catálogo. |
| **Trigger incompleta ou não gravando auditoria** | **-10 pts** | PBI-08 cobre `INSERT`, `UPDATE` e `DELETE` com gravação de `:OLD` e `:NEW`. |
| **Desorganização ou ausência de comentários** | **-5 pts** | PBI-10 padroniza cabeçalhos descritivos em todos os blocos de código. |
| **Nomes dos integrantes fora de ordem alfabética** | **Perda de pontuação** | Capa do PDF e README estruturados em ordem alfabética estrita (Enzo, Gustavo, Lucas, Luna, Milton). |

---

## 🚀 7. Ordem Recomendada de Implementação dos Arquivos

1. `01_ddl_tabelas.sql` — Criação das tabelas de negócio e constraints.
2. `02_ddl_auditoria_e_logs.sql` — Criação de `TAB_AUDITORIA_DML`, `LOG_ERROS` e sequences.
3. `03_procedures_carga.sql` — Procedures parametrizadas de carga.
4. `04_blocos_anonimos_insercao.sql` — Execução da carga mínima de 5 registros por tabela.
5. `05_funcoes_plsql.sql` — Compilação da Função 1 (JSON manual) e Função 2 (Regra de negócio).
6. `06_procedimentos_plsql.sql` — Compilação do Procedimento 1 (JOIN + JSON) e Procedimento 2 (Subtotal/Total manual).
7. `07_trigger_auditoria.sql` — Compilação da Trigger de auditoria DML.
8. `08_testes_validacao_excecoes.sql` — Execução dos testes de caso de uso e disparo de exceções tratadas.
9. `2TDSPG_2026_CodigoSql_PetGuardian.sql` — Script consolidado para entrega.
10. `run_all.sql` — Execução em lote de toda a esteira de scripts.
