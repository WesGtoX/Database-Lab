-- Criação de Tablespace
-- Sintaxe
CREATE tablespace "logical_name"
DATAFILE 'path\file_nome.dbf'
SIZE [size]M

-- Exemplo
CREATE tablespace "2M2020_828507"
DATAFILE 'C:\APP\ORACLE\ORADATA\GRAD\DATAFILE\TBLS_828507.dbf'
SIZE 10M;