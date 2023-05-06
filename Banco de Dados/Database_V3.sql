
DROP DATABASE Secure_Ship;

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
	idLocal INT AUTO_INCREMENT, -- Chave Primaria
    Nome VARCHAR(80), -- Nome do Local EX(Sala 01,Sala 02)
    FKEmpresa INT, -- Chave Estrangeira da Tabela Empresa
		CONSTRAINT FKEmpresa_L FOREIGN KEY (FKEmpresa)
			REFERENCES Empresa(idEmpresa),
	FKLimite INT, -- Chave Estrangeira da parametrização de limites (1-n)
		CONSTRAINT FKLimite_L FOREIGN KEY (FKLimite) 
			REFERENCES Limite_Parametros(idLimite),
	CONSTRAINT PKComposta_Li PRIMARY KEY (idLocal, FKLimite)
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
	idLeitura INT AUTO_INCREMENT, -- Componente da Chave Primaria 
    Leitura FLOAT, -- Resultado dos sensores 
    Data_Hora DATETIME DEFAULT CURRENT_TIMESTAMP, -- Data e hora em que os resultados foram computados
    FKSensor_LE INT, -- Componente da Chave Primaria que refere a Tabela Sensores
		CONSTRAINT FKSensor_LE FOREIGN KEY (FKSensor_LE)
			REFERENCES Sensores(idSensor),
	CONSTRAINT PKComposta_Le PRIMARY KEY (idLeitura,FKSensor_LE) -- Chave Primaria composta de Dois elementos 
);

-- SELECTS PARA TESTE

SELECT * FROM 
	Empresa LEFT JOIN Usuario
		ON idEmpresa = FKEmpresa_U;

SELECT * FROM 
	Empresa JOIN Local
		ON idEmpresa = FKEmpresa_L;

SELECT * FROM 
	Local JOIN Limite_Parametros
		ON FKLimite_L = idLimite ORDER BY idLimite ASC;

INSERT INTO Usuario VALUES
	(NULL, 'Davi Rodrigues', 'davirodrigues0506@gmail.com', '11959164441', 'myLOVEisthe0506', NULL, NULL);
  
INSERT INTO Limite_Parametros VALUES 
	(NULL, -4, 40, 'Temperatura', NULL),
	(NULL, 20, 80, 'Umidade', NULL);
  
INSERT INTO Localização VALUES
	(1, 'Container 1', NULL, 1),
	(1, 'Container 1', NULL, 2),
	(2, 'Container 2', NULL, 1),
	(2, 'Container 2', NULL, 2),
    (3, 'Container 3', NULL, 1),
	(3, 'Container 3', NULL, 2),
    (4, 'Container 4', NULL, 1),
	(4, 'Container 4', NULL, 2);
  
SELECT * FROM Sensores;
  
INSERT INTO Sensores VALUES
	(NULL, 'DHT11', 'Umidade', 1),
	(NULL, 'LM35', 'Temperatura', 1),
	(NULL, 'DHT11', 'Umidade', 2),
	(NULL, 'LM35', 'Temperatura', 2),
	(NULL, 'DHT11', 'Umidade', 3),
	(NULL, 'LM35', 'Temperatura', 3),
    (NULL, 'DHT11', 'Umidade', 4),
	(NULL, 'LM35', 'Temperatura', 4);
    
INSERT INTO Leitura VALUES
	(NULL, 20, DEFAULT, 2),
	(NULL, 21, DEFAULT, 2),
	(NULL, 22, DEFAULT, 2),
	(NULL, 23, DEFAULT, 2),
	(NULL, 24, DEFAULT, 2),
	(NULL, 25, DEFAULT, 2),
    (NULL, 55, DEFAULT, 1),
    (NULL, 56, DEFAULT, 1),
    (NULL, 57, DEFAULT, 1),
    (NULL, 58, DEFAULT, 1),
    (NULL, 59, DEFAULT, 1),
    (NULL, 60, DEFAULT, 1);

INSERT INTO Leitura VALUES
	(NULL, 20, DEFAULT, 4),
	(NULL, 21, DEFAULT, 4),
	(NULL, 22, DEFAULT, 4),
	(NULL, 23, DEFAULT, 4),
	(NULL, 24, DEFAULT, 4),
	(NULL, 25, DEFAULT, 4),
    (NULL, 55, DEFAULT, 3),
    (NULL, 56, DEFAULT, 3),
    (NULL, 57, DEFAULT, 3),
    (NULL, 58, DEFAULT, 3),
    (NULL, 59, DEFAULT, 3),
    (NULL, 60, DEFAULT, 3);
    
INSERT INTO Leitura VALUES
	(NULL, 20, DEFAULT, 6),
	(NULL, 21, DEFAULT, 6),
	(NULL, 22, DEFAULT, 6),
	(NULL, 23, DEFAULT, 6),
	(NULL, 24, DEFAULT, 6),
	(NULL, 25, DEFAULT, 6),
    (NULL, 55, DEFAULT, 5),
    (NULL, 56, DEFAULT, 5),
    (NULL, 57, DEFAULT, 5),
    (NULL, 58, DEFAULT, 5),
    (NULL, 59, DEFAULT, 5),
    (NULL, 60, DEFAULT, 5);
    
INSERT INTO Leitura VALUES
	(NULL, 20, DEFAULT, 8),
	(NULL, 21, DEFAULT, 8),
	(NULL, 22, DEFAULT, 8),
	(NULL, 23, DEFAULT, 8),
	(NULL, 24, DEFAULT, 8),
	(NULL, 25, DEFAULT, 8),
    (NULL, 55, DEFAULT, 7),
    (NULL, 56, DEFAULT, 7),
    (NULL, 57, DEFAULT, 7),
    (NULL, 58, DEFAULT, 7),
    (NULL, 59, DEFAULT, 7),
    (NULL, 60, DEFAULT, 7);
    
SELECT * FROM Leitura;

SELECT * FROM Sensores;

SELECT * FROM Empresa;

SELECT * FROM Usuario;

SELECT Nome FROM Usuario;

SELECT Leitura AS medida, 
		DATE_FORMAT(Data_Hora,'%H:%i:%s') AS momento_grafico 
        FROM Leitura JOIN Sensores 
			ON FKSensor_LE = idSensor 
				JOIN Localização 
					ON FKLocal_S = idLocal 
						WHERE idLocal = 1 AND idSensor = 1;
                        
SELECT Leitura AS medida, 
                        DATE_FORMAT(Data_Hora,'%H:%i:%s') AS momento_grafico 
                        FROM Leitura JOIN Sensores 
                        ON FKSensor_LE = idSensor 
                        JOIN Localização 
                        ON FKLocal_S = 1
                        WHERE idSensor = 1;
                        
SELECT Leitura AS medida, 
                        DATE_FORMAT(Data_Hora,'%H:%i:%s') AS momento_grafico 
                        FROM Leitura JOIN Sensores 
                        ON FKSensor_LE = idSensor 
                        JOIN Localização 
                        ON FKLocal_S = idLocal 
                        WHERE idLocal = 1 AND FKSensor_LE = 1;