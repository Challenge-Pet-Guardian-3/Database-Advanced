# 📋 Backlog Master Azure Boards — Sprint 3: Database Advanced

> **Projeto Integrado:** PetGuardian / Clyvo Care (Challenge FIAP 2026 - 2º Ano ADS / 2TDSPG)  
> **Disciplina:** Mastering Relational and Non-Relational Database (Database Advanced — FIAP 2TDSPG)  
> **Epic Principal:** `[EPIC] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric`  
> **Start Date:** `2026-08-23`  
> **Target Date:** `2026-08-26`  
> **Padrão:** Azure Boards (Scrum Process: Epic ➔ Feature ➔ PBI ➔ Task)  
> **Diretrizes Estratégicas:** Arquitetura Pet-Centric em 3ª Forma Normal (16 tabelas relacionais), programação procedural avançada em PL/SQL (serialização manual JSON sem funções built-in e relatório tabular com subtotais manuais sem ROLLUP/CUBE), tratamento rigoroso de no mínimo 3 exceções distintas por rotina, trigger de auditoria DML (:OLD e :NEW) e relatório técnico PDF oficial.

---

## 🎯 1. Matriz de Requisitos & Critérios de Avaliação Oficiais (Páginas 23 a 30)

| Componente | Requisito Oficial & Aplicação Pet-Centric | Pontuação | Regras Críticas / Anti-Padrões |
| :--- | :--- | :---: | :--- |
| **Procedimento 1** | `pr_listar_tarefas_json`: JOIN entre 4 tabelas (`TAREFA`, `PET`, `STATUS`, `USUARIO`) + exibição em JSON via Função 1 | **30 pts** (dividido c/ Proc 2) | Mínimo 5 registros válidos por tabela; Tratar **no mínimo 3 exceções distintas** (`EXCEPTION WHEN`). |
| **Procedimento 2** | `pr_resumo_pontos_tarefas`: Tabela de fatos `TAREFA` com 2 categorias (`PET` e `STATUS`) e 1 métrica numérica (`PONTOS_TAREFA`). Subtotal manual por Pet + Total Geral no formato tabular | *(incluso acima)* | **PROIBIDO** uso de `ROLLUP`, `CUBE`, `GROUPING SETS`, `GROUPING`. Somatório 100% manual via PL/SQL. Tratar **no mínimo 3 exceções distintas**. |
| **Função 1** | `fn_tarefa_json`: Recebe dados relacionais da tarefa e retorna string JSON formatada manualmente caractere a caractere | **30 pts** (dividido c/ Func 2) | **PROIBIDO** funções built-in (`TO_JSON`, `JSON_OBJECT`, `JSON_VALUE`, etc. Desconto de -10 pts por ocorrência!). Tratar **no mínimo 3 exceções distintas**. |
| **Função 2** | `fn_classificar_pontos`: Processo lógico corporativo de gamificação que classifica o score em faixas (`BRONZE`, `PRATA`, `OURO`, `DIAMANTE`) | *(incluso acima)* | Regra de negócio pura de gamificação. Tratar **no mínimo 3 exceções distintas**. |
| **Trigger DML** | `trg_audit_tarefa`: Trigger de auditoria DML (`AFTER INSERT OR UPDATE OR DELETE ON tarefa FOR EACH ROW`) gravando em `AUDITORIA_DML_TAREFA` | **30 pts** | Gravar: Usuário (`USER`), Tipo de Operação, Data/Hora (`SYSTIMESTAMP`), Valores Anteriores (`:OLD`) e Valores Novos (`:NEW`). |
| **Documentação & Entregáveis** | Arquivo PDF (`2TDSPG_2026_Proj_BD.pdf`) e Arquivo SQL (`2TDSPG_2026_CodigoSql_PetGuardian.sql`) | **10 pts** | Capa c/ integrantes em **ordem alfabética**; Prints de execução com sucesso E de **erros tratados** para cada rotina; Código 100% comentado. |

---

## 🌳 2. Estrutura Hierárquica no Azure Boards

