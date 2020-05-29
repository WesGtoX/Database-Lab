-- AVALIAÇÃO PARCIAL DE LABORATÓRIO DE BANCO DE DADOS

-- Aluno: Wesley de Oliveira Mendes
-- Código: 828.507


----------
-- 1. Elaborar um script para criar um tablespace com 10 MB para armazenar as tabelas do esquema VIAGEM. O tablespace deve 
--   ter como nome lógico “VIAGEM<seu código>” e nome físico viagem<seu código>.dbf. (0.50 ponto)
CREATE TABLESPACE "VIAGEM828507"
DATAFILE 'C:\app\Wesley\product\18.0.0\oradata\XE\viagem828507.dbf'
SIZE 10M;

COMMIT;

SELECT TABLESPACE_NAME from DBA_TABLESPACES;


----------
-- 2. Desenvolver um script para criar um usuário (o nome do usuário deve ser <seu código>AVP), 
--   definindo o tablespace default (tablespace criado) e o temporário (TEMP) (0.50 ponto).
ALTER SESSION SET "_ORACLE_SCRIPT"=true;  -- Esse comando foi usado pois no Oracle é necessário que um usuário comum inicie com 'C##' em seu nome, então esse comando é um parâmetro oculto para não ser mais necessário o 'C##' no início.


CREATE USER 828507AVP
IDENTIFIED BY "12345"
DEFAULT TABLESPACE "VIAGEM828507"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK
PROFILE DEFAULT;

COMMIT;

SELECT USERNAME, DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE 
FROM DBA_USERS 
WHERE USERNAME = '828507AVP';


----------
-- 3. Elaborar um script para atribuir o direito de administrador de banco de dados (DBA) ao usuário criado anteriormente (0.50 ponto);
GRANT DBA TO "828507AVP" WITH ADMIN OPTION;

COMMIT;

SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE LIKE '828507AVP';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = '828507AVP';


----------
-- 4. Considerando o Modelo Entidade Relacionamento (MER) apresentado na Figura 1, 
--   desenvolver os scripts para criar as tabelas, definindo chaves primárias e estrangeiras e a validação de atributos não nulos. 
--   Considerar a sequência correta para criação das tabelas (2.0 pontos)
-- Atributos não nulos: tabela CLIENTE - atributo NOM_CLIENTE; tabela AGENTE - atributo NOM_AGENTE; tabela CIDADE – atributos NOM_CIDADE e UF_CIDADE.
-- (*) os atributos definidos como NUMERIC no MER deverão ser considerados como NUMBER.
CREATE TABLE AGENTE(
    cod_agente NUMBER, -- (PK)
    nom_agente VARCHAR(35) NOT NULL,  -- Foi utilizado 'NOT NULL', pois esse atributo não pode ser nulo no registro de um AGENTE.
    dta_agente DATE,
    CONSTRAINT pk_agente PRIMARY KEY (cod_agente)  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
);

CREATE TABLE CLIENTE(
    cod_cliente NUMBER,    -- (PK)
    nom_cliente VARCHAR(35) NOT NULL,  -- Foi utilizado 'NOT NULL', pois esse atributo não pode ser nulo no registro de um CLIENTE.
    dtn_cliente DATE,
    CONSTRAINT pk_cliente PRIMARY KEY (cod_cliente)  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
);

CREATE TABLE TELEFONE(
    cod_cliente NUMBER,    -- (FK)(PK)
    num_telefone NUMBER,
    ddd_telefone NUMBER,
    CONSTRAINT pk_telefone PRIMARY KEY (cod_cliente),  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
    CONSTRAINT fk_telefone_cliente FOREIGN KEY (cod_cliente) REFERENCES CLIENTE  -- Esta chave estrangeira faz referencia a um cliente já existente, é uma forma de referenciar duas tabelas informando que o cliente tem um ou mais telefones.
);

CREATE TABLE CIDADE(
    cod_cidade NUMBER,
    nom_cidade VARCHAR(35) NOT NULL,  -- Foi utilizado 'NOT NULL', pois esse atributo não pode ser nulo no registro de uma CIDADE.
    uf_cidade CHAR(2) NOT NULL,  -- Foi utilizado 'NOT NULL', pois esse atributo não pode ser nulo no registro de uma CIDADE.
    CONSTRAINT pk_cidade PRIMARY KEY (cod_cidade)  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
);

