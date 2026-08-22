# 📋 Backlog Master Azure Boards — Sprint 3: Database Advanced
> **Projeto:** Pet Guardian (Challenge Clyvo 2026 - 2º Semestre)  
> **Disciplina:** Mastering Relational and Non-Relational Database (FIAP - 2TDSPG)  
> **Referência Oficial:** Manual do Challenge 2026 — Páginas 23 a 30  
> **Diretrizes da Mentoria Clyvo:** Arquitetura Pet-Centric (Score no Pet, histórico clínico/vacinas, rotina familiar, módulos de treinamento e clínicas 24h)  
> **Formato:** Scrum / Azure DevOps (Azure Boards)  

---

## 🎯 1. Diagnóstico dos Requisitos da Sprint 3 (Páginas 23 a 30)

Com base nas especificações das páginas 23 a 30 do manual oficial e no modelo Pet-Centric da Mentoria Clyvo, a Sprint 3 exige a evolução da base de dados relacional (Oracle) com foco em **lógica procedural avançada, tratamento rigoroso de exceções, auditoria DML e manipulação manual de dados**:

| Componente | Requisito Oficial & Aplicação Pet-Centric | Pontuação | Regras Críticas / Anti-Padrões |
| :--- | :--- | :---: | :--- |
| **Procedimento 1** | JOIN entre 3+ tabelas (`PET`, `HISTORICO_CONSULTA`, `CLINICA`, `TREINAMENTO_PET`) + exibição em JSON (string) via Função 1 | **30 pts** (dividido c/ Proc 2) | Mínimo 5 registros válidos por tabela; Tratar **no mínimo 3 exceções distintas** (`EXCEPTION WHEN`). |
| **Procedimento 2** | Tabela de fatos com 2 categorias (`CATEGORIA_CUIDADO` e `PET`) e 1 métrica numérica (`PONTOS_BEM_ESTAR`). Subtotal manual por categoria + Total Geral no formato tabular | *(incluso acima)* | **PROIBIDO** uso de `ROLLUP`, `CUBE`, `GROUPING SETS`, `GROUPING`. Somatório 100% manual via PL/SQL. Tratar **3 exceções distintas**. |
| **Função 1** | `FN_FORMATAR_JSON_FICHA_PET`: Recebe dados do Pet/Histórico e retorna string JSON formatada manualmente | **30 pts** (dividido c/ Func 2) | **PROIBIDO** funções built-in (`TO_JSON`, `JSON_OBJECT`, `JSON_VALUE`, etc. Desconto de -10 pts por ocorrência!). Tratar **3 exceções distintas**. |
| **Função 2** | `FN_CALCULAR_SCORE_BEM_ESTAR_PET`: Calcula o Score de Bem-Estar e Nível do Pet com base nos treinos e cuidados cumpridos | *(incluso acima)* | Regra alinhada ao domínio Pet-Centric. Tratar **no mínimo 3 exceções distintas**. |
| **Trigger DML** | Trigger de auditoria DML (`AFTER INSERT OR UPDATE OR DELETE`) em tabelas de mutação clínica/pontuação (`PET` e `HISTORICO_CONSULTA`) | **30 pts** | Gravar em `TAB_AUDITORIA_DML`: Usuário, Tipo de Operação, Data/Hora, Valores Anteriores (`:OLD`) e Valores Novos (`:NEW`). |
| **Documentação & Entregáveis** | Arquivo PDF (`2TDSPG_2026_Proj_BD.pdf`) e Arquivo SQL (`2TDSPG_2026_CodigoSql_PetGuardian.sql`) | **10 pts** | Capa c/ integrantes em **ordem alfabética**; Prints de execução com sucesso E de **erros tratados**; Código 100% comentado. |

---

## 🗂️ 2. Mapeamento e Ciclo de Vida dos Arquivos do Repositório

