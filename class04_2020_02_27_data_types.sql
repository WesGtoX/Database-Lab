-- Tipos de dados

CHAR -- caracteres (char(10) armazena as 10 posições)
VARCHAR2 -- caracteres variáveis (varchar2(20) armazena apenas a quantidade de posições utilizadas)
INTEGER -- números inteiros
NUMBER -- números reais (ex: (total de digitos, número de casas decimais) 32,1 == (3,1))
DATE -- data (ex: 99/99/9999 || 99:99:99)
LOB -- long object binary
*LONG -- textos até 2 gigabytes
*LONG RAW -- objetos binários (imagens) até 2 gigabytes
LOB = CLOB, BLOB e BFILE -- objetos binários(videos, imagens, arquivos de som entre outros) - até 128 terabytes

-- * (Obsoleto) apenas 1 tipo de dados LONG na tabela, não pode estar em uma clausula where


-- Criação de Tabelas
CREATE TABLE

-- Sintaxe:
CREATE TABLE "table_name" (
  [attribute_name1] data_types_attribute1 [NULL | NOT NULL | UNIQUE],
  [attribute_name2] data_types_attribute2 [NULL | NOT NULL | UNIQUE],
  ...
  CONSTRAINTS [PRIMARY KEY | FOREIGN KEY | CHECK]
);

-- Sintaxe básica para criação de constrains
[nome] TIPO [PRIMARY KEY | FOREIGN KEY | CHECK]

-- Exemplo
CREATE TABLE "CLIENTE" (
  id_cliente INTEGER,
  nom_cliente VARCHAR2(40) NOT NULL,
  dtn_cliente DATE,
  CONSTRAINT pk_cliente PRIMARY KEY (id_cliente)
);

-- Tabelas do usuário USER_TABLES
-- Constraints do usuário USER_CONSTRAINS

-- Mostrar o nome das tabelas do usuário conectado
SELECT TABLE_NAME FROM USER_TABLES;

-- Mostrar o nome das constraints das tabelas do usuário conectado
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS;


-- Conectar ao banco:
"user_name"@host
