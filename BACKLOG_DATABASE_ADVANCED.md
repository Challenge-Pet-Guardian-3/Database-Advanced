# 📋 Backlog Master Azure Boards — Sprint 3: Database Advanced

> **Projeto Integrado:** PetGuardian / Clyvo Care (Challenge FIAP 2026 - 2º Ano ADS / 2TDSPG)  
> **Disciplina:** Mastering Relational and Non-Relational Database (Database Advanced — FIAP 2TDSPG)  
> **Epic Principal:** `[EPIC] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric`  
> **Start Date:** `2026-08-23`  
> **Target Date:** `2026-08-26`  
> **Padrão:** Azure Boards (Scrum Process: Epic ➔ Feature ➔ PBI ➔ Task)  
> **Diretrizes Estratégicas:** Arquitetura Pet-Centric (Score no Pet, histórico clínico/vacinas, rotina familiar, módulos de treinamento e clínicas 24h) com lógica procedural avançada, tratamento de exceções, auditoria DML (:OLD e :NEW) e serialização manual.

---

## 🎯 1. Matriz de Requisitos & Critérios de Avaliação Oficiais (Páginas 23 a 30)

| Componente | Requisito Oficial & Aplicação Pet-Centric | Pontuação | Regras Críticas / Anti-Padrões |
| :--- | :--- | :---: | :--- |
| **Procedimento 1** | JOIN entre 3+ tabelas (`PET`, `HISTORICO_CONSULTA`, `CLINICA`, `TREINAMENTO_PET`) + exibição em JSON (string) via Função 1 | **30 pts** (dividido c/ Proc 2) | Mínimo 5 registros válidos por tabela; Tratar **no mínimo 3 exceções distintas** (`EXCEPTION WHEN`). |
| **Procedimento 2** | Tabela de fatos com 2 categorias (`CATEGORIA_CUIDADO` e `PET`) e 1 métrica numérica (`PONTOS_BEM_ESTAR`). Subtotal manual por categoria + Total Geral no formato tabular | *(incluso acima)* | **PROIBIDO** uso de `ROLLUP`, `CUBE`, `GROUPING SETS`, `GROUPING`. Somatório 100% manual via PL/SQL. Tratar **3 exceções distintas**. |
| **Função 1** | `FN_FORMATAR_JSON_FICHA_PET`: Recebe dados do Pet/Histórico e retorna string JSON formatada manualmente | **30 pts** (dividido c/ Func 2) | **PROIBIDO** funções built-in (`TO_JSON`, `JSON_OBJECT`, `JSON_VALUE`, etc. Desconto de -10 pts por ocorrência!). Tratar **3 exceções distintas**. |
| **Função 2** | `FN_CALCULAR_SCORE_BEM_ESTAR_PET`: Calcula o Score de Bem-Estar e Nível do Pet com base nos treinos e cuidados cumpridos | *(incluso acima)* | Regra alinhada ao domínio Pet-Centric. Tratar **no mínimo 3 exceções distintas**. |
| **Trigger DML** | Trigger de auditoria DML (`AFTER INSERT OR UPDATE OR DELETE`) em tabelas de mutação clínica/pontuação (`PET` e `HISTORICO_CONSULTA`) | **30 pts** | Gravar em `TAB_AUDITORIA_DML`: Usuário, Tipo de Operação, Data/Hora, Valores Anteriores (`:OLD`) e Valores Novos (`:NEW`). |
| **Documentação & Entregáveis** | Arquivo PDF (`2TDSPG_2026_Proj_BD.pdf`) e Arquivo SQL (`2TDSPG_2026_CodigoSql_PetGuardian.sql`) | **10 pts** | Capa c/ integrantes em **ordem alfabética**; Prints de execução com sucesso E de **erros tratados**; Código 100% comentado. |

---

## 🌳 2. Estrutura Hierárquica no Azure Boards

