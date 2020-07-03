-- AVALIAÇÃO FINAL DE LABORATÓRIO DE BANCO DE DADOS

-- Aluno: Wesley de Oliveira Mendes
-- Código: 828.507


----------
-- 1. Considerando o Modelo Entidade Relacionamento (MER) apresentado na Figura 1, 
--   desenvolver os scripts para criar as tabelas, definindo chaves primárias e estrangeiras e a validação de atributos não nulos. 
--   Considerar a sequência correta para criação das tabelas (2.0 pontos)
-- Atributos não nulos: tabela FUNCIONARIO - atributos NOM_FUNCIONARIO e CTPS_FUNCIONARIO; tabela PROJETO - atributo TIT_PROJETO; tabela CARGO – atributo NOM_CARGO.
-- (*) os atributos definidos como NUMERIC no MER deverão ser considerados como NUMBER.
CREATE TABLE FUNCIONARIO(
    cod_funcionario INTEGER,    -- (PK)
    nom_funcionario VARCHAR(40) NOT NULL,  -- Foi utilizado 'NOT NULL', pois esse atributo não pode ser nulo no registro de um FUNCIONARIO.
    dtn_funcionario DATE,
    dta_funcionario DATE,
    ctps_funcionario VARCHAR(13) NOT NULL,  -- Foi utilizado 'NOT NULL', pois esse atributo não pode ser nulo no registro de um FUNCIONARIO.
    CONSTRAINT pk_funcionario PRIMARY KEY (cod_funcionario)  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
);

CREATE TABLE PROJETO(
    num_projeto INTEGER,    -- (PK)
    tit_projeto VARCHAR(50) NOT NULL,  -- Foi utilizado 'NOT NULL', pois esse atributo não pode ser nulo no registro de um PROJETO.
    dsc_projeto VARCHAR(250),
    dti_projeto DATE,
    dtf_projeto DATE,
    CONSTRAINT pk_projeto PRIMARY KEY (num_projeto)  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
);

CREATE TABLE CARGO(
    cod_cargo INTEGER,  -- (PK)
    nom_cargo VARCHAR(20) NOT NULL,  -- Foi utilizado 'NOT NULL', pois esse atributo não pode ser nulo no registro de um CARGO.
    CONSTRAINT pk_cargo PRIMARY KEY (cod_cargo)  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
);

CREATE TABLE FUNC_CARGO(
    cod_funcionario INTEGER,    -- (FK)(PK)
    cod_cargo INTEGER,          -- (FK)(PK)
    dti_func_projeto DATE,
    CONSTRAINT pk_func_cargo PRIMARY KEY (cod_funcionario, cod_cargo),  -- Neste caso, existem duas chaves primarias que também são chaves estrangeiras, ou seja, estas chaves fazem referência a duas tabelas com está terceira.
    CONSTRAINT fk_func_cargo_funcionario FOREIGN KEY (cod_funcionario) REFERENCES FUNCIONARIO,
    CONSTRAINT fk_func_cargo_cargo FOREIGN KEY (cod_cargo) REFERENCES CARGO
);

CREATE TABLE FUNC_PROJETO(
    cod_funcionario INTEGER,    -- (FK)(PK)
    num_projeto INTEGER,        -- (FK)(PK)
    CONSTRAINT pk_func_projeto PRIMARY KEY (cod_funcionario, num_projeto),  -- Neste caso, existem duas chaves primarias que também são chaves estrangeiras, ou seja, estas chaves fazem referência a duas tabelas com está terceira.
    CONSTRAINT fk_func_projeto_funcionario FOREIGN KEY (cod_funcionario) REFERENCES FUNCIONARIO,
    CONSTRAINT fk_func_projeto_projeto FOREIGN KEY (num_projeto) REFERENCES PROJETO
);

CREATE TABLE DESPESA(
    num_despesa INTEGER,    -- (PK)
    num_projeto INTEGER,    -- (FK)
    dta_despesa DATE,
    vlr_despesa NUMBER(9,2),
    dsc_despesa VARCHAR(30),
    CONSTRAINT pk_despesa PRIMARY KEY (num_despesa),  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
    CONSTRAINT fk_despesa_projeto FOREIGN KEY (num_projeto) REFERENCES PROJETO  -- Esta chave estrangeira faz referência a um projeto já existente que será o projeto de origem de uma despesa específica, é uma forma de referenciar duas tabelas.
);

COMMIT;