CREATE TABLE CLASSIFIC_HOTEL(
    id_classific_hotel INTEGER, -- (PK)
    dsc_classificacao VARCHAR(15),
    CONSTRAINT pk_classific_hotel PRIMARY KEY (id_classific_hotel)  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
);

CREATE TABLE HOTEL(
    cod_hotel INTEGER,          -- (PK)
    id_classific_hotel INTEGER, -- (FK)
    nom_hotel VARCHAR(30),
    CONSTRAINT pk_hotel PRIMARY KEY (cod_hotel),  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
    CONSTRAINT fk_pacote_hotel FOREIGN KEY (id_classific_hotel) REFERENCES HOTEL  -- Esta chave estrangeira faz referencia a um hotel já existente, é uma forma de referenciar duas tabelas.
);

CREATE TABLE PACOTE(
    num_pacote NUMBER,     -- (PK)
    cod_hotel INTEGER,      -- (FK)
    cod_cidadeorig NUMBER, -- (FK)
    cod_cidadedest NUMBER, -- (FK)
    dti_pacote DATE,
    dtf_pacote DATE,
    vlr_pacote NUMBER(6,2),
    CONSTRAINT pk_pacote PRIMARY KEY (num_pacote),  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
    CONSTRAINT fk_hotel FOREIGN KEY (cod_hotel) REFERENCES HOTEL,  -- Esta chave estrangeira faz referencia a um hotel já existente, é uma forma de referenciar duas tabelas.
    CONSTRAINT fk_pacote_cidadeorig FOREIGN KEY (cod_cidadeorig) REFERENCES CIDADE,  -- Esta chave estrangeira faz referencia a uma cidade já existente que será a cidade de origem do pacote, é uma forma de referenciar duas tabelas.
    CONSTRAINT fk_pacote_cidadedest FOREIGN KEY (cod_cidadedest) REFERENCES CIDADE  -- Esta chave estrangeira faz referencia a uma cidade já existente que será a cidade de destino do pacote, é uma forma de referenciar duas tabelas.
);

CREATE TABLE CONTRATO_VIAGEM(
    num_contrato NUMBER,   -- (PK)
    num_pacote NUMBER,     -- (FK)
    cod_cliente NUMBER,    -- (FK)
    cod_agente NUMBER,     -- (FK)
    dta_contrato DATE,
    pag_contrato CHAR,
    CONSTRAINT pk_contrato_viagem PRIMARY KEY (num_contrato),  -- Esta chave primária, é um identificador único da tabela, ela será utilizada também como referência em outra tabela caso necessário.
    CONSTRAINT fk_contrato_viagem_pacote FOREIGN KEY (num_pacote) REFERENCES PACOTE,  -- Esta chave estrangeira faz referencia a um pacote já existente, é uma forma de referenciar duas tabelas.
    CONSTRAINT fk_contrato_viagem_cliente FOREIGN KEY (cod_cliente) REFERENCES CLIENTE,  -- Esta chave estrangeira faz referencia a um cliente já existente, é uma forma de referenciar duas tabelas.
    CONSTRAINT fk_contrato_viagem_agente FOREIGN KEY (cod_agente) REFERENCES AGENTE  -- Esta chave estrangeira faz referencia a um agente já existente, é uma forma de referenciar duas tabelas.
);

COMMIT;


----------
-- 5. Elaborar script para gerar as sequências para gerenciar o código do cliente, o código do agente, 
--   o número do pacote e o número do contrato, as mesmas deverão ser nomeadas como seq_cod_cliente, seq_cod_agente, seq_num_pacote e seq_num_contrato. 
--   Todas deverão iniciar em 1, incrementar de 1 em 1 e não ser cíclicas (1.0 ponto).
CREATE SEQUENCE seq_cod_agente
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 99
NOCYCLE;


CREATE SEQUENCE seq_cod_cliente
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9999
NOCYCLE;

CREATE SEQUENCE seq_num_pacote
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 99
NOCYCLE;


CREATE SEQUENCE seq_num_contrato
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9999
NOCYCLE;
-- Nestas sequencias, quando utilizadas no registro de algum elemento na tabela, iniciará em 1, será incrementado por 1 e seu valor mínimo é 1, 
-- e máximo determinado de acordo com os tipos de tabela, variando de 99 ou 9999, e com uma sequencia não cíclica.

COMMIT;


----------
-- 6. Elaborar script para adicionar na tabela CLIENTE os atributos DTN_CLIENTE DATE e EMAIL_CLIENTE VARCHAR2(50) (0.5 ponto).
ALTER TABLE CLIENTE
ADD email_cliente VARCHAR2(50);