```text
[EPIC] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric
│
├── 🏆 [FEATURE 01] Modelagem Relacional Pet-Centric em 3FN, Auditoria DML e Higienização de Objetos
│   ├── 📄 [PBI-01] Limpeza e Reentrância dos Objetos de Banco com Bloco DROP Seguro (1 pt)
│   │   ├── 🔹 Task 1.1: Desenvolver bloco PL/SQL de DROP seguro com CASCADE CONSTRAINTS PURGE (1.0h)
│   │   └── 🔹 Task 1.2: Validar reentrância da criação dos objetos em schema limpo (1.0h)
│   ├── 📄 [PBI-02] DDL das 16 Tabelas Relacionais em 3FN e Tabela de Auditoria DML (2 pts)
│   │   ├── 🔹 Task 2.1: Implementar DDL normalizado das 16 tabelas com PKs, FKs e Constraints (2.0h)
│   │   ├── 🔹 Task 2.2: Criar tabela AUDITORIA_DML_TAREFA com chave IDENTITY e campos :OLD e :NEW (1.0h)
│   │   └── 🔹 Task 2.3: Validar modelo físico no Oracle SQL Developer Data Modeler (1.0h)
│   └── 📄 [PBI-03] Carga de Dados Consistentes com Mínimo de 5 Registros por Tabela (1 pt)
│       ├── 🔹 Task 3.1: Elaborar massa de dados para entidades centrais (Pet, Tarefa, Usuário, Trilha, Histórico) (2.0h)
│       ├── 🔹 Task 3.2: Configurar 5 estados canônicos na tabela STATUS garantindo aderência ao edital (1.0h)
│       └── 🔹 Task 3.3: Executar consultas de conferência SELECT COUNT(*) >= 5 em todas as tabelas (1.0h)
│
├── 🏆 [FEATURE 02] Funções PL/SQL e Serialização Customizada sem Built-ins
│   ├── 📄 [PBI-04] Função 1 - Serializador Relacional de Tarefa para JSON Manual com 3 Exceções (2 pts)
│   │   ├── 🔹 Task 4.1: Desenvolver algoritmo de concatenação manual de JSON com escape de caracteres (2.0h)
│   │   ├── 🔹 Task 4.2: Implementar os blocos de EXCEPTION WHEN com ORA-20001 a ORA-20004 (2.0h)
│   │   └── 🔹 Task 4.3: Validar serialização e testes unitários de casos válidos e inválidos (1.0h)
│   └── 📄 [PBI-05] Função 2 - Processo Lógico de Classificação de Score de Bem-Estar com 3 Exceções (2 pts)
│       ├── 🔹 Task 5.1: Definir faixas de pontuação e lógica de classificação em PL/SQL (1.0h)
│       ├── 🔹 Task 5.2: Implementar validações de borda e tratamento de 3 exceções distintas (2.0h)
│       └── 🔹 Task 5.3: Criar bateria de chamadas comprovando os 4 níveis de gamificação e erros tratados (1.0h)
│
├── 🏆 [FEATURE 03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais
│   ├── 📄 [PBI-06] Procedimento 1 - Consulta Multitabelas e Exportação JSON com 3 Exceções (3 pts)
│   │   ├── 🔹 Task 6.1: Estruturar cursor com JOIN explícito entre Tarefa, Pet, Status e Usuario (2.0h)
│   │   ├── 🔹 Task 6.2: Integrar cursor à Função 1 para exibição das tarefas serializadas via DBMS_OUTPUT (2.0h)
│   │   └── 🔹 Task 6.3: Implementar tratamento de 3 exceções distintas e proteção de cursor aberto (1.0h)
│   └── 📄 [PBI-07] Procedimento 2 - Relatório Analítico Tabular com Subtotais Manuais sem ROLLUP (3 pts)
│       ├── 🔹 Task 7.1: Desenvolver algoritmo de quebra de grupo em 2 níveis (Control Break) manual em PL/SQL (3.0h)
│       ├── 🔹 Task 7.2: Formatar layout tabular rigoroso com RPAD/LPAD para Subtotal e Total Geral (2.0h)
│       └── 🔹 Task 7.3: Implementar tratamento de 3 exceções distintas e teste com SAVEPOINT (2.0h)
│
├── 🏆 [FEATURE 04] Trigger de Auditoria DML e Rastreabilidade Transacional
│   └── 📄 [PBI-08] Trigger DML Multi-Operação de Auditoria (:OLD e :NEW) em Tarefas (3 pts)
│       ├── 🔹 Task 8.1: Implementar trigger AFTER INSERT OR UPDATE OR DELETE ON tarefa FOR EACH ROW (2.0h)
│       ├── 🔹 Task 8.2: Capturar e serializar estado de atributos :OLD e :NEW por tipo de operação (1.0h)
│       └── 🔹 Task 8.3: Elaborar script de teste com INSERT, UPDATE e DELETE auditados (1.0h)
│
└── 🏆 [FEATURE 05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF
    ├── 📄 [PBI-09] Roteiro de Testes e Evidências de Disparo de Exceções Tratadas (1 pt)
    │   ├── 🔹 Task 9.1: Escrever blocos anônimos de teste de sucesso para todas as rotinas e trigger (2.0h)
    │   ├── 🔹 Task 9.2: Escrever blocos anônimos para induzir e comprovar cada exceção tratada (2.0h)
    │   └── 🔹 Task 9.3: Capturar evidências nítidas de execução no Oracle SQL Developer (1.0h)
    └── 📄 [PBI-10] Consolidação do Script Mestre SQL e Relatório Técnico PDF Oficial (2 pts)
        ├── 🔹 Task 10.1: Consolidar DDL, DML, rotinas PL/SQL e testes no arquivo SQL unificado (2.0h)
        ├── 🔹 Task 10.2: Diagramar documento técnico PDF com capa em ordem alfabética e prints oficiais (3.0h)
        └── 🔹 Task 10.3: Atualizar README.md com dicionário de dados e instruções de execução (1.0h)
```