```text
[EPIC] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric
│
├── 🏆 [FEATURE 01] Refatoração da Base de Dados Pet-Centric, Auditoria DML e Higienização de Arquivos
│   ├── 📄 [PBI-01] Auditoria de Arquivos e Limpeza dos Scripts Legados da Sprint 1 (1 pt)
│   │   ├── 🔹 Task 1.1: Deletar arquivos obsoletos da Sprint 1 (1.0h)
│   │   └── 🔹 Task 1.2: Reestruturar nomenclatura dos scripts e orquestrador (1.0h)
│   ├── 📄 [PBI-02] DDL das Tabelas Pet-Centric e Estruturação da Tabela de Auditoria DML (2 pts)
│   │   ├── 🔹 Task 2.1: Revisar DDL das tabelas Pet-Centric em 3FN e constraints (2.0h)
│   │   ├── 🔹 Task 2.2: Criar DDL da tabela TAB_AUDITORIA_DML e sequence (1.0h)
│   │   └── 🔹 Task 2.3: Integrar tabelas de auditoria e logs nos scripts mestres (1.0h)
│   └── 📄 [PBI-03] Carga de Dados Consistentes (Mínimo 5 Registros por Tabela) (1 pt)
│       ├── 🔹 Task 3.1: Elaborar massa de dados para pets, treinos e tutores (2.0h)
│       ├── 🔹 Task 3.2: Gerar dados transacionais de consultas e rotinas (2.0h)
│       └── 🔹 Task 3.3: Validar SELECT COUNT em todas as tabelas (1.0h)
│
├── 🏆 [FEATURE 02] Funções PL/SQL e Serialização Customizada sem Built-ins
│   ├── 📄 [PBI-04] Função 1 - Serializador Relacional de Ficha do Pet para JSON Manual com 3 Exceções (2 pts)
│   │   ├── 🔹 Task 4.1: Desenvolver algoritmo de concatenação de JSON manual (2.0h)
│   │   ├── 🔹 Task 4.2: Implementar os 3 blocos de EXCEPTION WHEN e log de erros (2.0h)
│   │   └── 🔹 Task 4.3: Criar bloco de teste unitário com IDs válidos e inválidos (1.0h)
│   └── 📄 [PBI-05] Função 2 - Cálculo do Score de Bem-Estar e Nível do Pet com 3 Exceções (2 pts)
│       ├── 🔹 Task 5.1: Definir fórmula de cálculo do Score de Bem-Estar (1.0h)
│       ├── 🔹 Task 5.2: Escrever código PL/SQL com agregação de tarefas e treinos (2.0h)
│       └── 🔹 Task 5.3: Implementar 3 exceções e testes de casos de borda (1.0h)
│
├── 🏆 [FEATURE 03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais
│   ├── 📄 [PBI-06] Procedimento 1 - Consulta Multitabelas (Prontuário Pet) e Exportação JSON com 3 Exceções (3 pts)
│   │   ├── 🔹 Task 6.1: Estruturar consulta SQL com múltiplos JOINs e cursor explícito (2.0h)
│   │   ├── 🔹 Task 6.2: Integrar cursor com chamada da Função 1 (2.0h)
│   │   └── 🔹 Task 6.3: Implementar 3 tratamentos de exceção e testes (1.0h)
│   └── 📄 [PBI-07] Procedimento 2 - Relatório de Pontos de Bem-Estar por Categoria sem ROLLUP com 3 Exceções (3 pts)
│       ├── 🔹 Task 7.1: Desenvolver algoritmo de controle de quebra (Control Break) manual (3.0h)
│       ├── 🔹 Task 7.2: Formatar saída de dados em texto tabulado com RPAD/LPAD (2.0h)
│       └── 🔹 Task 7.3: Implementar tratamento das 3 exceções e testes de validação (2.0h)
│
├── 🏆 [FEATURE 04] Trigger de Auditoria DML e Rastreabilidade Transacional
│   └── 📄 [PBI-08] Trigger DML Multi-Operação (:OLD e :NEW) em Registros Clínicos e de Pontuação (3 pts)
│       ├── 🔹 Task 8.1: Escrever código da trigger com IF INSERTING/UPDATING/DELETING (2.0h)
│       ├── 🔹 Task 8.2: Criar script de teste DML para operações de mutação (1.0h)
│       └── 🔹 Task 8.3: Validar integridade dos logs gerados via consultas de auditoria (1.0h)
│
└── 🏆 [FEATURE 05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF
    ├── 📄 [PBI-09] Roteiro de Testes e Evidências de Disparo de Exceções Tratadas (1 pt)
    │   ├── 🔹 Task 9.1: Escrever blocos anônimos para execução de casos felizes (2.0h)
    │   ├── 🔹 Task 9.2: Escrever blocos anônimos para evidenciar exceções tratadas (2.0h)
    │   └── 🔹 Task 9.3: Capturar screenshots em alta definição dos resultados (1.0h)
    └── 📄 [PBI-10] Consolidação do Script Mestre SQL e Relatório Técnico PDF (2 pts)
        ├── 🔹 Task 10.1: Gerar script SQL consolidado único e testar do zero (2.0h)
        ├── 🔹 Task 10.2: Redigir documento técnico PDF com evidências e capa oficial (3.0h)
        └── 🔹 Task 10.3: Atualizar README.md com guia de execução e integrantes (1.0h)
```

