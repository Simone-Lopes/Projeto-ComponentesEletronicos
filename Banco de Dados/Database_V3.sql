-- Criação do Banco de Dados
CREATE DATABASE Secure_Ship;

USE Secure_Ship;

-- Criação da tabela onde ficara armazenado os dados da Empresa
CREATE TABLE Empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primaria
    Nome_Fantasia VARCHAR(80), -- Nome da empresa
    Cnpj CHAR(19), -- cnpj com 19 digitos contando com pontos e traços
    Rua VARCHAR(40), -- Componentes do Endereço da Empresa
    Numero VARCHAR(40), -- Componentes do Endereço da Empresa
    Bairro VARCHAR(40), -- Componentes do Endereço da Empresa
    Estado VARCHAR(40), -- Componentes do Endereço da Empresa
    Telefone VARCHAR(15), -- telefone com 15 digitos no Maximo
    Email VARCHAR(50) -- Email com no maximo 50 digitos 
);

-- Criação da tabela para guardar um usuario especifico de determinada empresa
CREATE TABLE Usuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primaria
    Nome VARCHAR(80), -- Nome do Usuario
	Email VARCHAR(50), -- Email com no maximo 50 digitos
    CPF CHAR(11) UNIQUE, -- CPF com apenas numeros
	Telefone VARCHAR(15), -- telefone com 15 digitos no Maximo
    Senha CHAR(20), -- Senha ainda sem formatação de criptografia
    FKEmpresa INT, -- Chave Estrangeira da Tabela Empresa
		CONSTRAINT FKEmpresa_U FOREIGN KEY (FKEmpresa)
			REFERENCES Empresa(idEmpresa),
	FKAdmin INT, -- Chave Estrangeira de Recursividade (User - Admin)
		CONSTRAINT FKAdmin_U FOREIGN KEY (FKAdmin)
			REFERENCES Usuario(idUsuario)
);

-- Criação da tabela onde ficara guardado os limites(min e max) dos sensores
CREATE TABLE Limite_Parametros(
	idLimite INT PRIMARY KEY AUTO_INCREMENT, -- Primeiro componente da Chave Primaria
    Minimo FLOAT, -- Valor minimo de temp. que pode receber da leitura sem danificar o produto 
    Maximo FLOAT, -- Valor maximo de temp. que pode receber da leitura sem danificar o produto 
    Tipo VARCHAR(50),
    Componente VARCHAR(80)
);

-- Criação da tabela onde ficara as informações do local onde será retirada as leituras
CREATE TABLE Localização(
	idLocal INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primaria
    Nome VARCHAR(80), -- Nome do Local EX(Sala 01,Sala 02)
    FKEmpresa INT, -- Chave Estrangeira da Tabela Empresa
		CONSTRAINT FKEmpresa_L FOREIGN KEY (FKEmpresa)
			REFERENCES Empresa(idEmpresa),
	FKLimite INT, -- Chave Estrangeira da parametrização de limites (1-n)
		CONSTRAINT FKLimite_L FOREIGN KEY (FKLimite) 
			REFERENCES Limite_Parametros(idLimite)
	-- CONSTRAINT PKComposta_Li PRIMARY KEY (idLocal, FKLimite)
);

-- Criação de uma tabela exclusiva para os sensores (não para os resultados somente para os sensores)
CREATE TABLE Sensores(
	idSensor INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primaria
    Nome VARCHAR(20), -- Nome do sensor
    Tipo VARCHAR(30), -- Tipagem do Sensor EX(Temperatura,Umidade,Luminosidade)
    FKLocal_S INT, -- Chave Estrangeira da Tabela Localizaçao
		CONSTRAINT FKLocal_S FOREIGN KEY (FKLocal_S)
			REFERENCES Localização(idLocal)
);

-- Criação da tabela que fara o Relacionamento dos sensores com os resultados e os clientes
CREATE TABLE Leitura (
	idLeitura INT PRIMARY KEY AUTO_INCREMENT, -- Componente da Chave Primaria 
    Leitura_Temp FLOAT, -- Resultado dos sensores
    Leitura_Umi FLOAT, 
    Data_Hora DATETIME DEFAULT CURRENT_TIMESTAMP, -- Data e hora em que os resultados foram computados
    FKLocal_LE INT, -- Componente da Chave Primaria que refere a Tabela Sensores
    FKLimite_LE INT,
		CONSTRAINT FKLocal_LE FOREIGN KEY (FKLocal_LE)
			REFERENCES Localização(idLocal),
		CONSTRAINT FKLimite_LE FOREIGN KEY (FKLimite_LE)
			REFERENCES Limite_Parametros(idLimite)
	-- CONSTRAINT PKComposta_Le PRIMARY KEY (idLeitura,FKLocal_LE,FKLimite_LE) -- Chave Primaria composta de Dois elementos 
);

INSERT INTO Usuario VALUES
	(NULL, 'Davi Rodrigues', 'davirodrigues0506@gmail.com', '48372073830','11959164441', '@myLOVEisthe0506', NULL, NULL);
  
INSERT INTO Limite_Parametros VALUES 
	(NULL, -4, 40, 'Temperatura', NULL),
	(NULL, 20, 80, 'Umidade', NULL);
  
INSERT INTO Localização VALUES
	(1, 'Container 1', NULL, 1),
	(2, 'Container 2', NULL, 1),
    (3, 'Container 3', NULL, 1),
    (4, 'Container 4', NULL, 1);
  
INSERT INTO Sensores VALUES
	(NULL, 'DHT11', 'Umidade', 1),
	(NULL, 'LM35', 'Temperatura', 1),
	(NULL, 'DHT11', 'Umidade', 2),
	(NULL, 'LM35', 'Temperatura', 2),
	(NULL, 'DHT11', 'Umidade', 3),
	(NULL, 'LM35', 'Temperatura', 3),
    (NULL, 'DHT11', 'Umidade', 4),
	(NULL, 'LM35', 'Temperatura', 4);

SELECT * FROM Localização;

SELECT * FROM Leitura;

SELECT * FROM Sensores;

SELECT * FROM Empresa;

SELECT * FROM Usuario;

SELECT 
        Leitura_Temp AS temperatura, 
        DATE_FORMAT(Data_Hora,'%H:%i') AS momento_grafico 
        FROM 
        Leitura 
        JOIN Localização 
        ON idLocal = FKLocal_LE
        WHERE idLocal = 1 
        LIMIT 10;

INSERT INTO Leitura VALUES
	(null, 25.00, 55.00,DEFAULT, 1, NULL),
	(null, 24.00, 54.00,DEFAULT, 1, NULL),
	(null, 23.00, 53.00,DEFAULT, 1, NULL),
	(null, 22.00, 52.00,DEFAULT, 1, NULL),
	(null, 21.00, 51.00,DEFAULT, 1, NULL);
    
SELECT 
	Distinct(Leitura_Umi) AS umidade, 
	DATE_FORMAT(Data_Hora,'%H:%i') AS momento_grafico 
	FROM 
	Leitura 
	JOIN Localização 
	ON FKLocal_LE = idLocal
	WHERE idLocal = 1
    ORDER BY momento_grafico DESC
    LIMIT 10;
    
INSERT INTO Leitura VALUES
	(NULL, 32.00, 62.00, DEFAULT, 1, NULL),
	(NULL, 33.00, 63.00, DEFAULT, 1, NULL),
	(NULL, 34.00, 64.00, DEFAULT, 1, NULL);

SELECT 
	DISTINCT(Localização.Nome),
    Localização.FKEmpresa
		FROM Localização;
        
TRUNCATE Table Leitura;