---

## 📊 3. Tabela Resumo do Backlog

| Feature Pai | ID do PBI | Título do Item de Backlog (PBI) | Story Points | Prioridade | Horas Estimadas |
| :--- | :--- | :--- | :---: | :---: | :---: |
| **[FEATURE 01] Modelagem 3FN** | **PBI-01** | Limpeza e Reentrância dos Objetos com Bloco DROP Seguro | 1 pts | 1 - Critical | 2.0h |
| | **PBI-02** | DDL das 16 Tabelas em 3FN e Tabela AUDITORIA_DML_TAREFA | 2 pts | 1 - Critical | 4.0h |
| | **PBI-03** | Carga de Dados Consistentes (Mínimo 5 registros por tabela) | 1 pts | 1 - Critical | 5.0h |
| **[FEATURE 02] Funções PL/SQL** | **PBI-04** | Função 1 - Serializador de Tarefas JSON Manual c/ 3 Exceções | 2 pts | 1 - Critical | 5.0h |
| | **PBI-05** | Função 2 - Classificação de Score de Bem-Estar c/ 3 Exceções | 2 pts | 2 - High | 4.0h |
| **[FEATURE 03] Procedures PL/SQL** | **PBI-06** | Procedimento 1 - JOIN Multitabelas e Exportação JSON c/ 3 Exceções | 3 pts | 1 - Critical | 5.0h |
| | **PBI-07** | Procedimento 2 - Relatório Tabular sem ROLLUP c/ 3 Exceções | 3 pts | 1 - Critical | 7.0h |
| **[FEATURE 04] Trigger Auditoria** | **PBI-08** | Trigger DML de Auditoria (:OLD e :NEW) na Tabela TAREFA | 3 pts | 1 - Critical | 4.0h |
| **[FEATURE 05] Validação & Docs** | **PBI-09** | Bateria de Testes e Evidências de Exceções Tratadas | 1 pts | 2 - High | 5.0h |
| | **PBI-10** | Consolidação do Script SQL Único e Relatório Técnico PDF | 2 pts | 1 - Critical | 6.0h |
| **TOTAL CONSOLIDADO** | **5 Features** | **10 PBIs / 29 Child Tasks Técnicas** | **20 pts** | — | **47.0h** |

---

## 📦 4. Detalhamento dos Itens de Trabalho (Épico, Features, PBIs e Tasks)

---

### 🏛️ ÉPICO
* **Work Item Type:** `Epic`
* **Title:** `[EPIC] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric`
* **Tags:** `Sprint3, Database, Oracle, PLSQL, DDL, DML, Triggers, Functions, Procedures`
* **Start Date:** `2026-08-23`
* **Target Date:** `2026-08-26`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `20`
* **Business Value:** `100`
* **Description:** Engenharia completa de banco de dados relacional Oracle em 3FN para o ecossistema PetGuardian, incorporando programação procedural avançada em PL/SQL (serialização manual JSON sem funções automáticas e relatório analítico de fatos com somatório manual sem ROLLUP/CUBE), tratamento explícito de no mínimo 3 exceções distintas por rotina, trigger de auditoria DML (:OLD e :NEW) e consolidação em script SQL e relatório técnico PDF oficial.

