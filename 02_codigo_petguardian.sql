CREATE OR REPLACE PROCEDURE PR_LISTAR_CONTAS_JSON IS v_contador NUMBER := 0;
BEGIN
    FOR r IN (
        SELECT a.cod_agencia, a.nome_agencia, c.cod_conta, c.numero_conta, c.saldo
        FROM agencia a INNER JOIN conta c ON c.cod_agencia = a.cod_agencia ORDER BY a.cod_agencia, c.cod_conta
    )
    LOOP
        v_contador := v_contador + 1;

        DBMS_OUTPUT.PUT_LINE(FN_CONTA_JSON(
                r.cod_agencia,
                r.nome_agencia,
                r.cod_conta,
                r.numero_conta,
                r.saldo
            )
        );
    END LOOP;

    IF v_contador = 0 THEN RAISE NO_DATA_FOUND;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE(
        'ERRO: Nenhum registro de conta foi encontrado.'
    );

    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE(
        'ERRO: A consulta retornou registros em quantidade inesperada.'
    );

    WHEN VALUE_ERROR THEN DBMS_OUTPUT.PUT_LINE(
        'ERRO: Problema de conversão ou tamanho de variável.'
    );

    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(
        'ERRO inesperado: ' || SQLERRM
    );
END;
/