### ❌ Arquivos Obsoletos da Sprint 1 a serem Removidos / Substituídos
| Arquivo Atual | Motivo da Remoção / Ação |
| :--- | :--- |
| `06_consulta_valor_anterior_proximo.sql` | **APAGAR:** Script com funções analíticas `LAG` e `LEAD` exclusivo da Sprint 1. |
| `05_consultas_joins.sql` | **APAGAR / SUBSTITUIR:** O Procedimento 1 da Sprint 3 encapsula a lógica de JOIN com saída JSON. |
| `07_relatorios_cursors.sql` | **APAGAR / SUBSTITUIR:** Substituído pelos novos Procedimentos e Funções estruturados. |
| `challenge_clyvo_completo.sql` | **SUBSTITUIR:** Substituído pelo script consolidado oficial da Sprint 3 (`2TDSPG_2026_CodigoSql_PetGuardian.sql`). |

---

### 🔄 Arquivos a Manter e Refatorar
| Arquivo | Ação de Refatoração |
| :--- | :--- |
| `01_ddl_tabelas.sql` | **REFATORAR (Pet-Centric):** Estruturar tabelas `PET` (com `PONTOS_BEM_ESTAR`, `PESO_ATUAL`), `HISTORICO_PESO`, `HISTORICO_CONSULTA`, `VACINA`, `CLINICA` (com `FLG_24HRS`, `FLG_PRONTO_SOCORRO`), `TREINAMENTO_PET`, `TAREFA_ROTINA` em 3FN. |
| `02_ddl_logs.sql` | **EXPANDIR:** Incluir tabela `TAB_AUDITORIA_DML` e manter `LOG_ERROS`. |
| `03_procedures_carga.sql` | **REVISAR:** Garantir no mínimo **5 registros válidos e consistentes** por tabela com dados de treinos, clínicas 24h e rotinas. |
| `04_blocos_anonimos_insercao.sql` | **MANTER:** Bloco de execução da carga de dados via procedures. |
| `run_all.sql` | **ATUALIZAR:** Orquestrador mestre atualizado para rodar todos os novos scripts da Sprint 3. |
| `README.md` | **ATUALIZAR:** Documentar os novos requisitos da Sprint 3 e tabela de integrantes em ordem alfabética. |

---

### ✨ Novos Arquivos a Criar na Sprint 3
| Novo Arquivo | Finalidade |
| :--- | :--- |
| `05_funcoes_plsql.sql` | Implementação da **Função 1** (`FN_FORMATAR_JSON_FICHA_PET`) e **Função 2** (`FN_CALCULAR_SCORE_BEM_ESTAR_PET`), ambas com 3 tratamentos de exceção. |
| `06_procedimentos_plsql.sql` | Implementação do **Procedimento 1** (`PRC_CONSULTA_PRONTUARIO_PET_JSON`) e **Procedimento 2** (`PRC_RELATORIO_PONTOS_BEM_ESTAR_CATEGORIA` sem ROLLUP), ambos com 3 tratamentos de exceção. |
| `07_trigger_auditoria.sql` | Implementação da **Trigger DML** (`AFTER INSERT OR UPDATE OR DELETE`) com captura de `:OLD` e `:NEW`. |
| `08_testes_validacao_excecoes.sql` | Scripts de teste para demonstrar casos felizes e disparar intencionalmente as exceções tratadas (para os prints do PDF). |
| `2TDSPG_2026_CodigoSql_PetGuardian.sql` | Script consolidado oficial contendo DDL, Cargas, Funções, Procedures e Triggers em arquivo único. |
| `docs/2TDSPG_2026_Proj_BD.pdf` | Documento PDF final com capa em ordem alfabética, prints das execuções e de todas as exceções tratadas. |

---

## 👑 3. Estrutura do Backlog no Azure Boards (Scrum)

