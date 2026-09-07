
-- SCRIPT DE CARGA INICIAL DE DADOS - CHALLENGE 2026 (SPRINT 3)
-- mínimo de 5 registros válidos por tabela

-- 1. Tabela RACA
INSERT INTO raca (id_raca, nm_raca, porte, especie) VALUES (1, 'Vira-lata / SRD', 'Médio', 'Cão');
INSERT INTO raca (id_raca, nm_raca, porte, especie) VALUES (2, 'Golden Retriever', 'Grande', 'Cão');
INSERT INTO raca (id_raca, nm_raca, porte, especie) VALUES (3, 'Pug', 'Pequeno', 'Cão');
INSERT INTO raca (id_raca, nm_raca, porte, especie) VALUES (4, 'Persa', 'Pequeno', 'Gato');
INSERT INTO raca (id_raca, nm_raca, porte, especie) VALUES (5, 'Siames', 'Pequeno', 'Gato');

-- 2. Tabela USUARIO
INSERT INTO usuario (id_usuario, nm_usuario, email, senha, role, dt_cadastro) VALUES (1, 'Carlos Silva', 'carlos.silva@email.com', 'Senha#123', 'PREMIUM', SYSDATE - 30);
INSERT INTO usuario (id_usuario, nm_usuario, email, senha, role, dt_cadastro) VALUES (2, 'Mariana Oliveira', 'mariana.o@email.com', 'Senha#456', 'COMUM', SYSDATE - 20);
INSERT INTO usuario (id_usuario, nm_usuario, email, senha, role, dt_cadastro) VALUES (3, 'Roberto Santos', 'roberto.s@email.com', 'Senha#789', 'PREMIUM', SYSDATE - 15);
INSERT INTO usuario (id_usuario, nm_usuario, email, senha, role, dt_cadastro) VALUES (4, 'Fernanda Costa', 'fernanda.c@email.com', 'Senha#101', 'COMUM', SYSDATE - 10);
INSERT INTO usuario (id_usuario, nm_usuario, email, senha, role, dt_cadastro) VALUES (5, 'Lucas Mendes', 'lucas.m@email.com', 'Senha#202', 'COMUM', SYSDATE - 5);

-- 3. Tabela PET
INSERT INTO pet (id_pet, nm_pet, idade, peso, usuario_id_usuario, raca_id_raca) VALUES (1, 'Thor', 3, 28.5, 1, 2);
INSERT INTO pet (id_pet, nm_pet, idade, peso, usuario_id_usuario, raca_id_raca) VALUES (2, 'Mel', 5, 12.0, 1, 1);
INSERT INTO pet (id_pet, nm_pet, idade, peso, usuario_id_usuario, raca_id_raca) VALUES (3, 'Bob', 2, 7.8, 2, 3);
INSERT INTO pet (id_pet, nm_pet, idade, peso, usuario_id_usuario, raca_id_raca) VALUES (4, 'Mimi', 4, 4.2, 3, 4);
INSERT INTO pet (id_pet, nm_pet, idade, peso, usuario_id_usuario, raca_id_raca) VALUES (5, 'Luna', 1, 3.5, 4, 5);

-- 4. Tabela STATUS
INSERT INTO status (id_status, ds_status) VALUES (1, 'Pendente');
INSERT INTO status (id_status, ds_status) VALUES (2, 'Em Andamento');
INSERT INTO status (id_status, ds_status) VALUES (3, 'Concluída');
INSERT INTO status (id_status, ds_status) VALUES (4, 'Atrasada');
INSERT INTO status (id_status, ds_status) VALUES (5, 'Cancelada');

-- 5. Tabela TRILHA
INSERT INTO trilha (id_trilha, nm_trilha, ds_trilha) VALUES (1, 'Cuidados Básicos Cães', 'Trilha para tutores iniciantes de cães');
INSERT INTO trilha (id_trilha, nm_trilha, ds_trilha) VALUES (2, 'Alimentação e Nutrição', 'Guia completo de saúde alimentar animal');
INSERT INTO trilha (id_trilha, nm_trilha, ds_trilha) VALUES (3, 'Adestramento e Comportamento', 'Técnicas de adestramento positivo');
INSERT INTO trilha (id_trilha, nm_trilha, ds_trilha) VALUES (4, 'Cuidados com Felinos', 'Especial sobre comportamento e saúde dos gatos');
INSERT INTO trilha (id_trilha, nm_trilha, ds_trilha) VALUES (5, 'Higiene e Bem-Estar', 'Rotinas de banho, tosa e higiene bucal');