ALTER TABLE CLIENTE 
ADD dtn_cliente DATE; -- (JÁ É CRIADO NA CRIAÇÃO DAS TABELAS)
-- Estes comandos alteram uma tabela específica, adicionando um novo atributo a ela.

COMMIT;


----------
-- 7. Elaborar o script para inserir o cadastro de um cliente, sendo você o cliente (1.0 ponto). 
--   (*) utilizar as sequências criadas quando necessário.
INSERT INTO CLIENTE(
    cod_cliente, 
    nom_cliente, 
    dtn_cliente, 
    email_cliente) 
VALUES (
    seq_cod_cliente.NEXTVAL, 
    'Wesley', 
    TO_DATE('1994-04-21', 'YYYY-MM-DD'),
    'wesley.wes.oliveira@gmail.com'
);

COMMIT;


-- 8. Mostrar quantos hotéis são da classificação “5 estrelas” (1.0 ponto).
SELECT CH.dsc_classificacao HOTEIS, COUNT(H.cod_hotel) QTD 
FROM CLASSIFIC_HOTEL CH, HOTEL H WHERE H.id_classific_hotel = CH.id_classific_hotel
GROUP BY CH.dsc_classificacao HAVING CH.dsc_classificacao = '5 estrelas';
-- Neste comando foi utilizado alguns aliases como por exemplo:
-- - HOTEIS e QTD: são aliases de coluna para que seja melhor identificado o que que é cada coluna do resultado da consulta.
-- - CH e H: é um aliase da tabela CLASSIFIC_HOTEL e da HOTEL, respectivamente, para que na refenciação dos atributos do comando, sejá mais organizado e facilite o entendimento.


----------
-- 9. Mostrar o número do contrato, o nome do agente, o nome do cliente e seus telefones daqueles clientes que embarcarão de 
--   Minas Gerais – MG (origem) para qualquer outro destino. (1.0 ponto)
SELECT CV.num_contrato, A.nom_agente, C.nom_cliente, T.num_telefone, CI.uf_cidade
FROM PACOTE P, CONTRATO_VIAGEM CV, AGENTE A, CLIENTE C, TELEFONE T, CIDADE CI
WHERE C.cod_cliente = CV.cod_cliente
AND A.cod_agente = CV.cod_agente
AND C.cod_cliente = T.cod_cliente
AND P.num_pacote = CV.num_pacote
AND P.cod_cidadeorig = CI.cod_cidade
GROUP BY CV.num_contrato, A.nom_agente, C.nom_cliente, T.num_telefone, CI.uf_cidade
HAVING CI.uf_cidade = 'MG';
-- Neste comando foi utlizado a lógica AND para 'filtrar' e realizar uma consulta mais específica, limitanto e retornando apenas o necessário.
-- O GROUP BY foi utilizado para agrupar as linhas baseado em suas semelhanças e o HAVING foi utilizado para poder realizar uma condição quando utilizado a função de grupo,
-- neste caso para filtrar apenas os registros que são do estado de MG.


----------
-- 10. Mostrar o nome do agente de viagem e o nome dos clientes que fecharam contrato de viagem no mês de Janeiro/2020. (1.0 ponto)
SELECT A.nom_agente, C.nom_cliente, CV.dta_contrato
FROM AGENTE A, CLIENTE C, CONTRATO_VIAGEM CV 
WHERE C.cod_cliente = CV.cod_cliente
AND A.cod_agente = CV.cod_agente
GROUP BY A.nom_agente, C.nom_cliente, CV.dta_contrato
HAVING EXTRACT(MONTH FROM CV.dta_contrato) = '01'
AND EXTRACT(YEAR FROM CV.dta_contrato) = '2020';
-- Neste comando foi utilizado o EXTRACT para extrair uma data (dia, mês ou ano) de um atributo date, 
-- facilitando assim uma consulta específica de registros ocorridos apenas em um determinado ano por exemplo.







----------
-- SCRIPTS UTILIZADOS PARA TESTES.