---

### 🏆 [FEATURE 01] Modelagem Relacional Pet-Centric em 3FN, Auditoria DML e Higienização de Objetos
* **Work Item Type:** `Feature`
* **Parent:** `[EPIC] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric`
* **Title:** `[FEATURE 01] Modelagem Relacional Pet-Centric em 3FN, Auditoria DML e Higienização de Objetos`
* **Tags:** `Sprint3, Database, Oracle, DDL, DataModeling, CleanCode`
* **Start Date:** `2026-08-23`
* **Target Date:** `2026-08-24`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `4`
* **Description:** Normalização em 3ª Forma Normal de 16 entidades relacionais, criação da tabela de auditoria transacional DML e bloco anônimo de limpeza reentrante.

#### 🔹 [PBI-01] Limpeza e Reentrância dos Objetos de Banco com Bloco DROP Seguro
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 01] Modelagem Relacional Pet-Centric em 3FN, Auditoria DML e Higienização de Objetos`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `1`
* **Tags:** `Sprint3, Database, Oracle-SQL, CleanCode`

##### Descrição (História de Usuário)
> **Como** desenvolvedor de banco de dados,  
> **Eu quero** um bloco PL/SQL seguro de expurgo de objetos preexistentes com tratamento de exceções,  
> **Para que** o script SQL mestre possa ser executado múltiplas vezes do início ao fim sem falhas de integridade ou colisão de nomes.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Bloco anônimo percorre `user_tables` filtrando as 17 tabelas do projeto.
- [ ] Execução dinâmica com `EXECUTE IMMEDIATE 'DROP TABLE ... CASCADE CONSTRAINTS PURGE'`.
- [ ] Tratamento de exceção silencioso `WHEN OTHERS THEN NULL` para tabelas não existentes.
- [ ] Garantia de reentrância completa sem erros de execução.

##### Tarefas Técnicas (Child Tasks)
* **Task 1.1:** [TASK-01] Desenvolver bloco PL/SQL de DROP seguro com CASCADE CONSTRAINTS PURGE. *(Activity: Development, Est: 1.0h)*
* **Task 1.2:** [TASK-02] Validar reentrância da criação dos objetos em schema limpo. *(Activity: Testing, Est: 1.0h)*

---

#### 🔹 [PBI-02] DDL das 16 Tabelas Relacionais em 3FN e Tabela de Auditoria DML
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 01] Modelagem Relacional Pet-Centric em 3FN, Auditoria DML e Higienização de Objetos`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `2`
* **Tags:** `Sprint3, Database, Oracle-SQL, DDL, PetCentric`

##### Descrição (História de Usuário)
> **Como** arquiteto de dados da plataforma PetGuardian,  
> **Eu quero** criar os scripts DDL das 16 tabelas relacionais em 3FN e da tabela `AUDITORIA_DML_TAREFA`,  
> **Para que** o modelo relacional suporte o ecossistema de cuidado animal familiar com integridade referencial estrita.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Criação de 16 tabelas em 3FN: `TELEFONE`, `ESTADO`, `CIDADE`, `BAIRRO`, `ENDERECO`, `USUARIO`, `USUARIO_ENDERECO`, `RACA`, `PET`, `USUARIO_PET`, `STATUS`, `TAREFA`, `TRILHA`, `MODULO`, `AULA`, `HISTORICO`.
- [ ] Criação da tabela `AUDITORIA_DML_TAREFA` com `id_auditoria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY`, `nome_usuario`, `tipo_operacao`, `data_hora_operacao TIMESTAMP`, `valores_anteriores VARCHAR2(4000)`, `valores_novos VARCHAR2(4000)`.
- [ ] Todas as constraints de integridade (PKs, FKs, UKs e CHECKs) devidamente nomeadas e ativas.
- [ ] Diagrama no Oracle SQL Developer Data Modeler sincronizado.

##### Tarefas Técnicas (Child Tasks)
* **Task 2.1:** [TASK-03] Implementar DDL normalizado das 16 tabelas com PKs, FKs e Constraints. *(Activity: Development, Est: 2.0h)*
* **Task 2.2:** [TASK-04] Criar tabela AUDITORIA_DML_TAREFA com chave IDENTITY e campos :OLD e :NEW. *(Activity: Development, Est: 1.0h)*
* **Task 2.3:** [TASK-05] Validar modelo físico no Oracle SQL Developer Data Modeler. *(Activity: Documentation, Est: 1.0h)*