----------
-- 2. Mostrar o valor total das despesas do projeto intitulado "Biblioteca da Unaerp" (1.0 ponto).
SELECT P.tit_projeto PROJETO, SUM(D.vlr_despesa) TOTAL 
FROM PROJETO P, DESPESA D
WHERE P.num_projeto = D.num_projeto
GROUP BY P.tit_projeto HAVING P.tit_projeto = 'Biblioteca da Unaerp';
-- Neste comando é realizado uma soma de todos os valores da despesa, organizando na coluna 'TOTAL'.
-- Para realizar a soma, foi filtrado por título de PROJETO, especificando a soma das despesas apenas de um projeto específico.
-- Também foi agrupado o resultado pelo título do projeto.


----------
-- 3. Mostrar o nome dos funcionários e o nome dos seus respectivos cargos daqueles 
--  que estão alocados no projeto intitulado "Biblioteca da Unaerp" (1.0 ponto).
SELECT F.nom_funcionario FUNCIONARIO, C.nom_cargo CARGO 
FROM FUNCIONARIO F, CARGO C, FUNC_CARGO FC, PROJETO P, FUNC_PROJETO FP
WHERE FC.cod_funcionario = F.cod_funcionario
AND FC.cod_cargo = C.cod_cargo
AND FP.cod_funcionario = F.cod_funcionario
AND FP.num_projeto = P.num_projeto
AND P.tit_projeto = 'Biblioteca da Unaerp';
-- Neste comando foi utilizado os aliases 'FUNCIONARIO' e 'CARGO' para organizar o output da query.
-- Para chegar ao resultado esperado, foram feitas várias verificações de igualdade a fim de filtrar o resultado.


----------
-- 4. Elaborar um procedimento para mostrar a quantidade de dias para a execução de um 
--  projeto (duração do projeto), considerar a data inicial e a data final do projeto (2.0 pontos).
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE qtd_dias(nprojeto IN PROJETO.num_projeto%TYPE)
IS
total_days NUMBER;
BEGIN
    SELECT FLOOR(TO_DATE(dtf_projeto)-TO_DATE(dti_projeto)) INTO total_days 
    FROM PROJETO WHERE num_projeto = nprojeto;
    DBMS_OUTPUT.PUT_LINE(total_days || ' dias para a execução do projeto.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ou num_projeto inexistente...');
END;
/

COMMIT;

-- Testes
exec qtd_dias(1);
exec qtd_dias(2);
exec qtd_dias(3);
-- Neste comando, é criado um procedimento para mostrar, a partir do 'id' de um item já existente a quantidade em dias para a execução de um projeto.
-- é declarado uma variável 'total_days' do tipo NUMBER, da qual recebera a quantidade de dias, determinada por uma lógica aritmética,
-- da diferença da data final de um item existente com a data inicial, o output é concatenado com uma string específica.
-- Caso ocorra algum tipo de erro, como por exemplo o item não existir é mostrado uma outra mensagem específica.
-- Para que o console possa mostrar estas mensagens, antes de executar o comando, foi utilizado o comando 'SET SERVEROUTPUT ON;' para ativar está opção.


----------
-- 5. Elaborar um gatilho para inserir automaticamente a data final do projeto no momento do cadastro de um novo projeto. 
--   Devido a Pandemia do COVID 19 a diretoria determinou que todos os projetos com data de início no ano de 2020 terá duração de 1 ano (2.0 pontos).
CREATE OR REPLACE TRIGGER TRG_CAD_PROJETO
BEFORE INSERT OR UPDATE
ON PROJETO
FOR EACH ROW
BEGIN
    IF EXTRACT(YEAR FROM :NEW.dti_projeto) = '2020' THEN
        :NEW.dtf_projeto := ADD_MONTHS(:NEW.dti_projeto, 12);
    END IF;
END;
/

COMMIT;

