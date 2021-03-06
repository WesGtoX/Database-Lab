-- Limpar tela
CLEAR SCR

-- Criação de TABLESPACE com redimensionamento automático
CREATE [TEMPORARY | UNDO] TABLESPACE "nome_tablespace"
DATAFILE "caminho\nome_datafile" SIZE tamanho
[AUTOEXTEND ON NEXT tamanho MAXSIZE tamanho [UNLIMITED]]
[ONLINE | OFFLINE]

-- Exemplo:
CREATE TABLESPACE "2M_828507"
DATAFILE "C:\APP\ORACLE\ORADATA\GRAD\DATAFILE\2M_828507A.dbf"
SIZE 10M 
AUTOEXTEND ON NEXT 1M MAXSIZE 100M;

-- Visualizar as informações dos TABLESPACEs do banco de dados
-- Acessar a tabela DBA_TABLESPACES | TABLESPACE SYSTEM

-- Listar o nome dos TABLESPACEsdo banco de dados
SELECT TABLESPACE_NAME from DBA_TABLESPACES;

-- Mostrar os atributos (estrutura da tabela DBA_TABLESPACES)
DESC DBA_TABLESPACES;


-- Alterar o tamanho de um TABLESPACE
-- redimensionando o arquivo de dados
ALTER DATABASE;

-- Sintaxe
ALTER DATABASE DATAFILE "caminho\nome_datafile"
RESIZE novo_tamanho

-- Exemplo
ALTER DATABASE DATAFILE "C:\APP\ORACLE\ORADATA\GRAD\DATAFILE\TBLS_828507.dbf"
RESIZE 15M;


CREATE TABLESPACE "2M2020_828507"
DATAFILE "C:\APP\ORACLE\ORADATA\GRAD\DATAFILE\TBLS_828507.dbf"
SIZE 10M;

-- redimensionando adicionando um novo DATAFILE
ALTER TABLESPACE "nome_tablespace"
ADD DATAFILE "caminho\nome_datafile"
SIZE tamanho

-- Exemplo:
ALTER TABLESPACE "2M2020_828507"
ADD DATAFILE "C:\APP\ORACLE\ORADATA\GRAD\DATAFILE\TBLS_828507A.dbf"
SIZE 5M;

-- Excluir um TABLESPACE
DROP TABLESPACE "nome_tablespace" [INCLUDING CONTENTS [AND | KEEP] DATAFILES] [CASCADE CONSTRAINTS];

-- Exemplo
DROP TABLESPACE "2M_828507" INCLUDING CONTENTS AND DATAFILES;

-- Desativar/ativar um TABLESPACE
-- Desativar um TABLESPACEé o equivalente a desligá-lo
ALTER TABLESPACE

Sintaxe:
ALTER TABLESPACE "nome_tablespace" [ONLINE | OFFLINE]

-- Exemplo
-- Desativando um TABLESPACE
ALTER TABLESPACE "2M2020_828507" OFFLINE;

SELECT TABLESPACE_NAME, STATUS FROM DBA_TABLESPACES;

















DROP TABLESPACE "2M_828507";
DROP TABLESPACE "2M_828507" INCLUDING CONTENTS;
DROP TABLESPACE "2M_828507" INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

DROP DATAFILE "2M_828507.dbf";
DROP DATAFILE "C:\APP\ORACLE\ORADATA\GRAD\DATAFILE\2M_828507.dbf";

ALTER TABLESPACE "2M_828507" DROP TEMPFILE "C:\APP\ORACLE\ORADATA\GRAD\DATAFILE\2M_828507.dbf";

DROP TEMPFILE "C:\APP\ORACLE\ORADATA\GRAD\DATAFILE\2M_828507.dbf";

ALTER DATABASE TEMPFILE "C:\APP\ORACLE\ORADATA\GRAD\DATAFILE\2M_828507.dbf" DROP INCLUDING DATAFILES;
