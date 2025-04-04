# Cria o banco de dados
CREATE DATABASE IF NOT EXISTS db_cadop
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# Seleciona o banco de dados
USE db_cadop;

# Cria a tabela com o encoding 'utf8mb4'
CREATE TABLE tb_operadoras_de_plano_de_saude_ativas (
    registro_ans INT NOT NULL,
    cnpj VARCHAR(14),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(20) NULL,
    complemento VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf CHAR(2),
    cep VARCHAR(8),
    ddd CHAR(2),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    regiao_de_comercializacao INT NULL,
    data_registro_ans DATE,
    PRIMARY KEY (registro_ans)
)  CHARACTER SET UTF8MB4 COLLATE UTF8MB4_GENERAL_CI;

# Lista todas as colunas de 'tb_operadoras_de_plano_de_saude_ativas'
SELECT * FROM tb_operadoras_de_plano_de_saude_ativas;

# Obs.: Verificar caminho do diretório 'Uploads'
# Realizo o tratamento dos dados ao carregar o conteúdo do CSV, e em seguida insiro os dados na tabela 'tb_operadoras_de_plano_de_saude_ativas'
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Relatorio_cadop.csv'
INTO TABLE tb_operadoras_de_plano_de_saude_ativas
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(registro_ans, cnpj, razao_social, nome_fantasia, modalidade, logradouro, numero, 
 complemento, bairro, cidade, uf, cep, ddd, telefone, fax, endereco_eletronico, 
 representante, cargo_representante, @regiao_de_comercializacao, @data_registro_ans)
SET nome_fantasia = NULLIF(nome_fantasia, ''),
    complemento = NULLIF(complemento, ''),
    ddd = NULLIF(ddd, ''),
    telefone = NULLIF(telefone, ''),
    fax = NULLIF(fax, ''),
    endereco_eletronico = NULLIF(endereco_eletronico, ''),
    regiao_de_comercializacao = NULLIF(@regiao_de_comercializacao, ''),
    data_registro_ans = NULLIF(@data_registro_ans, '');
    
# Lista todas as colunas de 'tb_operadoras_de_plano_de_saude_ativas'
SELECT * FROM tb_operadoras_de_plano_de_saude_ativas;