```text
[EPIC-03] Sprint 3 - Database Advanced: Engenharia PL/SQL Avançada, Auditoria DML e Serialização JSON Pet-Centric
│
├── [FEAT-01] Refatoração da Base de Dados Pet-Centric, Auditoria DML e Higienização de Arquivos
│   ├── [PBI-01] Auditoria de Arquivos e Limpeza dos Scripts Legados da Sprint 1 (2 pts)
│   ├── [PBI-02] DDL das Tabelas Pet-Centric e Estruturação da Tabela de Auditoria DML (3 pts)
│   └── [PBI-03] Carga de Dados Consistentes (Mínimo 5 Registros por Tabela) (3 pts)
│
├── [FEAT-02] Funções PL/SQL e Serialização Customizada sem Built-ins
│   ├── [PBI-04] Função 1 - Serializador Relacional de Ficha do Pet para JSON Manual com 3 Exceções (5 pts)
│   └── [PBI-05] Função 2 - Cálculo do Score de Bem-Estar e Nível do Pet com 3 Exceções (3 pts)
│
├── [FEAT-03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais
│   ├── [PBI-06] Procedimento 1 - Consulta Multitabelas (Prontuário Pet) e Exportação JSON com 3 Exceções (5 pts)
│   └── [PBI-07] Procedimento 2 - Relatório de Pontos de Bem-Estar por Categoria sem ROLLUP com 3 Exceções (8 pts)
│
├── [FEAT-04] Trigger de Auditoria DML e Rastreabilidade Transacional
│   └── [PBI-08] Trigger DML Multi-Operação (:OLD e :NEW) em Registros Clínicos e de Pontuação (5 pts)
│
└── [FEAT-05] Bateria de Testes, Consolidação SQL e Documentação Técnica PDF
    ├── [PBI-09] Roteiro de Testes e Evidências de Disparo de Exceções Tratadas (3 pts)
    └── [PBI-10] Consolidação do Script Mestre SQL e Relatório Técnico PDF (2TDSPG_2026_Proj_BD.pdf) (3 pts)
```

---

## 📄 4. Detalhamento dos Product Backlog Items (PBIs) e Child Tasks

---

### 🔹 [PBI-01] Auditoria de Arquivos e Limpeza dos Scripts Legados da Sprint 1
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-01] Refatoração da Base de Dados Pet-Centric, Auditoria DML e Higienização de Arquivos`
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

### 🔹 [PBI-02] DDL das Tabelas Pet-Centric e Estruturação da Tabela de Auditoria DML
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-01] Refatoração da Base de Dados Pet-Centric, Auditoria DML e Higienização de Arquivos`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Tags:** `Database-Advanced`, `Oracle-SQL`, `DDL`, `PetCentric`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** arquiteto de dados,  
> **Eu quero** estruturar o modelo relacional 3FN com tabelas Pet-Centric (`PET`, `HISTORICO_PESO`, `HISTORICO_CONSULTA`, `VACINA`, `CLINICA` 24h, `TREINAMENTO_PET`, `TAREFA_ROTINA`) e a tabela `TAB_AUDITORIA_DML`,  
> **Para que** o banco atenda perfeitamente à visão da Mentoria Clyvo e esteja preparado para auditoria DML.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Tabela `PET` contendo `PONTOS_BEM_ESTAR NUMBER`, `NIVEL_SAUDE VARCHAR2(20)`, `PESO_ATUAL NUMBER(5,2)`.
- [ ] Tabelas `HISTORICO_PESO`, `HISTORICO_CONSULTA`, `VACINA` vinculadas a `ID_PET`.
- [ ] Tabela `CLINICA` contendo `FLG_24HRS CHAR(1)` e `FLG_PRONTO_SOCORRO CHAR(1)`.
- [ ] Tabela `TREINAMENTO_PET` para registro de módulos de treino cumpridos.
- [ ] Tabela `TAB_AUDITORIA_DML` contendo obrigatoriamente: `ID_AUDITORIA`, `NOME_USUARIO`, `TIPO_OPERACAO`, `DATA_HORA_OPERACAO`, `VALORES_ANTERIORES` (`:OLD`), `VALORES_NOVOS` (`:NEW`).
- [ ] Tabela `LOG_ERROS` para registro de exceções capturadas.