-- 'cod_cliente', nom_cliente. dtn_cliente, email_cliente
-- INSERT INTO CLIENTE VALUES (1, 'Client 1', TO_DATE('1995-06-06', 'YYYY-MM-DD'), 'client1@client.com');
INSERT INTO CLIENTE VALUES (2, 'Client 2', TO_DATE('1990-06-06', 'YYYY-MM-DD'), 'client2@client.com');
INSERT INTO CLIENTE VALUES (3, 'Client 3', TO_DATE('1980-06-06', 'YYYY-MM-DD'), 'client3@client.com');
INSERT INTO CLIENTE VALUES (4, 'Client 4', TO_DATE('1980-06-06', 'YYYY-MM-DD'), 'client4@client.com');
INSERT INTO CLIENTE VALUES (5, 'Client 5', TO_DATE('1980-06-06', 'YYYY-MM-DD'), 'client5@client.com');

-- 'cod_cliente', num_telefone, ddd_telefone
INSERT INTO TELEFONE VALUES (1, 91123456, 16);
INSERT INTO TELEFONE VALUES (2, 92123456, 16);
INSERT INTO TELEFONE VALUES (3, 93123456, 16);
INSERT INTO TELEFONE VALUES (4, 94123456, 16);

-- 'cod_agente', nom_agente, dta_agente
INSERT INTO AGENTE VALUES (1, 'Agent 1', TO_DATE('1996-10-07', 'YYYY-MM-DD'));
INSERT INTO AGENTE VALUES (2, 'Agent 2', TO_DATE('1996-10-07', 'YYYY-MM-DD'));
INSERT INTO AGENTE VALUES (3, 'Agent 3', TO_DATE('1996-10-07', 'YYYY-MM-DD'));
INSERT INTO AGENTE VALUES (4, 'Agent 4', TO_DATE('1996-10-07', 'YYYY-MM-DD'));
INSERT INTO AGENTE VALUES (5, 'Agent 5', TO_DATE('1996-10-07', 'YYYY-MM-DD'));

-- 'id_classific_hotel', dsc_classificacao
INSERT INTO CLASSIFIC_HOTEL VALUES (1, '1 estrelas');
INSERT INTO CLASSIFIC_HOTEL VALUES (2, '2 estrelas');
INSERT INTO CLASSIFIC_HOTEL VALUES (3, '3 estrelas');
INSERT INTO CLASSIFIC_HOTEL VALUES (4, '4 estrelas');
INSERT INTO CLASSIFIC_HOTEL VALUES (5, '5 estrelas');

-- 'cod_hotel', ch.id_classific_hotel, nom_hotel
INSERT INTO HOTEL VALUES (1, 1, 'Hotel 1');
INSERT INTO HOTEL VALUES (2, 2, 'Hotel 2');
INSERT INTO HOTEL VALUES (3, 2, 'Hotel 3');
INSERT INTO HOTEL VALUES (4, 3, 'Hotel 4');
INSERT INTO HOTEL VALUES (5, 3, 'Hotel 5');
INSERT INTO HOTEL VALUES (6, 3, 'Hotel 6');
INSERT INTO HOTEL VALUES (7, 4, 'Hotel 7');
INSERT INTO HOTEL VALUES (8, 4, 'Hotel 8');
INSERT INTO HOTEL VALUES (9, 4, 'Hotel 9');
INSERT INTO HOTEL VALUES (10, 4, 'Hotel 10');
INSERT INTO HOTEL VALUES (11, 5, 'Hotel 11');
INSERT INTO HOTEL VALUES (12, 5, 'Hotel 12');
INSERT INTO HOTEL VALUES (13, 5, 'Hotel 13');
INSERT INTO HOTEL VALUES (14, 5, 'Hotel 14');
INSERT INTO HOTEL VALUES (15, 5, 'Hotel 15');

-- 'cod_cidade', nom_cidade, uf_cidade
INSERT INTO CIDADE VALUES (1, 'Sertãozinho', 'SP');
INSERT INTO CIDADE VALUES (2, 'Ribeirão Preto', 'SP');
INSERT INTO CIDADE VALUES (3, 'Jaboticabal', 'SP');
INSERT INTO CIDADE VALUES (4, 'Matão', 'SP');
INSERT INTO CIDADE VALUES (5, 'Barretos', 'SP');
INSERT INTO CIDADE VALUES (6, 'Colombia', 'SP');
INSERT INTO CIDADE VALUES (7, 'São Paulo', 'SP');
INSERT INTO CIDADE VALUES (8, 'Rio de Janeiro', 'RJ');
INSERT INTO CIDADE VALUES (9, 'Salvador', 'BA');
INSERT INTO CIDADE VALUES (10, 'Campinas', 'SP');
INSERT INTO CIDADE VALUES (11, 'Rio de Janeiro', 'RJ');
INSERT INTO CIDADE VALUES (12, 'Natal', 'RN');
INSERT INTO CIDADE VALUES (13, 'Porto Seguro', 'BA');
INSERT INTO CIDADE VALUES (14, 'Maceió', 'AL');
INSERT INTO CIDADE VALUES (15, 'Guarulhos', 'SP');
INSERT INTO CIDADE VALUES (16, 'Uberlândia', 'MG');
INSERT INTO CIDADE VALUES (17, 'Confins', 'MG');
INSERT INTO CIDADE VALUES (18, 'Ilhéus', 'BA');
INSERT INTO CIDADE VALUES (19, 'Presidente Prudente', 'SP');
INSERT INTO CIDADE VALUES (20, 'Cabo Frio', 'RJ');
INSERT INTO CIDADE VALUES (21, 'Bauru', 'SP');
INSERT INTO CIDADE VALUES (22, 'Montes Claros', 'MG');

