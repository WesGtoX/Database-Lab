-- Mostrar usuário conectado
SHOW USER;

-- CRIAÇÃO DE USUÁRIO
CREATE USER

-- Sintaxe:
CREATE USER "nome_usuario"
IDENTIFIED BY "senha"
DEFAULT TABLESPACE "nome_tablespace_padrao"
TEMPORARY TABLESPACE "nome_tablespace_temporario"
ACCOUNT "status_da_conta" [LOCK | UNLOCK]
PROFILE "perfil1" -- limites/regras_para_o_usuario
QUOTA [n k|m] ON "nome_tablespace"

-- Exemplo
CREATE USER "2M828507"
IDENTIFIED BY "12345"
DEFAULT TABLESPACE "2M2020_828507"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK
PROFILE DEFAULT;

-- Listar nome dos usuários do banco de dados
-- As informações do usuário ficam  armazenadas na tabela DBA_USERS
SELECT USERNAME from DBA_USERS;

-- Alterar usuário:
ALTER USER;

-- Sintaxe:
ALTER USER "nome_usuario" [parâmetro (s) que deseja alterar];

-- Exemplo:
ALTER USER "2M828507" IDENTIFIED BY "unaerp";
ALTER USER "2M828507" ACCOUNT LOCK;

-- Desconectar do banco de dados
DISC ou DISCONNECT

-- Conectar ao banco de dados
CONN ou CONNECT

-- Exemplo:
CONN 2M828507 @grad
CONN laboratorio@grad


-- Atribuir direitos (s) para um usuario do banco de dados
GRANT

-- Alguns direitos de sistemas
CREATE SESSION
CREATE ANY TABLE
CREATE USER
ALTER ANY TABLE

-- Alguns direitos de objeto
SELECT ANY TABLE
INSERT

-- Sintaxe:
GRANT direitos (s)/papel TO "nome_usuario"  ou "papel"

-- Exemplo:
GRANT CREATE SESSION, CREATE ANY TABLE, SELECT ANY TABLE TO "2M828507";

-- Mostrar as tabelas de um TABLESPACE
SELECT * FROM TAB;

-- Criar tabela
CREATE TABLE "nome_tabela" atributos constraints;
CREATE TABLE TESTE(X NUMBER(2), Y NUMBER(2));


-- Excluir usuário
DROP USER;

-- Sintaxe:
DROP USER "nome_usuario" [CASCADE]

-- Exemplo:
DROP USER "2M828507";
DROP USER "2M828507" CASCADE;

-- Criação de papel
CREATE ROLE;

-- Sintaxe:
CREATE ROLE "nome_papel";

-- Exemplo:
CREATE ROLE "PAPEL828507";

-- Atribuir direitos para o papel
GRANT ALTER ANY TABLE, DROP ANY TABLE TO PAPEL828507;
-- Criar sessão       |
-- Criar tabela       |
-- Consulta registro  |- papel
-- Alterar tabela     |
-- Excluir tabela     |

-- Atribuir o papel para o usuário
GRANT PAPEL828507 TO "2M828507";

-- Retirar direitos (s)/papel (is) do usuário
REVOKE

-- Sintaxe:
REVOKE direito (s)/papel (is) FROM "nome_usuario";

Exemplo:
REVOKE SELECT ANY TABLE FROM "2M828507";




