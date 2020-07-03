SELECT TABLE_NAME FROM USER_TABLES;
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS;

DROP SEQUENCE seq_cod_funcionario;
DROP SEQUENCE seq_num_projeto;
DROP SEQUENCE seq_cod_cargo;
DROP SEQUENCE seq_num_despesa;
DROP SEQUENCE seq_num_projeto_despesa;

DROP TABLE DESPESA;
DROP TABLE FUNC_PROJETO;
DROP TABLE FUNC_CARGO;
DROP TABLE CARGO;
DROP TABLE PROJETO;
DROP TABLE FUNCIONARIO;

SELECT * FROM FUNCIONARIO;
SELECT * FROM PROJETO;
SELECT * FROM CARGO;
SELECT * FROM FUNC_CARGO;
SELECT * FROM FUNC_PROJETO;
SELECT * FROM DESPESA;


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
