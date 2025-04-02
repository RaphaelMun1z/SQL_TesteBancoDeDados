# Cria o banco de dados
CREATE DATABASE db_operadoras_de_plano_de_saude;

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

# Realizo o tratamento dos dados ao carregar o conteúdo do CSV, e em seguida insiro os dados na tabela 'tb_demonstracoes_contabeis'
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

# Quais as 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre?
# Seleciono todos os registros que possuem 'cd_conta_contabil' igual a '41111' (EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR), realizo a soma das despesas, ordeno, e por fim, limito a seleção em 10 registros
SELECT 
    reg_ans,
    SUM(vl_saldo_final - vl_saldo_inicial) AS vl_total_despesas
FROM
    tb_demonstracoes_contabeis
WHERE
    cd_conta_contabil = '41111'
        AND (vl_saldo_final - vl_saldo_inicial) < 0
GROUP BY reg_ans
ORDER BY ABS(vl_total_despesas) DESC
LIMIT 10;