---

## 📊 3. Tabela Resumo do Backlog

| Feature Pai | ID do PBI | Título do Item de Backlog (PBI) | Story Points | Prioridade | Horas Estimadas |
| :--- | :--- | :--- | :---: | :---: | :---: |
| **[FEATURE 01] Refatoração Base** | **PBI-01** | Auditoria de Arquivos e Remoção de Scripts Legados da Sprint 1 | 1 pts | 1 - Critical | 2.0h |
| | **PBI-02** | DDL Pet-Centric e Tabela de Auditoria DML | 2 pts | 1 - Critical | 4.0h |
| | **PBI-03** | Carga de Dados Consistentes (Mínimo 5 registros por tabela) | 1 pts | 1 - Critical | 5.0h |
| **[FEATURE 02] Funções PL/SQL** | **PBI-04** | Função 1 - Serializador JSON Ficha Pet c/ 3 Exceções (sem built-ins) | 2 pts | 1 - Critical | 5.0h |
| | **PBI-05** | Função 2 - Score de Bem-Estar do Pet c/ 3 Exceções | 2 pts | 2 - High | 4.0h |
| **[FEATURE 03] Procedures PL/SQL** | **PBI-06** | Procedimento 1 - JOIN Prontuário e Exportação JSON c/ 3 Exceções | 3 pts | 1 - Critical | 5.0h |
| | **PBI-07** | Procedimento 2 - Relatório Pontos Bem-Estar sem ROLLUP c/ 3 Exceções | 3 pts | 1 - Critical | 7.0h |
| **[FEATURE 04] Trigger Auditoria** | **PBI-08** | Trigger DML de Auditoria (:OLD e :NEW) em Registros Clínicos | 3 pts | 1 - Critical | 4.0h |
| **[FEATURE 05] Validação & Docs** | **PBI-09** | Bateria de Testes e Evidências de Exceções Tratadas | 1 pts | 2 - High | 5.0h |
| | **PBI-10** | Consolidação SQL e Relatório Técnico PDF c/ Capa Alfabética | 2 pts | 1 - Critical | 6.0h |
| **TOTAL CONSOLIDADO** | **5 Features** | **10 PBIs / 26 Child Tasks Técnicas** | **20 pts** | — | **47.0h** |

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
* **Description:** Evolução corporativa do banco de dados relacional Oracle em 3FN para a arquitetura Pet-Centric, com lógica procedural avançada em PL/SQL (Funções sem built-ins e Procedures sem ROLLUP), tratamento rigoroso de exceções, trigger de auditoria DML e relatório técnico PDF oficial.

---

### 🏆 [FEATURE 01] Refatoração da Base de Dados Pet-Centric, Auditoria DML e Higienização de Arquivos
* **Work Item Type:** `Feature`
* **Parent:** `[EPIC] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric`
* **Title:** `[FEATURE 01] Refatoração da Base de Dados Pet-Centric, Auditoria DML e Higienização de Arquivos`
* **Tags:** `Sprint3, Database, Oracle, DDL, DataModeling, CleanCode`
* **Start Date:** `2026-08-23`
* **Target Date:** `2026-08-24`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `4`
* **Description:** Refatoração do modelo relacional Oracle em 3FN para a arquitetura Pet-Centric, estruturação de tabelas de auditoria DML e limpeza de scripts obsoletos.

#### 🔹 [PBI-01] Auditoria de Arquivos e Limpeza dos Scripts Legados da Sprint 1
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 01] Refatoração da Base de Dados Pet-Centric, Auditoria DML e Higienização de Arquivos`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `1`
* **Tags:** `Sprint3, Database, Oracle-SQL, CleanCode`

##### Descrição (História de Usuário)
> **Como** desenvolvedor de banco de dados do time Pet Guardian,  
> **Eu quero** auditar o repositório e remover scripts legados da Sprint 1 que não fazem mais parte do escopo avaliativo da Sprint 3,  
> **Para que** o repositório fique limpo, organizado e atenda estritamente aos critérios de avaliação sem arquivos redundantes ou confusos.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Arquivo `06_consulta_valor_anterior_proximo.sql` (LAG/LEAD da Sprint 1) identificado e removido.
- [ ] Arquivos `05_consultas_joins.sql` e `07_relatorios_cursors.sql` arquivados/removidos para dar lugar aos novos módulos da Sprint 3.
- [ ] Estrutura de pastas reorganizada e documentada.
- [ ] Nenhum script remanescente causa conflito com os novos objetos PL/SQL da Sprint 3.

##### Tarefas Técnicas (Child Tasks)
* **Task 1.1:** [TASK-01] Deletar arquivos obsoletos da Sprint 1 (`06_consulta_valor_anterior_proximo.sql`, `05_consultas_joins.sql`, `07_relatorios_cursors.sql`). *(Activity: Development, Est: 1.0h)*
  * *Descrição:* Remover com segurança arquivos que foram substituídos pelos novos requisitos da Sprint 3.
* **Task 1.2:** [TASK-02] Reestruturar nomenclatura dos scripts e preparar o pipeline local de execução. *(Activity: Development, Est: 1.0h)*
  * *Descrição:* Renomear e indexar novos scripts (`05_funcoes_plsql.sql`, `06_procedimentos_plsql.sql`, `07_trigger_auditoria.sql`).

---

#### 🔹 [PBI-02] DDL das Tabelas Pet-Centric e Estruturação da Tabela de Auditoria DML
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 01] Refatoração da Base de Dados Pet-Centric, Auditoria DML e Higienização de Arquivos`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `2`
* **Tags:** `Sprint3, Database, Oracle-SQL, DDL, PetCentric`