#### Tarefas Técnicas (Child Tasks)
* **Task 2.1:** Revisar DDL das tabelas Pet-Centric em 3FN e constraints de integridade. *(Estimativa: 2h)*
* **Task 2.2:** Criar DDL da tabela `TAB_AUDITORIA_DML` e sequence associada. *(Estimativa: 1h)*
* **Task 2.3:** Integrar tabelas de auditoria e logs no script `01_ddl_tabelas.sql` e `02_ddl_logs.sql`. *(Estimativa: 1h)*

---

### 🔹 [PBI-03] Carga de Dados Consistentes (Mínimo 5 Registros por Tabela)
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-01] Refatoração da Base de Dados Pet-Centric, Auditoria DML e Higienização de Arquivos`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `3`
* **Tags:** `Database-Advanced`, `Oracle-SQL`, `DML`, `DataSeeding`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** analista de dados,  
> **Eu quero** popular todas as tabelas com no mínimo 5 registros válidos e contextuais,  
> **Para que** todas as rotinas analíticas, agregações e conversões JSON possuam massa de dados suficiente para validação sem penalidades.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] **Todas** as tabelas do sistema populadas com no mínimo 5 registros válidos (regra estrita da pág. 24, 26, 29 — infração acarreta -5 pts por tabela).
- [ ] Dados de `PET`, `TREINAMENTO_PET`, `TAREFA_ROTINA` e `HISTORICO_CONSULTA` distribuídos para viabilizar os cálculos de subtotal e total geral do Procedimento 2.
- [ ] Scripts `03_procedures_carga.sql` e `04_blocos_anonimos_insercao.sql` devidamente validados.

#### Tarefas Técnicas (Child Tasks)
* **Task 3.1:** Elaborar massa de dados para pets, treinos, clínicas 24h e tutores. *(Estimativa: 2h)*
* **Task 3.2:** Gerar dados transacionais de consultas e tarefas de rotina. *(Estimativa: 2h)*
* **Task 3.3:** Validar `SELECT COUNT(*)` em todas as tabelas garantindo 5+ registros. *(Estimativa: 1h)*

---

### 🔹 [PBI-04] Função 1 - Serializador Relacional de Ficha do Pet para JSON Manual com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-02] Funções PL/SQL e Serialização Customizada sem Built-ins`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `5`
* **Tags:** `Database-Advanced`, `PLSQL`, `Functions`, `JSON`, `PetCentric`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** desenvolvedor backend de banco de dados,  
> **Eu quero** criar a função PL/SQL `FN_FORMATAR_JSON_FICHA_PET` que serialize a ficha completa do pet, histórico de saúde e pontuação em string JSON 100% manual,  
> **Para que** os dados sejam exportados sem o uso de funções built-in do Oracle, atendendo estritamente ao manual da Sprint 3.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Função recebe `p_id_pet` e retorna um `CLOB` / `VARCHAR2` formatado em JSON (`{"id": 1, "nome": "Rex", "score": 850, "vacinas": [...], "consultas": [...]}`).
- [ ] **ZERO uso de funções automáticas/built-in** (`TO_JSON`, `JSON_OBJECT`, `JSON_VALUE`, `JSON_QUERY` - penalidade de -10 pts evitada).
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas**:
  - 1. `NO_DATA_FOUND` (Pet inexistente ou ID inválido).
  - 2. `VALUE_ERROR` (Erro de conversão ou parâmetro nulo).
  - 3. `WHEN OTHERS` com gravação na tabela `LOG_ERROS`.
- [ ] Código amplamente comentado explicando a concatenação manual.

#### Tarefas Técnicas (Child Tasks)
* **Task 4.1:** Desenvolver algoritmo de concatenação de JSON manual em PL/SQL com escape de caracteres. *(Estimativa: 2h)*
* **Task 4.2:** Implementar os 3 blocos de `EXCEPTION WHEN` e log de erros. *(Estimativa: 2h)*
* **Task 4.3:** Criar bloco de teste unitário com IDs válidos e inválidos. *(Estimativa: 1h)*

---

