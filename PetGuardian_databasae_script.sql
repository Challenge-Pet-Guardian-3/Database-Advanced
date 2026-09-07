-- SCRIPT DE BANCO DE DADOS RELACIONAL - CHALLENGE 2026 (SPRINT 3)

-- DDL - CRIAÇÃO DAS TABELAS

CREATE TABLE raca (
    id_raca NUMBER PRIMARY KEY,
    nm_raca VARCHAR2(50) NOT NULL,
    porte VARCHAR2(20),
    especie VARCHAR2(30) NOT NULL
);

CREATE TABLE usuario (
    id_usuario NUMBER PRIMARY KEY,
    nm_usuario VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    senha VARCHAR2(100) NOT NULL,
    role VARCHAR2(20) DEFAULT 'COMUM' CHECK (role IN ('COMUM', 'PREMIUM')),
    dt_cadastro DATE DEFAULT SYSDATE NOT NULL
);

CREATE TABLE pet (
    id_pet NUMBER PRIMARY KEY,
    nm_pet VARCHAR2(50) NOT NULL,
    idade NUMBER,
    peso NUMBER(5,2),
    usuario_id_usuario NUMBER NOT NULL,
    raca_id_raca NUMBER NOT NULL,
    CONSTRAINT fk_pet_usuario FOREIGN KEY (usuario_id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_pet_raca FOREIGN KEY (raca_id_raca) REFERENCES raca(id_raca)
);

CREATE TABLE status (
    id_status NUMBER PRIMARY KEY,
    ds_status VARCHAR2(30) NOT NULL
);

CREATE TABLE trilha (
    id_trilha NUMBER PRIMARY KEY,
    nm_trilha VARCHAR2(100) NOT NULL,
    ds_trilha VARCHAR2(255)
);

CREATE TABLE modulo (
    id_modulo NUMBER PRIMARY KEY,
    nm_modulo VARCHAR2(100) NOT NULL,
    trilha_id_trilha NUMBER NOT NULL,
    CONSTRAINT fk_modulo_trilha FOREIGN KEY (trilha_id_trilha) REFERENCES trilha(id_trilha)
);

CREATE TABLE aula (
    id_aula NUMBER PRIMARY KEY,
    nm_aula VARCHAR2(100) NOT NULL,
    conteudo_url VARCHAR2(255),
    modulo_id_modulo NUMBER NOT NULL,
    CONSTRAINT fk_aula_modulo FOREIGN KEY (modulo_id_modulo) REFERENCES modulo(id_modulo)
);

CREATE TABLE historico (
    id_historico NUMBER PRIMARY KEY,
    dt_conclusao DATE DEFAULT SYSDATE NOT NULL,
    usuario_id_usuario NUMBER NOT NULL,
    aula_id_aula NUMBER NOT NULL,
    CONSTRAINT fk_historico_usuario FOREIGN KEY (usuario_id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_historico_aula FOREIGN KEY (aula_id_aula) REFERENCES aula(id_aula)
);

CREATE TABLE tarefa (
    id_tarefa NUMBER PRIMARY KEY,
    nm_tarefa VARCHAR2(100) NOT NULL,
    ds_tarefa VARCHAR2(255),
    pontos NUMBER DEFAULT 0 NOT NULL,
    dt_limite DATE,
    pet_id_pet NUMBER NOT NULL,
    status_id_status NUMBER NOT NULL,
    CONSTRAINT fk_tarefa_pet FOREIGN KEY (pet_id_pet) REFERENCES pet(id_pet),
    CONSTRAINT fk_tarefa_status FOREIGN KEY (status_id_status) REFERENCES status(id_status)
);

-- Tabela de Auditoria DML
CREATE TABLE tarefa_auditoria (
    id_auditoria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tp_operacao VARCHAR2(10) NOT NULL,
    dt_operacao TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    nm_usuario_bd VARCHAR2(50) DEFAULT USER NOT NULL,
    id_tarefa NUMBER,
    nm_tarefa_old VARCHAR2(100),
    nm_tarefa_new VARCHAR2(100),
    pontos_old NUMBER,
    pontos_new NUMBER
);

/

-- FUNCTIONS E PROCEDURES INDIVIDUAIS-

-- function 1: conversão relacional para JSON manual
CREATE OR REPLACE FUNCTION fn_tarefa_json (
    p_id_tarefa IN NUMBER
) RETURN VARCHAR2 IS
    v_nm_tarefa   tarefa.nm_tarefa%TYPE;
    v_ds_tarefa   tarefa.ds_tarefa%TYPE;
    v_pontos      tarefa.pontos%TYPE;
    v_nm_pet      pet.nm_pet%TYPE;
    v_ds_status   status.ds_status%TYPE;
    v_json        VARCHAR2(4000);
    
    e_id_invalido    EXCEPTION;
    e_limite_memoria EXCEPTION;
BEGIN
    IF p_id_tarefa IS NULL OR p_id_tarefa <= 0 THEN
        RAISE e_id_invalido;
    END IF;

    SELECT t.nm_tarefa, t.ds_tarefa, t.pontos, p.nm_pet, s.ds_status
      INTO v_nm_tarefa, v_ds_tarefa, v_pontos, v_nm_pet, v_ds_status
      FROM tarefa t
      JOIN pet p ON t.pet_id_pet = p.id_pet
      JOIN status s ON t.status_id_status = s.id_status
     WHERE t.id_tarefa = p_id_tarefa;

    v_json := '{' ||
              '"id_tarefa":' || p_id_tarefa || ',' ||
              '"nm_tarefa":"' || v_nm_tarefa || '",' ||
              '"ds_tarefa":"' || NVL(v_ds_tarefa, '') || '",' ||
              '"pontos":' || v_pontos || ',' ||
              '"pet":"' || v_nm_pet || '",' ||
              '"status":"' || v_ds_status || '"' ||
              '}';

    IF LENGTH(v_json) > 3800 THEN
        RAISE e_limite_memoria;
    END IF;

    RETURN v_json;

EXCEPTION
    WHEN e_id_invalido THEN
        RAISE_APPLICATION_ERROR(-20001, 'ID da tarefa informado é inválido.');
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nenhuma tarefa encontrada com o ID fornecido.');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Mais de uma tarefa encontrada para o mesmo ID.');
    WHEN e_limite_memoria THEN
        RAISE_APPLICATION_ERROR(-20004, 'O JSON gerado excedeu o limite seguro de memória.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20005, 'Erro inesperado ao gerar JSON: ' || SQLERRM);
END fn_tarefa_json;
/

-- procedure 1: listar tarefas formatadas em JSON com JOIN
CREATE OR REPLACE PROCEDURE pr_listar_tarefas_json (
    p_status_id IN NUMBER DEFAULT NULL
) IS
    CURSOR c_tarefas IS
        SELECT t.id_tarefa
          FROM tarefa t
         WHERE p_status_id IS NULL OR t.status_id_status = p_status_id;
         
    v_id_tarefa tarefa.id_tarefa%TYPE;
    v_json      VARCHAR2(4000);
    v_qtd       NUMBER := 0;
BEGIN
    OPEN c_tarefas;
    LOOP
        FETCH c_tarefas INTO v_id_tarefa;
        EXIT WHEN c_tarefas%NOTFOUND;
        
        v_json := fn_tarefa_json(v_id_tarefa);
        DBMS_OUTPUT.PUT_LINE(v_json);
        v_qtd := v_qtd + 1;
    END LOOP;
    CLOSE c_tarefas;

    IF v_qtd = 0 THEN
        DBMS_OUTPUT.PUT_LINE('{"mensagem": "Nenhuma tarefa encontrada para os parâmetros informados."}');
    END IF;

EXCEPTION
    WHEN CURSOR_ALREADY_OPEN THEN
        RAISE_APPLICATION_ERROR(-20006, 'O cursor de busca de tarefas já se encontra aberto.');
    WHEN OTHERS THEN
        IF c_tarefas%ISOPEN THEN
            CLOSE c_tarefas;
        END IF;
        RAISE_APPLICATION_ERROR(-20007, 'Erro na execução da listagem de tarefas: ' || SQLERRM);
END pr_listar_tarefas_json;
/

-- function 2: regra de negócio - classificação de pontos
CREATE OR REPLACE FUNCTION fn_classificar_pontos (
    p_pontos IN NUMBER
) RETURN VARCHAR2 IS
    v_classificacao VARCHAR2(20);
    e_valor_negativo EXCEPTION;
    e_valor_excedente EXCEPTION;
BEGIN
    IF p_pontos IS NULL THEN
        RETURN 'NÃO DEFINIDA';
    ELSIF p_pontos < 0 THEN
        RAISE e_valor_negativo;
    ELSIF p_pontos > 1000 THEN
        RAISE e_valor_excedente;
    END IF;

    IF p_pontos <= 10 THEN
        v_classificacao := 'BAIXA';
    ELSIF p_pontos <= 30 THEN
        v_classificacao := 'MÉDIA';
    ELSIF p_pontos <= 60 THEN
        v_classificacao := 'ALTA';
    ELSE
        v_classificacao := 'MUITO ALTA';
    END IF;

    RETURN v_classificacao;

EXCEPTION
    WHEN e_valor_negativo THEN
        RAISE_APPLICATION_ERROR(-20008, 'Pontuação não pode ser um número negativo.');
    WHEN e_valor_excedente THEN
        RAISE_APPLICATION_ERROR(-20009, 'Pontuação excede o limite máximo permitido de 1000 pontos.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010, 'Erro ao classificar a pontuação da tarefa: ' || SQLERRM);
END fn_classificar_pontos;
/

-- procedure 2: agrupamento com subtotais e total geral
CREATE OR REPLACE PROCEDURE pr_resumo_pontos_tarefas IS
    CURSOR c_resumo IS
        SELECT t.pet_id_pet, p.nm_pet, t.status_id_status, s.ds_status, t.pontos
          FROM tarefa t
          JOIN pet p ON t.pet_id_pet = p.id_pet
          JOIN status s ON t.status_id_status = s.id_status
         ORDER BY t.pet_id_pet, t.status_id_status;

    r_reg c_resumo%ROWTYPE;

    v_pet_atual       pet.id_pet%TYPE := NULL;
    v_nm_pet_atual    pet.nm_pet%TYPE := NULL;
    
    v_subtotal_pet    NUMBER := 0;
    v_total_geral     NUMBER := 0;
    v_contador_registros NUMBER := 0;

    e_sem_dados EXCEPTION;
BEGIN
    OPEN c_resumo;
    
    FETCH c_resumo INTO r_reg;
    IF c_resumo%NOTFOUND THEN
        CLOSE c_resumo;
        RAISE e_sem_dados;
    END IF;

    DBMS_OUTPUT.PUT_LINE('--- RESUMO DE PONTUAÇÃO DE TAREFAS POR PET ---');

    WHILE c_resumo%FOUND LOOP
        IF v_pet_atual IS NULL OR v_pet_atual <> r_reg.pet_id_pet THEN
            IF v_pet_atual IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE('>> SUBTOTAL (' || v_nm_pet_atual || '): ' || v_subtotal_pet || ' PONTOS');
                DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
                v_subtotal_pet := 0;
            END IF;
            
            v_pet_atual := r_reg.pet_id_pet;
            v_nm_pet_atual := r_reg.nm_pet;
            DBMS_OUTPUT.PUT_LINE('PET: ' || r_reg.nm_pet);
        END IF;

        DBMS_OUTPUT.PUT_LINE('  - Status: ' || r_reg.ds_status || ' | Pontos: ' || r_reg.pontos || ' (' || fn_classificar_pontos(r_reg.pontos) || ')');

        v_subtotal_pet := v_subtotal_pet + r_reg.pontos;
        v_total_geral := v_total_geral + r_reg.pontos;
        v_contador_registros := v_contador_registros + 1;

        FETCH c_resumo INTO r_reg;
    END LOOP;

    IF v_pet_atual IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('>> SUBTOTAL (' || v_nm_pet_atual || '): ' || v_subtotal_pet || ' PONTOS');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
    END IF;

    DBMS_OUTPUT.PUT_LINE('===========================================');
    DBMS_OUTPUT.PUT_LINE('TOTAL GERAL DE PONTOS: ' || v_total_geral || ' PONTOS');
    DBMS_OUTPUT.PUT_LINE('TOTAL DE TAREFAS PROCESSADAS: ' || v_contador_registros);
    DBMS_OUTPUT.PUT_LINE('===========================================');

    CLOSE c_resumo;

EXCEPTION
    WHEN e_sem_dados THEN
        RAISE_APPLICATION_ERROR(-20011, 'Nenhum registro de tarefa foi encontrado para geração do resumo.');
    WHEN VALUE_ERROR THEN
        RAISE_APPLICATION_ERROR(-20012, 'Erro de conversão de valor numérico durante a soma dos totais.');
    WHEN OTHERS THEN
        IF c_resumo%ISOPEN THEN
            CLOSE c_resumo;
        END IF;
        RAISE_APPLICATION_ERROR(-20013, 'Erro durante o cálculo de subtotais do resumo: ' || SQLERRM);
END pr_resumo_pontos_tarefas;
/

-- trigger de auditoria

CREATE OR REPLACE TRIGGER trg_audit_tarefa
AFTER INSERT OR UPDATE OR DELETE ON tarefa
FOR EACH ROW
DECLARE
    v_tp_operacao VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_tp_operacao := 'INSERT';
        INSERT INTO tarefa_auditoria (tp_operacao, id_tarefa, nm_tarefa_new, pontos_new)
        VALUES (v_tp_operacao, :NEW.id_tarefa, :NEW.nm_tarefa, :NEW.pontos);
    ELSIF UPDATING THEN
        v_tp_operacao := 'UPDATE';
        INSERT INTO tarefa_auditoria (tp_operacao, id_tarefa, nm_tarefa_old, nm_tarefa_new, pontos_old, pontos_new)
        VALUES (v_tp_operacao, :NEW.id_tarefa, :OLD.nm_tarefa, :NEW.nm_tarefa, :OLD.pontos, :NEW.pontos);
    ELSIF DELETING THEN
        v_tp_operacao := 'DELETE';
        INSERT INTO tarefa_auditoria (tp_operacao, id_tarefa, nm_tarefa_old, pontos_old)
        VALUES (v_tp_operacao, :OLD.id_tarefa, :OLD.nm_tarefa, :OLD.pontos);
    END IF;
END trg_audit_tarefa;
/