##### Descrição (História de Usuário)
> **Como** arquiteto de dados,  
> **Eu quero** estruturar o modelo relacional 3FN com tabelas Pet-Centric (`PET`, `HISTORICO_PESO`, `HISTORICO_CONSULTA`, `VACINA`, `CLINICA` 24h, `TREINAMENTO_PET`, `TAREFA_ROTINA`) e a tabela `TAB_AUDITORIA_DML`,  
> **Para que** o banco atenda perfeitamente à visão da Mentoria Clyvo e esteja preparado para auditoria DML.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Tabela `PET` contendo `PONTOS_BEM_ESTAR NUMBER`, `NIVEL_SAUDE VARCHAR2(20)`, `PESO_ATUAL NUMBER(5,2)`.
- [ ] Tabelas `HISTORICO_PESO`, `HISTORICO_CONSULTA`, `VACINA` vinculadas a `ID_PET`.
- [ ] Tabela `CLINICA` contendo `FLG_24HRS CHAR(1)` e `FLG_PRONTO_SOCORRO CHAR(1)`.
- [ ] Tabela `TREINAMENTO_PET` para registro de módulos de treino cumpridos.
- [ ] Tabela `TAB_AUDITORIA_DML` contendo obrigatoriamente: `ID_AUDITORIA`, `NOME_USUARIO`, `TIPO_OPERACAO`, `DATA_HORA_OPERACAO`, `VALORES_ANTERIORES` (`:OLD`), `VALORES_NOVOS` (`:NEW`).
- [ ] Tabela `LOG_ERROS` para registro de exceções capturadas.

##### Tarefas Técnicas (Child Tasks)
* **Task 2.1:** [TASK-03] Revisar DDL das tabelas Pet-Centric em 3FN e constraints de integridade. *(Activity: Development, Est: 2.0h)*
  * *Descrição:* Criar tabelas normalizadas com chaves primárias, estrangeiras e restrições NOT NULL.
* **Task 2.2:** [TASK-04] Criar DDL da tabela `TAB_AUDITORIA_DML` e sequence associada. *(Activity: Development, Est: 1.0h)*
  * *Descrição:* Estruturar colunas de auditoria com campos CLOB/VARCHAR2 para registro dos estados :OLD e :NEW.
* **Task 2.3:** [TASK-05] Integrar tabelas de auditoria e logs no script `01_ddl_tabelas.sql` e `02_ddl_logs.sql`. *(Activity: Development, Est: 1.0h)*
  * *Descrição:* Atualizar orquestrador e scripts de DDL de infraestrutura.

---