---

#### 🔹 [PBI-03] Carga de Dados Consistentes com Mínimo de 5 Registros por Tabela
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 01] Modelagem Relacional Pet-Centric em 3FN, Auditoria DML e Higienização de Objetos`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `1`
* **Tags:** `Sprint3, Database, Oracle-SQL, DML, DataSeeding`

##### Descrição (História de Usuário)
> **Como** analista de dados,  
> **Eu quero** popular todas as tabelas com no mínimo 5 registros válidos e contextuais,  
> **Para que** o projeto atenda rigorosamente ao critério avaliativo de 5+ registros por tabela e viabilize relatórios analíticos.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Todas as tabelas contêm no mínimo 5 registros válidos inseridos via `INSERT INTO`.
- [ ] Tabela `STATUS` populada com 5 estados discretos de tarefas (`PENDENTE`, `CONCLUIDO`, `EXPIRADO`, `EM_ANDAMENTO`, `CANCELADO`) em conformidade com o edital.
- [ ] Tabela `TAREFA` com dados suficientes para cruzamento com pets, tutores e status.
- [ ] Commit explícito ao final da carga de dados.

##### Tarefas Técnicas (Child Tasks)
* **Task 3.1:** [TASK-06] Elaborar massa de dados para entidades centrais (Pet, Tarefa, Usuário, Trilha, Histórico). *(Activity: Development, Est: 2.0h)*
* **Task 3.2:** [TASK-07] Configurar e validar 5 estados canônicos na tabela STATUS garantindo aderência ao edital. *(Activity: Development, Est: 2.0h)*
* **Task 3.3:** [TASK-08] Executar consultas de conferência SELECT COUNT(*) >= 5 em todas as tabelas. *(Activity: Testing, Est: 1.0h)*

---

### 🏆 [FEATURE 02] Funções PL/SQL e Serialização Customizada sem Built-ins
* **Work Item Type:** `Feature`
* **Parent:** `[EPIC] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric`
* **Title:** `[FEATURE 02] Funções PL/SQL e Serialização Customizada sem Built-ins`
* **Tags:** `Sprint3, Database, PLSQL, Functions, JSON, Gamification`
* **Start Date:** `2026-08-24`
* **Target Date:** `2026-08-25`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `4`
* **Description:** Funções determinísticas em PL/SQL para serialização de documentos JSON manuais sem funções built-in e classificação corporativa de score de bem-estar.

#### 🔹 [PBI-04] Função 1 - Serializador Relacional de Tarefa para JSON Manual com 3 Exceções (fn_tarefa_json)
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 02] Funções PL/SQL e Serialização Customizada sem Built-ins`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `2`
* **Tags:** `Sprint3, Database, PLSQL, Functions, JSON`

##### Descrição (História de Usuário)
> **Como** desenvolvedor backend de banco de dados,  
> **Eu quero** criar a função `fn_tarefa_json` que receba os atributos relacionais da tarefa e monte uma string JSON caractere a caractere sem funções built-in,  
> **Para que** a integração de tarefas ocorra de forma desacoplada e eficiente sem reconsultas redundantes ao banco.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Função recebe os dados relacionais da tarefa (`p_id_tarefa`, `p_titulo`, `p_pontos`, `p_descricao`, `p_nome_pet`, `p_nome_status`, `p_nome_usuario`) e retorna `VARCHAR2(4000)`.
- [ ] Concatenação manual com tratamento de escape de aspas duplas (`\"`) e barras invertidas (`\\`).
- [ ] **PROIBIDO** o uso de `TO_JSON`, `JSON_OBJECT`, `JSON_VALUE`, `JSON_QUERY` ou `JSON_TABLE`.
- [ ] Tratamento de 3 exceções distintas: `e_id_invalido` (-20001), `e_dados_incompletos` (-20002), `e_json_excedente` (-20003) e `WHEN OTHERS` (-20004).