-- 'num_pacote', h.cod_hotel, co.cod_cidadeorig, cd.cod_cidadedest, dti_pacote, dtf_pacote, vlr_pacote
INSERT INTO PACOTE VALUES (1, 1, 1, 6, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 221.11);
INSERT INTO PACOTE VALUES (2, 2, 2, 5, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 222.22);
INSERT INTO PACOTE VALUES (3, 3, 3, 4, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 223.33);
INSERT INTO PACOTE VALUES (4, 4, 4, 3, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 224.44);
INSERT INTO PACOTE VALUES (5, 5, 5, 2, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (6, 2, 7, 22, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (7, 5, 8, 21, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (8, 5, 9, 20, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (9, 1, 10, 19, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (10, 1, 11, 18, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (11, 5, 12, 17, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (12, 4, 13, 16, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (13, 3, 14, 15, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (14, 1, 15, 14, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (15, 2, 16, 13, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (16, 2, 17, 12, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (17, 5, 18, 11, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (18, 1, 19, 10, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (19, 4, 20, 9, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (20, 2, 21, 8, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);
INSERT INTO PACOTE VALUES (21, 5, 22, 7, TO_DATE('1996-10-07', 'YYYY-MM-DD'), TO_DATE('1996-10-07', 'YYYY-MM-DD'), 225.55);

-- 'num_contrato', p.num_pacote, c.cod_cliente, a.cod_agente, dta_contrato, pag_contrato
INSERT INTO CONTRATO_VIAGEM VALUES (1, 1, 3, 3, TO_DATE('2020-01-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (2, 3, 4, 4, TO_DATE('2020-01-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (3, 18, 2, 2, TO_DATE('2020-01-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (4, 21, 3, 3, TO_DATE('2020-02-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (5, 20, 5, 5, TO_DATE('2020-02-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (6, 17, 3, 3, TO_DATE('2020-03-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (7, 5, 3, 3, TO_DATE('2020-01-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (8, 12, 1, 1, TO_DATE('2020-01-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (9, 2, 2, 2, TO_DATE('2020-01-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (10, 16, 5, 5, TO_DATE('2020-04-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (11, 11, 1, 1, TO_DATE('2020-01-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (12, 13, 3, 3, TO_DATE('2020-09-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (13, 8, 5, 5, TO_DATE('2020-02-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (14, 9, 4, 4, TO_DATE('2020-01-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (15, 15, 3, 3, TO_DATE('2020-08-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (16, 14, 4, 4, TO_DATE('2020-04-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (17, 4, 3, 3, TO_DATE('2020-01-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (18, 7, 3, 3, TO_DATE('2020-05-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (19, 6, 4, 4, TO_DATE('2020-05-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (20, 19, 2, 2, TO_DATE('2020-03-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (21, 10, 2, 2, TO_DATE('2020-10-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (22, 16, 1, 1, TO_DATE('2020-04-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (23, 13, 4, 4, TO_DATE('2020-10-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (24, 20, 3, 3, TO_DATE('2020-04-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (25, 12, 1, 1, TO_DATE('2020-01-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (26, 14, 2, 2, TO_DATE('2020-07-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (27, 3, 2, 2, TO_DATE('2020-10-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (28, 15, 4, 4, TO_DATE('2020-12-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (29, 1, 3, 3, TO_DATE('2020-09-07', 'YYYY-MM-DD'), 'S');
INSERT INTO CONTRATO_VIAGEM VALUES (30, 11, 1, 1, TO_DATE('2020-08-07', 'YYYY-MM-DD'), 'S');