#### 🔹 [PBI-03] Carga de Dados Consistentes (Mínimo 5 Registros por Tabela)
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 01] Refatoração da Base de Dados Pet-Centric, Auditoria DML e Higienização de Arquivos`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `1`
* **Tags:** `Sprint3, Database, Oracle-SQL, DML, DataSeeding`

##### Descrição (História de Usuário)
> **Como** analista de dados,  
> **Eu quero** popular todas as tabelas com no mínimo 5 registros válidos e contextuais,  
> **Para que** todas as rotinas analíticas, agregações e conversões JSON possuam massa de dados suficiente para validação sem penalidades.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] **Todas** as tabelas do sistema populadas com no mínimo 5 registros válidos (regra estrita da pág. 24, 26, 29).
- [ ] Dados de `PET`, `TREINAMENTO_PET`, `TAREFA_ROTINA` e `HISTORICO_CONSULTA` distribuídos para viabilizar os cálculos de subtotal e total geral do Procedimento 2.
- [ ] Scripts `03_procedures_carga.sql` e `04_blocos_anonimos_insercao.sql` devidamente validados.

##### Tarefas Técnicas (Child Tasks)
* **Task 3.1:** [TASK-06] Elaborar massa de dados para pets, treinos, clínicas 24h e tutores. *(Activity: Development, Est: 2.0h)*
  * *Descrição:* Criar procedimentos de inserção com validação de dados contextuais.
* **Task 3.2:** [TASK-07] Gerar dados transacionais de consultas e tarefas de rotina. *(Activity: Development, Est: 2.0h)*
  * *Descrição:* Popular tabela de fatos com registros vinculados aos animais e tutores.
* **Task 3.3:** [TASK-08] Validar `SELECT COUNT(*)` em todas as tabelas garantindo 5+ registros. *(Activity: Testing, Est: 1.0h)*
  * *Descrição:* Executar queries de contagem e auditar integridade referencial.

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
* **Description:** Implementação de funções PL/SQL determinísticas com serialização JSON manual sem funções built-in e cálculo do Score de Bem-Estar do Pet.

#### 🔹 [PBI-04] Função 1 - Serializador Relacional de Ficha do Pet para JSON Manual com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 02] Funções PL/SQL e Serialização Customizada sem Built-ins`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `2`
* **Tags:** `Sprint3, Database, PLSQL, Functions, JSON, PetCentric`

##### Descrição (História de Usuário)
> **Como** desenvolvedor backend de banco de dados,  
> **Eu quero** criar a função PL/SQL `FN_FORMATAR_JSON_FICHA_PET` que serialize a ficha completa do pet, histórico de saúde e pontuação em string JSON 100% manual,  
> **Para que** os dados sejam exportados sem o uso de funções built-in do Oracle, atendendo estritamente ao manual da Sprint 3.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Função recebe `p_id_pet` e retorna um `CLOB` / `VARCHAR2` formatado em JSON.
- [ ] **ZERO uso de funções automáticas/built-in** (`TO_JSON`, `JSON_OBJECT`, `JSON_VALUE`, `JSON_QUERY`).
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas**:
  - 1. `NO_DATA_FOUND` (Pet inexistente ou ID inválido).
  - 2. `VALUE_ERROR` (Erro de conversão ou parâmetro nulo).
  - 3. `WHEN OTHERS` com gravação na tabela `LOG_ERROS`.
- [ ] Código amplamente comentado explicando a concatenação manual.

##### Tarefas Técnicas (Child Tasks)
* **Task 4.1:** [TASK-09] Desenvolver algoritmo de concatenação de JSON manual em PL/SQL com escape de caracteres. *(Activity: Development, Est: 2.0h)*
  * *Descrição:* Montar payload textual com chaves, colchetes e valores tratados.
* **Task 4.2:** [TASK-10] Implementar os 3 blocos de `EXCEPTION WHEN` e log de erros. *(Activity: Development, Est: 2.0h)*
  * *Descrição:* Capturar erros de ausência de dados, conversão e falhas gerais.
* **Task 4.3:** [TASK-11] Criar bloco de teste unitário com IDs válidos e inválidos. *(Activity: Testing, Est: 1.0h)*
  * *Descrição:* Validar retorno da string JSON e captura de exceções tratadas.

---

#### 🔹 [PBI-05] Função 2 - Cálculo do Score de Bem-Estar e Nível do Pet com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 02] Funções PL/SQL e Serialização Customizada sem Built-ins`
* **State:** `Approved`
* **Priority:** `2 - High`
* **Effort (Story Points):** `2`
* **Tags:** `Sprint3, Database, PLSQL, Functions, Gamification, ScorePet`

##### Descrição (História de Usuário)
> **Como** analista de regras de negócio da Pet Guardian,  
> **Eu quero** criar a função PL/SQL `FN_CALCULAR_SCORE_BEM_ESTAR_PET` que calcule a pontuação ponderada do pet com base em treinos concluídos, tarefas cumpridas e vacinas em dia,  
> **Para que** a evolução de saúde do animal seja processada de forma atômica e segura diretamente no banco de dados.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Cálculo da pontuação com fórmula ponderada (Tarefas Diárias: peso 1x, Treinamentos: peso 2x, Vacinas Atualizadas: bônus fixo).
- [ ] Retorno do score numérico e classificação de nível (`FILHOTE_SAUDAVEL`, `JOVEM_ATIVO`, `MESTRE_DO_BEM_ESTAR`).
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas**:
  - 1. Parâmetro nulo ou pet inexistente (`e_pet_invalido EXCEPTION`).
  - 2. Inconsistência de datas no histórico de vacinação.
  - 3. `WHEN OTHERS` com registro em `LOG_ERROS`.