-- 6. Tabela MODULO
INSERT INTO modulo (id_modulo, nm_modulo, trilha_id_trilha) VALUES (1, 'Vacinação e Vermifugação', 1);
INSERT INTO modulo (id_modulo, nm_modulo, trilha_id_trilha) VALUES (2, 'Ração e Petiscos', 2);
INSERT INTO modulo (id_modulo, nm_modulo, trilha_id_trilha) VALUES (3, 'Comandos Básicos', 3);
INSERT INTO modulo (id_modulo, nm_modulo, trilha_id_trilha) VALUES (4, 'Enriquecimento Ambiental Gatos', 4);
INSERT INTO modulo (id_modulo, nm_modulo, trilha_id_trilha) VALUES (5, 'Escovação e Banho', 5);

-- 7. Tabela AULA
INSERT INTO aula (id_aula, nm_aula, conteudo_url, modulo_id_modulo) VALUES (1, 'Calendário de Vacinas', 'https://petapp.com/aulas/1', 1);
INSERT INTO aula (id_aula, nm_aula, conteudo_url, modulo_id_modulo) VALUES (2, 'Como escolher a ração ideal', 'https://petapp.com/aulas/2', 2);
INSERT INTO aula (id_aula, nm_aula, conteudo_url, modulo_id_modulo) VALUES (3, 'Ensinando a sentar e dar a pata', 'https://petapp.com/aulas/3', 3);
INSERT INTO aula (id_aula, nm_aula, conteudo_url, modulo_id_modulo) VALUES (4, 'Arrachadores e nichos suspensos', 'https://petapp.com/aulas/4', 4);
INSERT INTO aula (id_aula, nm_aula, conteudo_url, modulo_id_modulo) VALUES (5, 'Frequência ideal de banhos', 'https://petapp.com/aulas/5', 5);

-- 8. Tabela HISTORICO
INSERT INTO historico (id_historico, dt_conclusao, usuario_id_usuario, aula_id_aula) VALUES (1, SYSDATE - 10, 1, 1);
INSERT INTO historico (id_historico, dt_conclusao, usuario_id_usuario, aula_id_aula) VALUES (2, SYSDATE - 8, 1, 2);
INSERT INTO historico (id_historico, dt_conclusao, usuario_id_usuario, aula_id_aula) VALUES (3, SYSDATE - 5, 2, 3);
INSERT INTO historico (id_historico, dt_conclusao, usuario_id_usuario, aula_id_aula) VALUES (4, SYSDATE - 3, 3, 4);
INSERT INTO historico (id_historico, dt_conclusao, usuario_id_usuario, aula_id_aula) VALUES (5, SYSDATE - 1, 4, 5);

-- 9. Tabela TAREFA (Fato principal)
INSERT INTO tarefa (id_tarefa, nm_tarefa, ds_tarefa, pontos, dt_limite, pet_id_pet, status_id_status) 
VALUES (1, 'Passeio Matinal', 'Caminhar 30 minutos no parque', 15, SYSDATE + 1, 1, 1);

INSERT INTO tarefa (id_tarefa, nm_tarefa, ds_tarefa, pontos, dt_limite, pet_id_pet, status_id_status) 
VALUES (2, 'Dar Vermífugo', 'Ministrar comprimido de vermífugo', 50, SYSDATE + 2, 1, 1);

INSERT INTO tarefa (id_tarefa, nm_tarefa, ds_tarefa, pontos, dt_limite, pet_id_pet, status_id_status) 
VALUES (3, 'Escovação de Pelos', 'Escovar o pelo para evitar nós', 10, SYSDATE - 1, 2, 3);

INSERT INTO tarefa (id_tarefa, nm_tarefa, ds_tarefa, pontos, dt_limite, pet_id_pet, status_id_status) 
VALUES (4, 'Corte de Unhas', 'Levar ao petshop para cortar unhas', 30, SYSDATE + 5, 3, 2);

INSERT INTO tarefa (id_tarefa, nm_tarefa, ds_tarefa, pontos, dt_limite, pet_id_pet, status_id_status) 
VALUES (5, 'Limpeza da Caixa de Areia', 'Higienizar caixa de areia do gato', 20, SYSDATE, 4, 3);

COMMIT;