-- Criação de Tablespace
-- Sintaxe
CREATE TABLESPACE "logical_name"
DATAFILE 'path\file_nome.dbf'
SIZE [size]M

-- Exemplo
CREATE TABLESPACE "2M2020_828507"
DATAFILE 'C:\app\Wesley\product\18.0.0\oradata\XE\TBLS_828507.dbf'
SIZE 10M;