##### Tarefas Técnicas (Child Tasks)
* **Task 5.1:** [TASK-12] Definir a fórmula matemática de cálculo do Score de Bem-Estar do Pet. *(Activity: Design, Est: 1.0h)*
  * *Descrição:* Estruturar pesos de gamificação alinhados às regras de negócio.
* **Task 5.2:** [TASK-13] Escrever código PL/SQL da função com agregação de tarefas e treinos. *(Activity: Development, Est: 2.0h)*
  * *Descrição:* Executar queries somatórias ponderadas dentro da função.
* **Task 5.3:** [TASK-14] Implementar as 3 exceções e testes de casos de borda. *(Activity: Testing, Est: 1.0h)*
  * *Descrição:* Testar IDs nulos, sem tarefas registradas e com parâmetros válidos.

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
* **Description:** Procedimentos para consultas analíticas multitabelas com exportação JSON e relatórios de métricas por categoria com somatórios manuais sem ROLLUP/CUBE.

#### 🔹 [PBI-06] Procedimento 1 - Consulta Multitabelas (Prontuário Pet) e Exportação JSON com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Tags:** `Sprint3, Database, PLSQL, Procedures, JOIN, JSON`

##### Descrição (História de Usuário)
> **Como** desenvolvedor de integrações,  
> **Eu quero** criar a procedure PL/SQL `PRC_CONSULTA_PRONTUARIO_PET_JSON` que realize JOIN entre `PET`, `HISTORICO_CONSULTA`, `CLINICA` e `TREINAMENTO_PET` e utilize a Função 1 para exibir o prontuário via `DBMS_OUTPUT`,  
> **Para que** possamos disponibilizar um payload estruturado para alimentar outros serviços sem depender de funções automáticas.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Realização de `JOIN` entre 4 tabelas relacionais (`PET`, `HISTORICO_CONSULTA`, `CLINICA`, `TREINAMENTO_PET`).
- [ ] Utilização obrigatória da **Função 1** (`FN_FORMATAR_JSON_FICHA_PET`) para formatar cada linha em JSON.
- [ ] Exibição no console (`DBMS_OUTPUT.PUT_LINE`).
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas**:
  - 1. Nenhum registro encontrado para o filtro (`NO_DATA_FOUND`).
  - 2. Erro de estouro de buffer (`VALUE_ERROR` / buffer overflow).
  - 3. `WHEN OTHERS` com gravação na tabela `LOG_ERROS`.
- [ ] Mínimo de 5 registros retornados e exibidos na demonstração.

##### Tarefas Técnicas (Child Tasks)
* **Task 6.1:** [TASK-15] Estruturar a consulta SQL com múltiplos JOINs e cursor explícito. *(Activity: Development, Est: 2.0h)*
  * *Descrição:* Criar query integrando dados clínicos, treinos e cadastros.
* **Task 6.2:** [TASK-16] Integrar o cursor com a chamada da Função 1 (Serializador JSON manual). *(Activity: Development, Est: 2.0h)*
  * *Descrição:* Iterar sobre registros e exibir array JSON no console.
* **Task 6.3:** [TASK-17] Implementar os 3 tratamentos de exceção e testes com cenários de falha. *(Activity: Testing, Est: 1.0h)*
  * *Descrição:* Testar filtros válidos, inexistentes e forçar erro de buffer.

---

#### 🔹 [PBI-07] Procedimento 2 - Relatório de Pontos de Bem-Estar por Categoria sem ROLLUP com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Tags:** `Sprint3, Database, PLSQL, Procedures, Aggregation, Subtotal`

##### Descrição (História de Usuário)
> **Como** gestor do bem-estar animal,  
> **Eu quero** a procedure PL/SQL `PRC_RELATORIO_PONTOS_BEM_ESTAR_CATEGORIA` que calcule e exiba pontos agrupados por Categoria de Cuidado (`Treinamento`, `Alimentacao`, `Saude/Vacina`) e Pet, com linhas de "Sub Total" por categoria e "Total Geral" ao final,  
> **Para que** eu tenha um relatório analítico detalhado sem depender de funções automáticas (`ROLLUP`/`CUBE`) do Oracle.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Tabela de fatos com 2 categorias (`CATEGORIA_CUIDADO` e `NOME_PET`) e 1 métrica numérica (`PONTOS_BEM_ESTAR`).
- [ ] Cálculo 100% manual em PL/SQL de:
  1. Soma detalhada por combinação (Categoria, Pet);
  2. Linha de **Sub Total** para cada quebra de Categoria de Cuidado;
  3. Linha de **Total Geral** ao final de todo o relatório.