##### Tarefas Técnicas (Child Tasks)
* **Task 4.1:** [TASK-09] Desenvolver algoritmo de concatenação manual de JSON com escape de caracteres. *(Activity: Development, Est: 2.0h)*
* **Task 4.2:** [TASK-10] Implementar os blocos de EXCEPTION WHEN com ORA-20001 a ORA-20004. *(Activity: Development, Est: 2.0h)*
* **Task 4.3:** [TASK-11] Validar serialização e testes unitários de casos válidos e inválidos. *(Activity: Testing, Est: 1.0h)*

---

#### 🔹 [PBI-05] Função 2 - Processo Lógico de Classificação de Score de Bem-Estar com 3 Exceções (fn_classificar_pontos)
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 02] Funções PL/SQL e Serialização Customizada sem Built-ins`
* **State:** `Approved`
* **Priority:** `2 - High`
* **Effort (Story Points):** `2`
* **Tags:** `Sprint3, Database, PLSQL, Functions, Gamification`

##### Descrição (História de Usuário)
> **Como** analista de gamificação da PetGuardian,  
> **Eu quero** a função `fn_classificar_pontos` para enquadrar a pontuação de tarefas nas faixas de medalhas de bem-estar,  
> **Para que** o sistema automatize a atribuição de medalhas com validação contra pontuações nulas, negativas ou com estouro.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Recebe `p_pontos IN NUMBER` e retorna o nível de medalha:
  - `0 - 20`: `BRONZE (BÁSICO)`
  - `21 - 45`: `PRATA (INTERMEDIÁRIO)`
  - `46 - 75`: `OURO (AVANÇADO)`
  - `76 - 1000`: `DIAMANTE (MASTER)`
- [ ] Tratamento de 3 exceções distintas: `e_pontos_nulo` (-20009), `e_pontos_negativo` (-20010), `e_pontos_excesso` (-20011) e `WHEN OTHERS` (-20012).

##### Tarefas Técnicas (Child Tasks)
* **Task 5.1:** [TASK-12] Definir faixas de pontuação e lógica de classificação em PL/SQL. *(Activity: Design, Est: 1.0h)*
* **Task 5.2:** [TASK-13] Implementar validações de borda e tratamento de 3 exceções distintas. *(Activity: Development, Est: 2.0h)*
* **Task 5.3:** [TASK-14] Criar bateria de chamadas comprovando os 4 níveis de gamificação e erros tratados. *(Activity: Testing, Est: 1.0h)*

---

### 🏆 [FEATURE 03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais
* **Work Item Type:** `Feature`
* **Parent:** `[EPIC] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric`
* **Title:** `[FEATURE 03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais`
* **Tags:** `Sprint3, Database, PLSQL, Procedures, Aggregation, Subtotal`
* **Start Date:** `2026-08-24`
* **Target Date:** `2026-08-25`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `6`
* **Description:** Procedimentos para consultas analíticas multitabelas com exportação JSON e geração de relatório analítico de fatos com controle de quebra manual sem ROLLUP/CUBE.

#### 🔹 [PBI-06] Procedimento 1 - Consulta Multitabelas e Exportação JSON com 3 Exceções (pr_listar_tarefas_json)
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Tags:** `Sprint3, Database, PLSQL, Procedures, JOIN, JSON`

##### Descrição (História de Usuário)
> **Como** desenvolvedor de rotinas de banco,  
> **Eu quero** a procedure `pr_listar_tarefas_json` que realize JOIN entre `TAREFA`, `PET`, `STATUS` e `USUARIO` e consuma a Função 1,  
> **Para que** possamos exibir a listagem completa de tarefas serializadas em JSON via console.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] JOIN explícito entre 4 tabelas: `tarefa`, `pet`, `status` e `usuario`.
- [ ] Parâmetro opcional `p_status_id IN NUMBER DEFAULT NULL` para filtragem.
- [ ] Chamada obrigatória da Função 1 (`fn_tarefa_json`) para cada registro do cursor.
- [ ] Tratamento de 3 exceções distintas: `e_status_inexistente` (-20005), `e_sem_registros` (-20006), `CURSOR_ALREADY_OPEN` (-20007) e `WHEN OTHERS` (-20008).

##### Tarefas Técnicas (Child Tasks)
* **Task 6.1:** [TASK-15] Estruturar cursor com JOIN explícito entre Tarefa, Pet, Status e Usuario. *(Activity: Development, Est: 2.0h)*
* **Task 6.2:** [TASK-16] Integrar cursor à Função 1 passando a tupla relacional para serialização sem N+1 queries. *(Activity: Development, Est: 2.0h)*
* **Task 6.3:** [TASK-17] Implementar tratamento de 3 exceções distintas e proteção de cursor aberto. *(Activity: Testing, Est: 1.0h)*

---

#### 🔹 [PBI-07] Procedimento 2 - Relatório Analítico Tabular com Subtotais Manuais sem ROLLUP (pr_resumo_pontos_tarefas)
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Tags:** `Sprint3, Database, PLSQL, Procedures, Aggregation, Subtotal`

##### Descrição (História de Usuário)
> **Como** gestor do bem-estar animal,  
> **Eu quero** a procedure `pr_resumo_pontos_tarefas` que calcule e exiba pontos agregados por Pet e Status, com Sub Total por Pet e Total Geral ao final,  
> **Para que** tenhamos um relatório tabular analítico processado 100% de forma procedural sem depender de ROLLUP ou CUBE.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Tabela de fatos: `TAREFA`. Categorias: `PET` (Cat 1) e `STATUS` (Cat 2). Métrica: `PONTOS_TAREFA`.
- [ ] Algoritmo de controle de quebra (*Control Break*) manual no corpo do PL/SQL.
- [ ] **PROIBIDO** o uso de `ROLLUP`, `CUBE`, `GROUPING SETS`, `GROUPING` ou `SUM() GROUP BY` no SQL.
- [ ] Saída formatada com `RPAD`/`LPAD` exibindo linhas de detalhe, `Sub Total` por Pet e `Total Geral` na coluna de pontuação.
- [ ] Tratamento de 3 exceções distintas: `e_sem_fatos_cadastrados` (-20013), `VALUE_ERROR` (-20014), `CURSOR_ALREADY_OPEN` (-20017) e `WHEN OTHERS` (-20015).

##### Tarefas Técnicas (Child Tasks)
* **Task 7.1:** [TASK-18] Desenvolver algoritmo de quebra de grupo em 2 níveis (Control Break) manual em PL/SQL. *(Activity: Development, Est: 3.0h)*
* **Task 7.2:** [TASK-19] Formatar layout tabular rigoroso com RPAD/LPAD para Subtotal e Total Geral. *(Activity: Development, Est: 2.0h)*
* **Task 7.3:** [TASK-20] Implementar tratamento de 3 exceções distintas e teste com SAVEPOINT. *(Activity: Testing, Est: 2.0h)*

---

### 🏆 [FEATURE 04] Trigger de Auditoria DML e Rastreabilidade Transacional
* **Work Item Type:** `Feature`
* **Parent:** `[EPIC] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric`
* **Title:** `[FEATURE 04] Trigger de Auditoria DML e Rastreabilidade Transacional`
* **Tags:** `Sprint3, Database, PLSQL, Triggers, Audit, Security`
* **Start Date:** `2026-08-25`
* **Target Date:** `2026-08-26`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Description:** Monitoramento de transações DML na tabela de fatos TAREFA capturando usuário de sessão, tipo de operação, timestamp e valores :OLD e :NEW.

#### 🔹 [PBI-08] Trigger DML Multi-Operação de Auditoria (:OLD e :NEW) em Tarefas (trg_audit_tarefa)
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 04] Trigger de Auditoria DML e Rastreabilidade Transacional`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Tags:** `Sprint3, Database, PLSQL, Triggers, Audit`

##### Descrição (História de Usuário)
> **Como** auditor de compliance e segurança de dados,  
> **Eu quero** a trigger `trg_audit_tarefa` acionada em operações de INSERT, UPDATE e DELETE na tabela `TAREFA`,  
> **Para que** todas as mutações sejam gravadas na tabela `AUDITORIA_DML_TAREFA` com histórico dos valores anteriores e novos.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Trigger criada com `AFTER INSERT OR UPDATE OR DELETE ON tarefa FOR EACH ROW`.
- [ ] Detecção dinâmica via `INSERTING`, `UPDATING`, `DELETING`.
- [ ] Gravação em `AUDITORIA_DML_TAREFA`: `USER`, tipo de operação, `SYSTIMESTAMP`, valores `:OLD` e `:NEW`.
- [ ] Não bloqueia a transação principal em caso de sucesso.

##### Tarefas Técnicas (Child Tasks)
* **Task 8.1:** [TASK-21] Implementar trigger AFTER INSERT OR UPDATE OR DELETE ON tarefa FOR EACH ROW. *(Activity: Development, Est: 2.0h)*
* **Task 8.2:** [TASK-22] Capturar e serializar estado de atributos :OLD e :NEW por tipo de operação. *(Activity: Development, Est: 1.0h)*
* **Task 8.3:** [TASK-23] Elaborar script de teste com INSERT, UPDATE e DELETE auditados. *(Activity: Testing, Est: 1.0h)*

---

### 🏆 [FEATURE 05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF
* **Work Item Type:** `Feature`
* **Parent:** `[EPIC] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric`
* **Title:** `[FEATURE 05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF`
* **Tags:** `Sprint3, Database, Documentation, Testing, Deliverable`
* **Start Date:** `2026-08-25`
* **Target Date:** `2026-08-26`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Description:** Bateria de testes comprovando execução de sucesso e captura de exceções tratadas de todas as rotinas, consolidação em script SQL e relatório técnico PDF oficial.

#### 🔹 [PBI-09] Roteiro de Testes e Evidências de Disparo de Exceções Tratadas
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF`
* **State:** `Approved`
* **Priority:** `2 - High`
* **Effort (Story Points):** `1`
* **Tags:** `Sprint3, Database, Oracle-SQL, Testing, Exceptions`

##### Descrição (História de Usuário)
> **Como** analista de qualidade de banco de dados,  
> **Eu quero** blocos de teste comprovando a execução com sucesso e o disparo de ao menos uma exceção tratada para cada função e procedimento,  
> **Para que** todas as evidências exigidas pela página 29 do manual sejam geradas e auditadas sem descontos.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Teste de sucesso e de exceção tratada para Função 1 (`fn_tarefa_json` com ID 999 -> ORA-20002).
- [ ] Teste de sucesso e de exceção tratada para Procedimento 1 (`pr_listar_tarefas_json` com status 99 -> ORA-20005).
- [ ] Teste de sucesso e de exceção tratada para Função 2 (`fn_classificar_pontos` com -10 -> ORA-20010).
- [ ] Teste de sucesso e de exceção tratada para Procedimento 2 (`pr_resumo_pontos_tarefas` com esvaziamento temporário via SAVEPOINT -> ORA-20013).
- [ ] Teste da Trigger DML comprovando os registros gerados na tabela de auditoria.

##### Tarefas Técnicas (Child Tasks)
* **Task 9.1:** [TASK-24] Escrever blocos anônimos de teste de sucesso para todas as rotinas e trigger. *(Activity: Testing, Est: 2.0h)*
* **Task 9.2:** [TASK-25] Escrever blocos anônimos para induzir e comprovar cada exceção tratada. *(Activity: Testing, Est: 2.0h)*
* **Task 9.3:** [TASK-26] Capturar evidências nítidas de execução no Oracle SQL Developer. *(Activity: Documentation, Est: 1.0h)*

---

#### 🔹 [PBI-10] Consolidação do Script Mestre SQL e Relatório Técnico PDF Oficial
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `2`
* **Tags:** `Sprint3, Database, Documentation, Deliverable`

##### Descrição (História de Usuário)
> **Como** líder técnico do grupo Pet Guardian,  
> **Eu quero** o script SQL único consolidado e o relatório técnico PDF com capa em ordem alfabética e prints nítidos,  
> **Para que** a entrega cumpra 100% dos requisitos formais de entrega da FIAP.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Arquivo SQL único `2TDSPG_2026_CodigoSql_PetGuardian.sql` executável do início ao fim sem dependências externas.
- [ ] Código 100% comentado explicando cada bloco procedural.
- [ ] Documento PDF `docs/2TDSPG_2026_Proj_BD.pdf` contendo capa em ordem alfabética com nomes e RMs, prints de tela de execução e prints de exceções tratadas.
- [ ] `README.md` do repositório atualizado com dicionário de dados e instruções de execução.

##### Tarefas Técnicas (Child Tasks)
* **Task 10.1:** [TASK-27] Consolidar DDL, DML, rotinas PL/SQL e testes no arquivo SQL unificado. *(Activity: Development, Est: 2.0h)*
* **Task 10.2:** [TASK-28] Diagramar documento técnico PDF com capa em ordem alfabética e prints oficiais. *(Activity: Documentation, Est: 3.0h)*
* **Task 10.3:** [TASK-29] Atualizar README.md com dicionário de dados e instruções de execução. *(Activity: Documentation, Est: 1.0h)*