### 🔹 [PBI-05] Função 2 - Cálculo do Score de Bem-Estar e Nível do Pet com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-02] Funções PL/SQL e Serialização Customizada sem Built-ins`
* **State:** `New`
* **Priority:** `2 - High`
* **Effort (Story Points):** `3`
* **Tags:** `Database-Advanced`, `PLSQL`, `Functions`, `Gamification`, `ScorePet`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** analista de regras de negócio da Pet Guardian,  
> **Eu quero** criar a função PL/SQL `FN_CALCULAR_SCORE_BEM_ESTAR_PET` que calcule a pontuação ponderada do pet com base em treinos concluídos, tarefas cumpridas e vacinas em dia,  
> **Para que** a evolução de saúde do animal seja processada de forma atômica e segura diretamente no banco de dados.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Cálculo da pontuação com fórmula ponderada (Tarefas Diárias: peso 1x, Treinamentos: peso 2x, Vacinas Atualizadas: bônus fixo).
- [ ] Retorno do score numérico e classificação de nível (`FILHOTE_SAUDAVEL`, `JOVEM_ATIVO`, `MESTRE_DO_BEM_ESTAR`).
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas**:
  - 1. Parâmetro nulo ou pet inexistente (`e_pet_invalido EXCEPTION`).
  - 2. Inconsistência de datas no histórico de vacinação.
  - 3. `WHEN OTHERS` com registro em `LOG_ERROS`.

#### Tarefas Técnicas (Child Tasks)
* **Task 5.1:** Definir a fórmula matemática de cálculo do Score de Bem-Estar do Pet. *(Estimativa: 1h)*
* **Task 5.2:** Escrever código PL/SQL da função com agregação de tarefas e treinos. *(Estimativa: 2h)*
* **Task 5.3:** Implementar as 3 exceções e testes de casos de borda. *(Estimativa: 1h)*

---

### 🔹 [PBI-06] Procedimento 1 - Consulta Multitabelas (Prontuário Pet) e Exportação JSON com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `5`
* **Tags:** `Database-Advanced`, `PLSQL`, `Procedures`, `JOIN`, `JSON`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** desenvolvedor de integrações,  
> **Eu quero** criar a procedure PL/SQL `PRC_CONSULTA_PRONTUARIO_PET_JSON` que realize JOIN entre `PET`, `HISTORICO_CONSULTA`, `CLINICA` e `TREINAMENTO_PET` e utilize a Função 1 para exibir o prontuário via `DBMS_OUTPUT`,  
> **Para que** possamos disponibilizar um payload estruturado para alimentar outros serviços sem depender de funções automáticas.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Realização de `JOIN` entre 4 tabelas relacionais (`PET`, `HISTORICO_CONSULTA`, `CLINICA`, `TREINAMENTO_PET`).
- [ ] Utilização obrigatória da **Função 1** (`FN_FORMATAR_JSON_FICHA_PET`) para formatar cada linha em JSON.
- [ ] Exibição no console (`DBMS_OUTPUT.PUT_LINE`).
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas**:
  - 1. Nenhum registro encontrado para o filtro (`NO_DATA_FOUND`).
  - 2. Erro de estouro de buffer (`VALUE_ERROR` / buffer overflow).
  - 3. `WHEN OTHERS` com gravação na tabela `LOG_ERROS`.
- [ ] Mínimo de 5 registros retornados e exibidos na demonstração.

#### Tarefas Técnicas (Child Tasks)
* **Task 6.1:** Estruturar a consulta SQL com múltiplos JOINs e cursor explícito. *(Estimativa: 2h)*
  * *Descrição:* Criar a query relacionando Atendimentos, Pets, Veterinários e Tipos de Atendimento com ordenação consistente.
* **Task 6.2:** Integrar o cursor com a chamada da Função 1 (Serializador JSON manual). *(Estimativa: 2h)*
  * *Descrição:* Iterar sobre os registros, montar o array JSON `[ { ... }, { ... } ]` manualmente e imprimir no console.
* **Task 6.3:** Implementar os 3 tratamentos de exceção e testes com cenários de falha. *(Estimativa: 1h)*
  * *Descrição:* Testar execução com filtro válido, filtro inexistente e forçar erro para validar o bloco de exceção.

---

