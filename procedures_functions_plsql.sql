SET SERVEROUTPUT ON

-- 1. Criar procedimento para inserir um novo projeto
-- Este procedimento insere um novo projeto na tabela `brh.projeto`, 
-- definindo o nome e o responsável pelo projeto, com a data de início como a data atual e a data de término como NULL.
CREATE OR REPLACE PROCEDURE brh.insere_projeto
(p_nome IN brh.projeto.nome%type, p_responsavel IN brh.projeto.responsavel%type)
IS
BEGIN
INSERT INTO brh.projeto (nome, responsavel, inicio, fim)
VALUES (p_nome, p_responsavel, SYSDATE, NULL);
END;

-- Execução do procedimento para inserir um projeto chamado 'BI' com responsável 'A123'
EXECUTE brh.insere_projeto('BI','A123');

-- 2. Criar função para calcular a idade com base na data de nascimento
-- Esta função calcula a idade de uma pessoa com base na data de nascimento fornecida, 
-- retornando a idade em anos completos.
CREATE OR REPLACE FUNCTION brh.calcula_idade
(p_data DATE)
RETURN FLOAT
IS
v_idade FLOAT;
BEGIN
    v_idade := FLOOR(MONTHS_BETWEEN(SYSDATE, p_data) / 12);
    RETURN v_idade;
END;

-- Exemplo de uso da função para calcular a idade de uma pessoa nascida em '01/10/2001'
DECLARE
v_idade FLOAT;
BEGIN
v_idade := brh.calcula_idade(TO_DATE('01/10/2001', 'DD/MM/YYYY'));
dbms_output.put_line(v_idade);
END;

-- 3. Criar função para finalizar um projeto
-- Esta função verifica se um projeto já possui uma data de término. 
-- Se não tiver, a função atualiza o campo `fim` com a data atual e retorna a data de término.
CREATE OR REPLACE FUNCTION brh.finaliza_projeto
(p_id IN brh.projeto.id%type)
RETURN brh.projeto.fim%type 
IS
v_data_termino brh.projeto.fim%type;
BEGIN
    SELECT fim INTO v_data_termino FROM brh.projeto WHERE id = p_id;
    IF v_data_termino IS NOT NULL THEN
        dbms_output.put_line(v_data_termino);
        RETURN v_data_termino;
    ELSE
        UPDATE brh.projeto SET fim = SYSDATE WHERE id = p_id;
        v_data_termino := SYSDATE;
        dbms_output.put_line(v_data_termino);
        RETURN v_data_termino;
    END IF;
END;

-- Exemplo de uso da função para finalizar o projeto com ID 45
DECLARE
v_tp DATE;
BEGIN
v_tp := brh.finaliza_projeto(45);
END;

-- 4. Criar procedimento com validação de nome de projeto
-- Este procedimento insere um novo projeto na tabela `brh.projeto`, 
-- mas somente se o nome do projeto for válido (ou seja, tiver dois ou mais caracteres).
CREATE OR REPLACE PROCEDURE brh.insere_projeto
(p_nome IN brh.projeto.nome%type, p_responsavel IN brh.projeto.responsavel%type)
IS
v_saida VARCHAR2(144);
BEGIN
IF LENGTH(p_nome) < 2 OR p_nome IS NULL THEN
    v_saida := 'Nome de projeto inválido! Deve ter dois ou mais caracteres.';
    dbms_output.put_line(v_saida);
ELSE 
    INSERT INTO brh.projeto (nome, responsavel, inicio, fim)
    VALUES (p_nome, p_responsavel, SYSDATE, NULL);
END IF;
END;

-- Execução do procedimento para tentar inserir um projeto com nome inválido (NULL) e responsável 'A123'
EXECUTE brh.insere_projeto(NULL, 'A123');

-- 5. Criar função com validação de data para cálculo de idade
-- Esta função calcula a idade de uma pessoa com base na data de nascimento fornecida, 
-- mas retorna NULL e exibe uma mensagem de erro se a data for inválida (futura ou NULL).
CREATE OR REPLACE FUNCTION brh.calcula_idade
(p_data DATE)
RETURN FLOAT
IS
v_idade FLOAT;
BEGIN
IF p_data > SYSDATE OR p_data IS NULL THEN
    dbms_output.put_line('Impossível calcular idade! Data inválida: ' || p_data);
    RETURN NULL;
ELSE
    v_idade := FLOOR(MONTHS_BETWEEN(SYSDATE, p_data) / 12);
    RETURN v_idade;
END IF;
END;

-- Exemplo de uso da função com data inválida (NULL)
DECLARE
v_idade FLOAT;
BEGIN
v_idade := brh.calcula_idade(NULL);
dbms_output.put_line(v_idade);
END;

-- 6. Criar procedimento para definir a atribuição de um colaborador a um projeto
-- Este procedimento insere uma atribuição de colaborador a um projeto com um papel específico, 
-- verificando se o colaborador, o projeto e o papel existem na base de dados. 
-- Se o papel não existir, ele é adicionado à tabela `brh.papel`.
CREATE OR REPLACE PROCEDURE brh.define_atribuicao
(p_colaborador IN brh.colaborador.nome%type,
 p_projeto IN brh.projeto.nome%type,
 p_papel IN brh.papel.nome%type)
IS
v_colaborador brh.colaborador.matricula%type;
v_projeto brh.projeto.id%type;
v_papel brh.papel.id%type;
CURSOR cur_colab IS SELECT matricula FROM brh.colaborador WHERE nome = p_colaborador;
CURSOR cur_projeto IS SELECT id FROM brh.projeto WHERE nome = p_projeto;
CURSOR cur_papel IS SELECT id FROM brh.papel WHERE nome = p_papel;
BEGIN
OPEN cur_colab;
FETCH cur_colab INTO v_colaborador;
IF cur_colab%FOUND THEN 
    CLOSE cur_colab;
    OPEN cur_projeto;
    FETCH cur_projeto INTO v_projeto;
    IF cur_projeto%FOUND THEN
        CLOSE cur_projeto;
        OPEN cur_papel;
        FETCH cur_papel INTO v_papel;
        IF cur_papel%FOUND THEN
            CLOSE cur_papel;
            INSERT INTO brh.atribuicao (colaborador, projeto, papel)
            VALUES (v_colaborador, v_projeto, v_papel);
        ELSE
            INSERT INTO brh.papel (nome)
            VALUES (p_papel);
            -- Reabrir o cursor para buscar o ID do novo papel
            OPEN cur_papel;
            FETCH cur_papel INTO v_papel;
            CLOSE cur_papel;
            -- Inserir a atribuição com o novo papel
            INSERT INTO brh.atribuicao (colaborador, projeto, papel)
            VALUES (v_colaborador, v_projeto, v_papel);
        END IF;
    ELSE
        dbms_output.put_line('Projeto inexistente: ' || p_projeto);
    END IF;
ELSE
    dbms_output.put_line('Colaborador inexistente: ' || p_colaborador);
END IF;
END;

-- Execução do procedimento para atribuir o colaborador 'Xena' ao projeto 'BRH' com papel 'DBA'
EXECUTE brh.define_atribuicao('Xena', 'BRH', 'DBA');