- [ ] **PROIBIDO** o uso de `ROLLUP`, `CUBE`, `GROUPING SETS`, `GROUPING`.
- [ ] Formatação visual da saída idêntica ao padrão da página 26 do manual (alinhamento de colunas, cabeçalho e tracejados).
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas**:
  - 1. Ausência de registros no período (`NO_DATA_FOUND`).
  - 2. Inconsistência de valor numérico nulo/negativo (`e_valor_invalido`).
  - 3. `WHEN OTHERS` com persistência em `LOG_ERROS`.

##### Tarefas Técnicas (Child Tasks)
* **Task 7.1:** [TASK-18] Desenvolver algoritmo de controle de quebra (Control Break) manual em PL/SQL. *(Activity: Development, Est: 3.0h)*
  * *Descrição:* Criar acumuladores manuais para subtotais de categoria e total geral.
* **Task 7.2:** [TASK-19] Formatar a saída de dados em texto tabulado com `RPAD`/`LPAD`. *(Activity: Development, Est: 2.0h)*
  * *Descrição:* Alinhar colunas e cabeçalhos textuais conforme edital.
* **Task 7.3:** [TASK-20] Implementar tratamento das 3 exceções e testes de validação com dados reais. *(Activity: Testing, Est: 2.0h)*
  * *Descrição:* Confrontar somatórios manuais contra queries SQL `SUM()` externas.

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
* **Description:** Criação de trigger DML multi-operação para auditoria de mutações clínicas e pontuações do Pet capturando valores anteriores (:OLD) e novos (:NEW).

#### 🔹 [PBI-08] Trigger DML Multi-Operação (:OLD e :NEW) em Registros Clínicos e de Pontuação
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 04] Trigger de Auditoria DML e Rastreabilidade Transacional`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Tags:** `Sprint3, Database, PLSQL, Triggers, Audit`

##### Descrição (História de Usuário)
> **Como** oficial de segurança e compliance,  
> **Eu quero** criar a trigger DML `TRG_AUDITORIA_PET_DML` acionada após `INSERT`, `UPDATE` ou `DELETE` nas tabelas `PET` e `HISTORICO_CONSULTA`,  
> **Para que** todas as alterações clínicas e de pontuação do animal sejam gravadas na tabela `TAB_AUDITORIA_DML` com valores antigos e novos.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Trigger criada com `AFTER INSERT OR UPDATE OR DELETE ON PET FOR EACH ROW`.
- [ ] Identificação dinâmica da operação (`INSERTING`, `UPDATING`, `DELETING`).
- [ ] Persistência de:
  - `USER` (usuário de sessão Oracle)
  - `SYSTIMESTAMP` (data/hora exata)
  - Tipo da operação executada
  - Valores antigos (`:OLD.coluna`) em formato textual estruturado
  - Valores novos (`:NEW.coluna`) em formato textual estruturado
- [ ] Não interferir na execução da transação principal em caso de sucesso.
- [ ] Comentários no código explicando a finalidade e funcionamento da trigger.

##### Tarefas Técnicas (Child Tasks)
* **Task 8.1:** [TASK-21] Escrever código da trigger com condicionais `IF INSERTING`, `IF UPDATING`, `IF DELETING`. *(Activity: Development, Est: 2.0h)*
  * *Descrição:* Capturar operações e registrar valores antigos e novos.
* **Task 8.2:** [TASK-22] Criar script de teste DML (Insert, Update e Delete de registros de teste). *(Activity: Testing, Est: 1.0h)*
  * *Descrição:* Disparar mutações na tabela PET e HISTORICO_CONSULTA.
* **Task 8.3:** [TASK-23] Validar integridade dos logs gerados através de consultas de auditoria. *(Activity: Testing, Est: 1.0h)*
  * *Descrição:* Realizar SELECT na TAB_AUDITORIA_DML confirmando dados gravados.

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
* **Description:** Bateria de validação de casos de teste e disparos de exceções tratadas, consolidação do script SQL mestre e elaboração do relatório técnico PDF.

#### 🔹 [PBI-09] Roteiro de Testes e Evidências de Disparo de Exceções Tratadas
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF`
* **State:** `Approved`
* **Priority:** `2 - High`
* **Effort (Story Points):** `1`
* **Tags:** `Sprint3, Database, Oracle-SQL, Testing, Exceptions`