-- Testes
INSERT INTO PROJETO VALUES (seq_num_projeto.NEXTVAL, 'Multiatendimento da Unaerp', 'Atendimento de alunos para resolver assuntos em geral.', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2020-06-01', 'YYYY-MM-DD'));
INSERT INTO PROJETO VALUES (seq_num_projeto.NEXTVAL, 'Estacionamento da Unaerp', 'Para os alunos assistirem as aulas sem preocupações.', TO_DATE('2020-07-21', 'YYYY-MM-DD'), TO_DATE('2020-12-22', 'YYYY-MM-DD'));

UPDATE PROJETO SET dti_projeto = TO_DATE('2020-04-21', 'YYYY-MM-DD') WHERE num_projeto = 3;

SELECT num_projeto, tit_projeto, dti_projeto, dtf_projeto FROM PROJETO WHERE EXTRACT(YEAR FROM dti_projeto) = '2020' ORDER BY num_projeto ASC;
-- Este trigger faz uma verificação em cima do ano inicial de um projeto, para que antes de inserir ou atualizar um item na tabela
-- seja impedido e uma data final do projeto especifica seja adicionada, ao invés de qualquer data passada.
-- Para isso é extraído o ano da data inicial e se for no ano de 2020, a data final é determinada com 12 meses a mais da data inicial.


----------
-- 6. Elaborar uma função para retornar a CTPS do funcionário formatada no padrão 999.999/99999-SP (2.0 pontos)
-- Função para retornar o documento do cliente formatado
CREATE OR REPLACE FUNCTION FORMATA_CTPS(vctps IN CLIENTE.doc_cliente%TYPE)
RETURN VARCHAR2
IS
vctpsformat VARCHAR2(19);
BEGIN
IF (LENGTH(vctps) = 13) THEN
    vctpsformat := SUBSTR(vctps, 1, 3) || '.' || SUBSTR(vctps, 4, 3) || '/' || SUBSTR(vctps, 7, 5) || '-' || SUBSTR(vctps, 12);
ELSE
    vctpsformat := vctps;
END IF;
RETURN vctpsformat;
END;
/

COMMIT;

-- Testes
SELECT nom_funcionario, FORMATA_CTPS(ctps_funcionario) CTPS FROM FUNCIONARIO;
-- Neste comando é criado uma função para retornar o CPTS de um funcionário já existente na tabela.
-- É criado uma variável do tipo VARCHAR2 com tamanho máximo de 19 caracteres.
-- Então o comando começa verificando se o CPTS do usuário possui a quantidade de caracteres corretas.
-- Caso a condição esteja correta, é adicionado a variável criado o valor formatado, 
-- utilizando a função SUBSTR() que funciona pegando a quantidade de caracteres especificada.
-- Caso a condição seja falsa, a variável recebe o próprio CTPS sem a formatação.
-- Por fim é retornado o valor da variável criada.



----------
-- SCRIPTS UTILIZADOS PARA TESTES.

-- FUNCIONARIO
CREATE SEQUENCE seq_cod_funcionario
START WITH 1
INCREMENT BY 1
NOCYCLE;

-- PROJETO
CREATE SEQUENCE seq_num_projeto
START WITH 1
INCREMENT BY 1
NOCYCLE;

-- CARGO
CREATE SEQUENCE seq_cod_cargo
START WITH 1
INCREMENT BY 1
NOCYCLE;

-- DESPESA
CREATE SEQUENCE seq_num_despesa
START WITH 1
INCREMENT BY 1
NOCYCLE;

-- DESPESA
CREATE SEQUENCE seq_num_projeto_despesa
START WITH 1
INCREMENT BY 1
MAXVALUE 3
MINVALUE 1
NOCACHE
CYCLE;

COMMIT;

-- cod_funcionario, nom_funcionario, dtn_funcionario, dta_funcionario, ctps_funcionario
INSERT INTO FUNCIONARIO VALUES (seq_cod_funcionario.NEXTVAL, 'Bohur', TO_DATE('1990-01-10', 'YYYY-MM-DD'), TO_DATE('2015-01-11', 'YYYY-MM-DD'), '21251735699SP');
INSERT INTO FUNCIONARIO VALUES (seq_cod_funcionario.NEXTVAL, 'Buose', TO_DATE('1991-02-20', 'YYYY-MM-DD'), TO_DATE('2016-02-12', 'YYYY-MM-DD'), '39959512773AC');
INSERT INTO FUNCIONARIO VALUES (seq_cod_funcionario.NEXTVAL, 'Luawo', TO_DATE('1992-03-30', 'YYYY-MM-DD'), TO_DATE('2017-03-13', 'YYYY-MM-DD'), '34942492251AL');
INSERT INTO FUNCIONARIO VALUES (seq_cod_funcionario.NEXTVAL, 'Luini', TO_DATE('1993-04-15', 'YYYY-MM-DD'), TO_DATE('2015-04-14', 'YYYY-MM-DD'), '78907965337GO');
INSERT INTO FUNCIONARIO VALUES (seq_cod_funcionario.NEXTVAL, 'Moisl', TO_DATE('1994-05-25', 'YYYY-MM-DD'), TO_DATE('2016-05-15', 'YYYY-MM-DD'), '59277446603DF');
INSERT INTO FUNCIONARIO VALUES (seq_cod_funcionario.NEXTVAL, 'Moyal', TO_DATE('1995-06-26', 'YYYY-MM-DD'), TO_DATE('2017-06-16', 'YYYY-MM-DD'), '83715390975AP');
INSERT INTO FUNCIONARIO VALUES (seq_cod_funcionario.NEXTVAL, 'Nilun', TO_DATE('1990-07-05', 'YYYY-MM-DD'), TO_DATE('2015-04-18', 'YYYY-MM-DD'), '79303839839MG');
INSERT INTO FUNCIONARIO VALUES (seq_cod_funcionario.NEXTVAL, 'Vaocu', TO_DATE('1991-08-09', 'YYYY-MM-DD'), TO_DATE('2016-03-14', 'YYYY-MM-DD'), '63299599163AM');
INSERT INTO FUNCIONARIO VALUES (seq_cod_funcionario.NEXTVAL, 'Xaika', TO_DATE('1994-09-13', 'YYYY-MM-DD'), TO_DATE('2017-02-25', 'YYYY-MM-DD'), '19818741874BA');
INSERT INTO FUNCIONARIO VALUES (seq_cod_funcionario.NEXTVAL, 'Zexar', TO_DATE('1996-10-11', 'YYYY-MM-DD'), TO_DATE('2017-06-20', 'YYYY-MM-DD'), '48183129685CE');

-- num_projeto, tit_projeto, dsc_projeto, dti_projeto, dtf_projeto
INSERT INTO PROJETO VALUES (seq_num_projeto.NEXTVAL, 'Biblioteca da Unaerp', 'Bibliteca com livros diversificados e salas online.', TO_DATE('2014-08-01', 'YYYY-MM-DD'), TO_DATE('2016-10-01', 'YYYY-MM-DD'));
INSERT INTO PROJETO VALUES (seq_num_projeto.NEXTVAL, 'Cantina da Unaerp', 'Cantina para alimentação dos alunos.', TO_DATE('2015-01-01', 'YYYY-MM-DD'), TO_DATE('2017-11-01', 'YYYY-MM-DD'));
INSERT INTO PROJETO VALUES (seq_num_projeto.NEXTVAL, 'Secretaria da Unaerp', 'Secretaria para orientar os alunos.', TO_DATE('2016-08-01', 'YYYY-MM-DD'), TO_DATE('2018-12-01', 'YYYY-MM-DD'));

-- cod_cargo, nom_cargo
INSERT INTO CARGO VALUES (seq_cod_cargo.NEXTVAL, 'Administrativo');
INSERT INTO CARGO VALUES (seq_cod_cargo.NEXTVAL, 'Atendente');
INSERT INTO CARGO VALUES (seq_cod_cargo.NEXTVAL, 'Auxiliar');
INSERT INTO CARGO VALUES (seq_cod_cargo.NEXTVAL, 'Bibliotecário');
INSERT INTO CARGO VALUES (seq_cod_cargo.NEXTVAL, 'Recepcionista');
INSERT INTO CARGO VALUES (seq_cod_cargo.NEXTVAL, 'Secretaria');

-- cod_funcionario, cod_cargo, dti_func_projeto
INSERT INTO FUNC_CARGO VALUES (1, 1, TO_DATE('2014-01-01', 'YYYY-MM-DD'));
INSERT INTO FUNC_CARGO VALUES (2, 2, TO_DATE('2015-01-01', 'YYYY-MM-DD'));
INSERT INTO FUNC_CARGO VALUES (3, 3, TO_DATE('2013-01-01', 'YYYY-MM-DD'));
INSERT INTO FUNC_CARGO VALUES (4, 4, TO_DATE('2014-01-01', 'YYYY-MM-DD'));
INSERT INTO FUNC_CARGO VALUES (5, 5, TO_DATE('2015-01-01', 'YYYY-MM-DD'));
INSERT INTO FUNC_CARGO VALUES (6, 6, TO_DATE('2013-01-01', 'YYYY-MM-DD'));
INSERT INTO FUNC_CARGO VALUES (7, 1, TO_DATE('2014-01-01', 'YYYY-MM-DD'));
INSERT INTO FUNC_CARGO VALUES (8, 2, TO_DATE('2015-01-01', 'YYYY-MM-DD'));
INSERT INTO FUNC_CARGO VALUES (9, 3, TO_DATE('2013-01-01', 'YYYY-MM-DD'));
INSERT INTO FUNC_CARGO VALUES (10, 4, TO_DATE('2014-01-01', 'YYYY-MM-DD'));

-- cod_funcionario, num_projeto
INSERT INTO FUNC_PROJETO VALUES (1, 1);
INSERT INTO FUNC_PROJETO VALUES (2, 1);
INSERT INTO FUNC_PROJETO VALUES (3, 1);
INSERT INTO FUNC_PROJETO VALUES (4, 2);
INSERT INTO FUNC_PROJETO VALUES (5, 2);
INSERT INTO FUNC_PROJETO VALUES (6, 2);
INSERT INTO FUNC_PROJETO VALUES (7, 3);
INSERT INTO FUNC_PROJETO VALUES (8, 3);
INSERT INTO FUNC_PROJETO VALUES (9, 1);
INSERT INTO FUNC_PROJETO VALUES (10, 1);
INSERT INTO FUNC_PROJETO VALUES (1, 2);
INSERT INTO FUNC_PROJETO VALUES (2, 3);
INSERT INTO FUNC_PROJETO VALUES (3, 2);

-- num_despesa, num_projeto, dta_despesa, vlr_despesa, dsc_despesa
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2014-04-06', 'YYYY-MM-DD'), 314.99, 'Folha sulfite.');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2015-04-06', 'YYYY-MM-DD'), 405.99, 'Canetas.');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2016-04-06', 'YYYY-MM-DD'), 330.99, 'Impressora');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2014-04-06', 'YYYY-MM-DD'), 480.99, 'Computador');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2015-03-06', 'YYYY-MM-DD'), 441.99, 'Estante');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2016-03-06', 'YYYY-MM-DD'), 185.99, 'Mesa');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2014-03-06', 'YYYY-MM-DD'), 341.99, 'Cadeira');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2015-03-06', 'YYYY-MM-DD'), 416.99, 'Escrivaninha');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2016-03-06', 'YYYY-MM-DD'), 461.99, 'Porta');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2014-01-06', 'YYYY-MM-DD'), 248.99, 'Sofá');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2015-07-06', 'YYYY-MM-DD'), 387.99, 'Monitore');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2016-07-06', 'YYYY-MM-DD'), 415.99, 'TV');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2017-07-06', 'YYYY-MM-DD'), 283.99, 'Cadeira de Madeira');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2018-08-06', 'YYYY-MM-DD'), 495.99, 'Sofá Simples');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2014-08-06', 'YYYY-MM-DD'), 347.99, 'Poltrona');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2015-09-06', 'YYYY-MM-DD'), 150.99, 'Mesa Pequena');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2016-10-06', 'YYYY-MM-DD'), 265.99, 'Mesa Grande');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2017-10-06', 'YYYY-MM-DD'), 459.99, 'Prateleiras');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2018-10-06', 'YYYY-MM-DD'), 316.99, 'Cadeira Giratória');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2014-07-06', 'YYYY-MM-DD'), 197.99, 'Notebook');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2015-03-06', 'YYYY-MM-DD'), 435.99, 'Ventilador');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2016-03-06', 'YYYY-MM-DD'), 109.99, 'Ventilador de Teto');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2017-05-06', 'YYYY-MM-DD'), 394.99, 'Rádio');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2018-05-06', 'YYYY-MM-DD'), 116.99, 'Telefone');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2014-05-06', 'YYYY-MM-DD'), 121.99, 'Celular');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2015-04-06', 'YYYY-MM-DD'), 372.99, 'Smartphone');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2016-04-06', 'YYYY-MM-DD'), 74.99, 'Fonte de Energia');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2017-04-06', 'YYYY-MM-DD'), 189.99, 'Calculadora');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2018-02-06', 'YYYY-MM-DD'), 66.99, 'Cadernos');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2014-08-06', 'YYYY-MM-DD'), 95.99, '´Lápis');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2014-06-06', 'YYYY-MM-DD'), 184.99, 'Tinta');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2015-04-06', 'YYYY-MM-DD'), 330.99, 'Borracha');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2016-05-06', 'YYYY-MM-DD'), 451.99, 'Impressora 3D');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2017-02-06', 'YYYY-MM-DD'), 464.99, 'Ventilador de Mesa');
INSERT INTO DESPESA VALUES (seq_num_despesa.NEXTVAL, seq_num_projeto_despesa.NEXTVAL, TO_DATE('2018-03-06', 'YYYY-MM-DD'), 310.99, 'Tomadas');

COMMIT;
