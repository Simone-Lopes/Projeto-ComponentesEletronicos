
-- Criação do Banco de Dados
CREATE DATABASE Secure_Ship;

USE Secure_Ship;

-- Criação da tabela onde ficara armazenado os dados dos Clientes
CREATE TABLE Clientes (
	idClientes INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primaria
    Razao_social VARCHAR(75), -- Nome da empresa
    cnpj CHAR(19), -- cnpj com 19 digitos contando com pontos e traços
    telefone VARCHAR(15), -- telefone com 15 digitos no Maximo
    email VARCHAR(50) -- Email com no maximo 50 digitos 
);

-- Criação de uma tabela exclusiva para os sensores de Umidade (não para os resultados somente para os sensores)
CREATE TABLE Sensores_Umidade(
	idSensor INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primaria
    nome VARCHAR(20) -- Nome do sensor 
);

-- Criação de uma tabela exclusiva para os sensores de Temperatura (não para os resultados somente para os sensores)
CREATE TABLE Sensores_Temperatura(
	idSensor INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primaria
    nome VARCHAR(20) -- Nome do sensor 
);

-- Criação da tabela que fara o Relacionamento dos sensores com os resultados e os clientes
CREATE TABLE Dados_Capturados (
	idCaptura INT PRIMARY KEY AUTO_INCREMENT, -- chave primaria 
    temperatura DOUBLE, -- Resultado do sensor de temperatura
    umidade DOUBLE, -- Resultado do sensor de Umidade
    data_Captura DATE, -- Data em que os resultados foram computados
    hora_Captura TIME, -- horario em que os resultados foram computados
    
    fkCliente INT, -- Chave estrangeira da Tabela Clientes
		CONSTRAINT fkCliente FOREIGN KEY (fkCliente)
			REFERENCES Clientes(idClientes),
            
	fkSensor_Umidade INT, -- Chave estrangeira da Tabela Sensor_Umidade
		CONSTRAINT fkSensor_Umidade FOREIGN KEY (fkSensor_Umidade)
			REFERENCES Sensores_Umidade(idSensor),
	
    fkSensor_Temperatura INT, -- Chave estrangeira da Tabela Sensor_Temperatura
		CONSTRAINT fkSensor_Temperatura FOREIGN KEY (fkSensor_Temperatura)
			REFERENCES Sensores_Temperatura(idSensor)
);

-- Inserção de Dados ficticios para Testes 

-- Inserção na tabela clientes
INSERT INTO Clientes VALUES -- São Dados completamente FANTASIOSOS ou seja não correspondem a realidade, apenas para realização de testes
	(NULL, 'Dois irmãos Transportadora', '12.123.123/0001-12.', '(11)95959-9595', 'doisirmãos@gmail.com'),
	(NULL, 'Tres irmãos Transportadora', '21.321.321/0001-21.', '(11)98989-9898', 'tresirmãos@gmail.com'),
	(NULL, 'Quatro irmãos Transportadora', '45.456.456/0001-45.', '(11)93939-9393', 'quatroirmãos@gmail.com'),
	(NULL, 'Cinco irmãos Transportadora', '54.654.654/0001-54.', '(11)91919-9191', 'cincoirmãos@gmail.com');
    
INSERT INTO Sensores_Umidade VALUES -- São Dados completamente FANTASIOSOS ou seja não correspondem a realidade, apenas para realização de testes
	(NULL, 'DHT11'), -- Cada Sensor a para um cliente especifico
	(NULL, 'DHT11'),
	(NULL, 'DHT11'),
	(NULL, 'DHT11');
    
INSERT INTO Sensores_Temperatura VALUES -- São Dados completamente FANTASIOSOS ou seja não correspondem a realidade, apenas para realização de testes
	(NULL, 'LM35'),-- Cada Sensor a para um cliente especifico
    (NULL, 'LM35'),
    (NULL, 'LM35'),
    (NULL, 'LM35');
    
INSERT INTO Dados_Capturados VALUES -- São Dados completamente FANTASIOSOS ou seja não correspondem a realidade, apenas para realização de testes
	(NULL, 25.20, 74.40, '2023/03/23', '17:05:36', 1, 1, 1), -- Essas são simulações de como o banco de dados se comportaria na hora de receber os dados
	(NULL, 27.30, 75.10, '2023/03/23', '17:05:36', 2, 2, 2),
	(NULL, 22.10, 78.00, '2023/03/23', '17:05:36', 3, 3, 3),
	(NULL, 35.00, 62.80, '2023/03/23', '17:05:36', 4, 4, 4);
    
-- Alguns Selects para testas as Chaves Estrangeiras
SELECT * FROM Dados_Capturados 
    JOIN Clientes
		ON idClientes = fkCliente;
        
SELECT idCaptura,temperatura FROM Dados_Capturados 
    JOIN Sensores_Temperatura 
		ON idSensor = fkSensor_Temperatura;
        
SELECT * FROM Dados_Capturados 
	JOIN Sensores_Umidade 
		ON idSensor = fkSensor_Umidade
			WHERE idSensor = 2;
            