### 🔹 [PBI-07] Procedimento 2 - Relatório de Pontos de Bem-Estar por Categoria sem ROLLUP com 3 Exceções
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-03] Procedimentos PL/SQL e Relatórios com Subtotais Manuais`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `8`
* **Tags:** `Database-Advanced`, `PLSQL`, `Procedures`, `Aggregation`, `Subtotal`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** gestor do bem-estar animal,  
> **Eu quero** a procedure PL/SQL `PRC_RELATORIO_PONTOS_BEM_ESTAR_CATEGORIA` que calcule e exiba pontos agrupados por Categoria de Cuidado (`Treinamento`, `Alimentacao`, `Saude/Vacina`) e Pet, com linhas de "Sub Total" por categoria e "Total Geral" ao final,  
> **Para que** eu tenha um relatório analítico detalhado sem depender de funções automáticas (`ROLLUP`/`CUBE`) do Oracle.

#### Critérios de Aceite (Acceptance Criteria)
- [ ] Tabela de fatos com 2 categorias (`CATEGORIA_CUIDADO` e `NOME_PET`) e 1 métrica numérica (`PONTOS_BEM_ESTAR`).
- [ ] Cálculo 100% manual em PL/SQL de:
  1. Soma detalhada por combinação (Categoria, Pet);
  2. Linha de **Sub Total** para cada quebra de Categoria de Cuidado;
  3. Linha de **Total Geral** ao final de todo o relatório.
- [ ] **PROIBIDO** o uso de `ROLLUP`, `CUBE`, `GROUPING SETS`, `GROUPING` (regra estrita da pág. 25).
- [ ] Formatação visual da saída idêntica ao padrão da página 26 do manual (alinhamento de colunas, cabeçalho e tracejados).
- [ ] Tratamento explícito de **no mínimo 3 exceções distintas**:
  - 1. Ausência de registros no período (`NO_DATA_FOUND`).
  - 2. Inconsistência de valor numérico nulo/negativo (`e_valor_invalido`).
  - 3. `WHEN OTHERS` com persistência em `LOG_ERROS`.

#### Tarefas Técnicas (Child Tasks)
* **Task 7.1:** Desenvolver algoritmo de controle de quebra (Control Break) manual em PL/SQL. *(Estimativa: 3h)*
  * *Descrição:* Criar variáveis acumuladoras (`v_subtotal`, `v_total_geral`), variáveis de controle de quebra (`v_cat1_anterior`) e loops via cursor ordenado.
* **Task 7.2:** Formatar a saída de dados em texto tabulado com `RPAD`/`LPAD` conforme layout do manual. *(Estimativa: 2h)*
  * *Descrição:* Implementar a exibição no padrão: `Categoria1 | Categoria2 | Valor`, seguido de `Sub Total | [vazio] | Valor_Subtotal` e `Total Geral | [vazio] | Valor_Geral`.
* **Task 7.3:** Implementar tratamento das 3 exceções e testes de validação com dados reais. *(Estimativa: 2h)*
  * *Descrição:* Validar a integridade das somas contra consultas `SUM()` externas para comprovar a exatidão matemática dos subtotais manuais.

---

### 🔹 [PBI-08] Trigger DML Multi-Operação (:OLD e :NEW) em Registros Clínicos e de Pontuação
* **Work Item Type:** `Product Backlog Item`
* **Parent Feature:** `[FEAT-04] Trigger de Auditoria DML e Rastreabilidade Transacional`
* **State:** `New`
* **Priority:** `1 - Critical`
* **Effort (Story Points):** `5`
* **Tags:** `Database-Advanced`, `PLSQL`, `Triggers`, `Audit`, `Sprint3`

#### Descrição (História de Usuário)
> **Como** oficial de segurança e compliance,  
> **Eu quero** criar a trigger DML `TRG_AUDITORIA_PET_DML` acionada após `INSERT`, `UPDATE` ou `DELETE` nas tabelas `PET` e `HISTORICO_CONSULTA`,  
> **Para que** todas as alterações clínicas e de pontuação do animal sejam gravadas na tabela `TAB_AUDITORIA_DML` com valores antigos e novos.

#### Critérios de Aceite (Acceptance Criteria)
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

#### Tarefas Técnicas (Child Tasks)
* **Task 8.1:** Escrever código da trigger com condicionais `IF INSERTING`, `IF UPDATING`, `IF DELETING`. *(Estimativa: 2h)*
* **Task 8.2:** Criar script de teste DML (Insert, Update e Delete de registros de teste). *(Estimativa: 1h)*
* **Task 8.3:** Validar integridade dos logs gerados através de consultas de auditoria. *(Estimativa: 1h)*

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
| **PBI-02** | DDL Pet-Centric e Tabela de Auditoria DML | `[FEAT-01]` Refatoração Base | 3 pts | 1 - Critical | 4h |
| **PBI-03** | Carga de Dados Consistentes (Mín. 5 registros) | `[FEAT-01]` Refatoração Base | 3 pts | 1 - Critical | 5h |
| **PBI-04** | Função 1 - Serializador JSON Ficha Pet c/ 3 Exceções | `[FEAT-02]` Funções PL/SQL | 5 pts | 1 - Critical | 5h |
| **PBI-05** | Função 2 - Score de Bem-Estar do Pet c/ 3 Exceções | `[FEAT-02]` Funções PL/SQL | 3 pts | 2 - High | 4h |
| **PBI-06** | Procedimento 1 - JOIN Prontuário e Exportação JSON c/ 3 Exceções | `[FEAT-03]` Procedimentos PL/SQL | 5 pts | 1 - Critical | 5h |
| **PBI-07** | Procedimento 2 - Relatório Pontos Bem-Estar sem ROLLUP c/ 3 Exceções | `[FEAT-03]` Procedimentos PL/SQL | 8 pts | 1 - Critical | 7h |
| **PBI-08** | Trigger DML de Auditoria (:OLD e :NEW) em Registros Clínicos | `[FEAT-04]` Trigger Auditoria | 5 pts | 1 - Critical | 4h |
| **PBI-09** | Bateria de Testes e Evidências de Exceções Tratadas | `[FEAT-05]` Validação & Docs | 3 pts | 2 - High | 5h |
| **PBI-10** | Consolidação SQL e Relatório Técnico PDF c/ Capa Alfabética | `[FEAT-05]` Validação & Docs | 3 pts | 1 - Critical | 6h |
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
| **Nomes dos integrantes fora de ordem alfabética** | **Perda de pontuação** | Capa do PDF e README estruturados em ordem alfabética estrita (Enzo, Gustavo, Lucas, Luna, Milton). |

---

## 🚀 7. Ordem Recomendada de Implementação dos Arquivos

1. `01_ddl_tabelas.sql` — Criação das tabelas de negócio Pet-Centric e constraints.
2. `02_ddl_auditoria_e_logs.sql` — Criação de `TAB_AUDITORIA_DML`, `LOG_ERROS` e sequences.
3. `03_procedures_carga.sql` — Procedures parametrizadas de carga.
4. `04_blocos_anonimos_insercao.sql` — Execução da carga mínima de 5 registros por tabela.
5. `05_funcoes_plsql.sql` — Compilação da Função 1 (`FN_FORMATAR_JSON_FICHA_PET`) e Função 2 (`FN_CALCULAR_SCORE_BEM_ESTAR_PET`).
6. `06_procedimentos_plsql.sql` — Compilação do Procedimento 1 (`PRC_CONSULTA_PRONTUARIO_PET_JSON`) e Procedimento 2 (`PRC_RELATORIO_PONTOS_BEM_ESTAR_CATEGORIA`).
7. `07_trigger_auditoria.sql` — Compilação da Trigger de auditoria DML.
8. `08_testes_validacao_excecoes.sql` — Execução dos testes de caso de uso e disparo de exceções tratadas.
9. `2TDSPG_2026_CodigoSql_PetGuardian.sql` — Script consolidado para entrega.
10. `run_all.sql` — Execução em lote de toda a esteira de scripts.
