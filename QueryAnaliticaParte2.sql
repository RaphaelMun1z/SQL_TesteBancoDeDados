# Cria o banco de dados com o encode configurado
CREATE DATABASE IF NOT EXISTS db_operadoras_de_plano_de_saude 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# Seleciona o banco de dados
USE db_operadoras_de_plano_de_saude;

# Cria a tabela com o encoding 'utf8mb4'
CREATE TABLE tb_demonstracoes_contabeis (
    id INT NOT NULL AUTO_INCREMENT,
    data_ DATE,
    reg_ans VARCHAR(20),
    cd_conta_contabil VARCHAR(20),
    descricao VARCHAR(255),
    vl_saldo_inicial DECIMAL(15,2),
    vl_saldo_final DECIMAL(15,2),
    PRIMARY KEY (id)
)  CHARACTER SET UTF8MB4 COLLATE UTF8MB4_GENERAL_CI;

# Obs.: Verificar caminho do diretório 'Uploads'
# Realizo o tratamento dos dados ao carregar o conteúdo do CSV, e em seguida insiro os dados na tabela 'tb_demonstracoes_contabeis'
# 4° Trimestre de 2024
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/4T2024.csv'
INTO TABLE tb_demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, reg_ans, cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data_ = @data,
	descricao = TRIM(REPLACE(@descricao, '  ', ' ')),
	vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');
    
# 3° Trimestre de 2024
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/3T2024.csv'
INTO TABLE tb_demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, reg_ans, cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data_ = @data,
	descricao = TRIM(REPLACE(@descricao, '  ', ' ')),
	vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');
    
# 2° Trimestre de 2024
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2T2024.csv'
INTO TABLE tb_demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, reg_ans, cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data_ = @data,
	descricao = TRIM(REPLACE(@descricao, '  ', ' ')),
	vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');
    
# 1° Trimestre de 2024
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/1T2024.csv'
INTO TABLE tb_demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, reg_ans, cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data_ = @data,
	descricao = TRIM(REPLACE(@descricao, '  ', ' ')),
	vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');
    
# 4° Trimestre de 2023
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/4T2023.csv'
INTO TABLE tb_demonstracoes_contabeis
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@data, reg_ans, cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data_ = STR_TO_DATE(@data, '%d/%m/%Y'),
	descricao = TRIM(REPLACE(@descricao, '  ', ' ')),
	vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');
    
# 3° Trimestre de 2023
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/3T2023.csv'
INTO TABLE tb_demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, reg_ans, cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data_ = @data,
	descricao = TRIM(REPLACE(@descricao, '  ', ' ')),
	vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');
    
# 2° Trimestre de 2023
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2T2023.csv'
INTO TABLE tb_demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, reg_ans, cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data_ = @data,
	descricao = TRIM(REPLACE(@descricao, '  ', ' ')),
	vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');
    
# 1° Trimestre de 2023
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/1T2023.csv'
INTO TABLE tb_demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, reg_ans, cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data_ = @data,
	descricao = TRIM(REPLACE(@descricao, '  ', ' ')),
	vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

# Quais as 10 operadoras com maiores despesas nessa categoria no último ano?
# Seleciono todos os registros que possuem 'cd_conta_contabil' igual a '41111' (EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR), realizo a soma das despesas, ordeno, e por fim, limito a seleção em 10 registros

SET @ultimo_ano = (SELECT YEAR(MAX(data_)) FROM tb_demonstracoes_contabeis);
SET @data_inicio = STR_TO_DATE(CONCAT(@ultimo_ano, '-01-01'), '%Y-%m-%d');
SET @data_fim = STR_TO_DATE(CONCAT(@ultimo_ano, '-12-31'), '%Y-%m-%d');

SELECT 
    reg_ans,
    SUM(vl_saldo_final - vl_saldo_inicial) AS vl_total_despesas
FROM
    tb_demonstracoes_contabeis
WHERE
    cd_conta_contabil = '41111'
        AND vl_saldo_final < vl_saldo_inicial
        AND data_ BETWEEN @data_inicio AND @data_fim
GROUP BY reg_ans
ORDER BY ABS(vl_total_despesas) DESC
LIMIT 10;