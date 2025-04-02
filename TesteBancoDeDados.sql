# Cria o banco de dados
CREATE DATABASE db_cadop;

# Seleciona o banco de dados
USE db_cadop;

# Cria a tabela com o encoding 'utf8mb4'
CREATE TABLE tb_operadoras_de_plano_de_saude_ativas (
    Registro_ANS INT NOT NULL,
    CNPJ VARCHAR(14),
    Razao_Social VARCHAR(255),
    Nome_Fantasia VARCHAR(255),
    Modalidade VARCHAR(100),
    Logradouro VARCHAR(255),
    Numero VARCHAR(20) NULL,
    Complemento VARCHAR(255),
    Bairro VARCHAR(100),
    Cidade VARCHAR(100),
    UF CHAR(2),
    CEP VARCHAR(8),
    DDD CHAR(2),
    Telefone VARCHAR(20),
    Fax VARCHAR(20),
    Endereco_eletronico VARCHAR(255),
    Representante VARCHAR(255),
    Cargo_Representante VARCHAR(100),
    Regiao_de_Comercializacao INT NULL,
    Data_Registro_ANS DATE,
    PRIMARY KEY (Registro_ANS)
)  CHARACTER SET UTF8MB4 COLLATE UTF8MB4_GENERAL_CI;

# Lista todas as colunas de 'tb_operadoras_de_plano_de_saude_ativas'
SELECT * FROM tb_operadoras_de_plano_de_saude_ativas;

# Realizo o tratamento dos dados ao carregar o conteúdo do CSV, e em seguida insiro os dados na tabela 'tb_operadoras_de_plano_de_saude_ativas'
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Relatorio_cadop.csv'
INTO TABLE tb_operadoras_de_plano_de_saude_ativas
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Registro_ANS, CNPJ, Razao_Social, Nome_Fantasia, Modalidade, Logradouro, Numero, 
 Complemento, Bairro, Cidade, UF, CEP, DDD, Telefone, Fax, Endereco_eletronico, 
 Representante, Cargo_Representante, @Regiao_de_Comercializacao, @Data_Registro_ANS)
SET Nome_Fantasia = NULLIF(Nome_Fantasia, ''),
    Complemento = NULLIF(Complemento, ''),
    DDD = NULLIF(DDD, ''),
    Telefone = NULLIF(Telefone, ''),
    Fax = NULLIF(Fax, ''),
    Endereco_eletronico = NULLIF(Endereco_eletronico, ''),
    Regiao_de_Comercializacao = NULLIF(@Regiao_de_Comercializacao, ''),
    Data_Registro_ANS = NULLIF(@Data_Registro_ANS, '');
    
# Lista todas as colunas de 'tb_operadoras_de_plano_de_saude_ativas'
SELECT * FROM tb_operadoras_de_plano_de_saude_ativas;