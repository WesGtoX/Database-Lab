-- Exercício até 1 ponto, enviar os scripts por e-mail (ecarita@gmail.com) até 13/03/2020 23:59
    -- 1. Scripts de criação das tabelas do modelo de dados
    -- 2. Adicionar um atributo dta_func_projeto na tabela FUNC. PROJETO.
    -- 3. Adicionar constraint de check vlr_despesa entre 1 e 9,999,999.99.
-- Para definir um intervalo de dados utilizar o operador between.


-- 1. Scripts de criação das tabelas do modelo de dados
--------------------------------------------------
CREATE TABLE FUNCIONARIO (
	cod_funcionario INTEGER, 
	nom_funcionario VARCHAR(40), 
	dtn_funcionario DATE,
    dta_funcionario DATE,
    ctps_funcionario VARCHAR(13),
    CONSTRAINT PK_funcionario PRIMARY KEY (cod_funcionario)
);

CREATE TABLE CARGO (
    cod_cargo INTEGER,
    nom_cargo VARCHAR(20),
    CONSTRAINT PK_cargo PRIMARY KEY (cod_cargo)
);

CREATE TABLE PROJETO (
    num_projeto INTEGER,
    tit_projeto VARCHAR(50),
    dsc_projeto VARCHAR(250),
    dti_projeto DATE,
    dtf_projeto DATE,
    CONSTRAINT PK_projeto PRIMARY KEY (num_projeto)
);

CREATE TABLE DESPESA (
    num_despesa INTEGER,
    num_projeto INTEGER,
    dta_despesa DATE,
    vlr_despesa NUMERIC(9,2),
    dsc_despesa VARCHAR(30),
    CONSTRAINT PK_despesa PRIMARY KEY (num_despesa),
    CONSTRAINT FK_despesa_projeto FOREIGN KEY (num_projeto) REFERENCES PROJETO
);

CREATE TABLE FUNC_PROJETO (
    cod_funcionario INTEGER,
    num_projeto INTEGER,
    CONSTRAINT PK_func_projeto PRIMARY KEY (cod_funcionario, num_projeto),
    CONSTRAINT FK_func_projeto_funcionario FOREIGN KEY (cod_funcionario) REFERENCES FUNCIONARIO,
	CONSTRAINT FK_func_projeto_projeto FOREIGN KEY (num_projeto) REFERENCES PROJETO
);

CREATE TABLE FUNC_CARGO (
    cod_funcionario INTEGER,
    cod_cargo INTEGER,
    dti_cargo DATE,
    CONSTRAINT PK_func_cargo PRIMARY KEY (cod_funcionario, cod_cargo),
    CONSTRAINT FK_func_cargo_funcionario FOREIGN KEY (cod_funcionario) REFERENCES FUNCIONARIO,
	CONSTRAINT FK_func_cargo_cargo FOREIGN KEY (cod_cargo) REFERENCES CARGO
);
--------------------------------------------------

-- 2. Adicionar um atributo 'dta_func_projeto' na tabela 'FUNC. PROJETO'.
--------------------------------------------------
ALTER TABLE FUNC_PROJETO ADD dta_func_projeto DATE;
--------------------------------------------------

-- 3. Adicionar constraint de check 'vlr_despesa' entre '1' e '9,999,999.99'.
--------------------------------------------------
ALTER TABLE DESPESA ADD CONSTRAINT ck_despesa CHECK (vlr_despesa BETWEEN 1 AND 9999999.99);
--------------------------------------------------