##### Descrição (História de Usuário)
> **Como** analista de testes de banco de dados,  
> **Eu quero** um script SQL dedicado a executar todos os procedimentos, funções e triggers, incluindo testes com dados inválidos para disparar as exceções tratadas,  
> **Para que** possamos capturar os prints comprobatórios exigidos pela página 29 do manual sem falhas na avaliação.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] Criação do arquivo `08_testes_validacao_excecoes.sql`.
- [ ] Testes de sucesso para Função 1, Função 2, Procedimento 1, Procedimento 2 e Trigger DML.
- [ ] Testes de disparo de **ao menos uma exceção tratada para cada função e procedimento** (exigência estrita da pág. 29).
- [ ] Registro das mensagens de erro tratadas no console e na tabela `LOG_ERROS`.

##### Tarefas Técnicas (Child Tasks)
* **Task 9.1:** [TASK-24] Escrever blocos anônimos para execução de casos felizes (Happy Path). *(Activity: Testing, Est: 2.0h)*
  * *Descrição:* Executar chamadas válidas de todas as rotinas com saída no DBMS_OUTPUT.
* **Task 9.2:** [TASK-25] Escrever blocos anônimos para induzir e evidenciar as exceções tratadas. *(Activity: Testing, Est: 2.0h)*
  * *Descrição:* Passar parâmetros nulos e IDs inválidos para comprovar blocos EXCEPTION WHEN.
* **Task 9.3:** [TASK-26] Capturar screenshots em alta definição dos resultados no Oracle SQL Developer. *(Activity: Documentation, Est: 1.0h)*
  * *Descrição:* Salvar evidências para composição do relatório técnico PDF.

---

#### 🔹 [PBI-10] Consolidação do Script Mestre SQL e Relatório Técnico PDF
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEATURE 05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF`
* **State:** `Approved`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `2`
* **Tags:** `Sprint3, Database, Documentation, Deliverable`

##### Descrição (História de Usuário)
> **Como** líder técnico do grupo Pet Guardian,  
> **Eu quero** consolidar todo o código no arquivo SQL único e redigir o relatório PDF com capa alfabética e prints de evidência,  
> **Para que** a entrega final cumpra 100% das normas avaliativas da FIAP e garanta a nota máxima.

##### Critérios de Aceite (Acceptance Criteria / Definition of Done)
- [ ] **Arquivo SQL Consolidado:** `2TDSPG_2026_CodigoSql_PetGuardian.sql`
  - Contém todo o DDL Pet-Centric, DML de carga (mínimo 5 por tabela), Funções 1 e 2, Procedimentos 1 e 2, Trigger DML e chamadas de teste.
  - Código 100% comentado.
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

##### Tarefas Técnicas (Child Tasks)
* **Task 10.1:** [TASK-27] Gerar o script SQL consolidado único e testar execução do início ao fim em banco limpo. *(Activity: Development, Est: 2.0h)*
  * *Descrição:* Unificar todos os scripts em `2TDSPG_2026_CodigoSql_PetGuardian.sql`.
* **Task 10.2:** [TASK-28] Redigir o documento técnico PDF e diagramar com as evidências e capa oficial. *(Activity: Documentation, Est: 3.0h)*
  * *Descrição:* Montar o PDF contendo a capa alfabética, descrição das rotinas e prints.
* **Task 10.3:** [TASK-29] Atualizar `README.md` com guia de execução, badges e tabela de integrantes. *(Activity: Documentation, Est: 1.0h)*
  * *Descrição:* Atualizar a documentação do repositório GitHub com a visão da Sprint 3.

---

## 👥 5. Integrantes do Grupo e Responsabilidades (Ordem Alfabética Estrita)

| Integrante | RM | Turma | Responsabilidade Principal na Sprint 3 |
| :--- | :---: | :---: | :--- |
| **Enzo Okuizumi** | **561432** | 2TDSPG | Mobile Development (React Native), Integração TanStack Query & Coordenação Geral |
| **Gustavo Okada** | **563428** | 2TDSPG | Java Advanced (Spring Security JWT, Flyway e SOLID) & .NET Observabilidade |
| **Lucas Barros Gouveia** | **566422** | 2TDSPG | Database Advanced (PL/SQL, Funções, Procedures e Triggers DML) |
| **Luna de Carvalho Guimarães** | **562290** | 2TDSPG | Disruptive Architectures (FastAPI, IA Generativa, RAG e Chat) & Compliance |
| **Milton Marcelino** | **564836** | 2TDSPG | DevOps Tools & Cloud Computing (Azure CLI, ACR, ACI e Containers) |
