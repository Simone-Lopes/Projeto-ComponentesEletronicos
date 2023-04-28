
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
    Leitura FLOAT,-- Resultado do sensor
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
	(1, 'Container 1', NULL, 2);
  
SELECT * FROM Sensores;
  
INSERT INTO Sensores VALUES
	(NULL, 'DHT11', 'Umidade', 1),
	(NULL, 'LM35', 'Temperatura', 1);
  
INSERT INTO Leitura VALUES
	(NULL, 20, DEFAULT, 3),
	(NULL, 21, DEFAULT, 3),
	(NULL, 22, DEFAULT, 3),
	(NULL, 23, DEFAULT, 3),
	(NULL, 24, DEFAULT, 3),
	(NULL, 25, DEFAULT, 3),
    (NULL, 55, DEFAULT, 4),
    (NULL, 56, DEFAULT, 4),
    (NULL, 57, DEFAULT, 4),
    (NULL, 58, DEFAULT, 4),
    (NULL, 59, DEFAULT, 4),
    (NULL, 60, DEFAULT, 4);
  
SELECT * FROM Leitura;

SELECT * FROM Empresa;