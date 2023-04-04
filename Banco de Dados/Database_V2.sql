
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
	Telefone VARCHAR(15), -- telefone com 15 digitos no Maximo
    Email VARCHAR(50), -- Email com no maximo 50 digitos
    Senha CHAR(20), -- Senha ainda sem formatação de criptografia
    FKEmpresa_U INT, -- Chave Estrangeira da Tabela Empresa
		CONSTRAINT FKEmpresa_U FOREIGN KEY (FKEmpresa_U)
			REFERENCES Empresa(idEmpresa)
);

-- Criação da tabela onde ficara as informações do local onde será retirada as leituras
CREATE TABLE Localização(
	idLocal INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primaria
    Nome VARCHAR(80), -- Nome do Local EX(Sala 01,Sala 02)
    FKEmpresa_L INT, -- Chave Estrangeira da Tabela Empresa
		CONSTRAINT FKEmpresa_L FOREIGN KEY (FKEmpresa_L)
			REFERENCES Empresa(idEmpresa)
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

-- Criação da tabela onde ficara guardado os limites(min e max) dos sensores
CREATE TABLE Limite_Parametros(
	idLimite INT AUTO_INCREMENT, -- Primeiro componente da Chave Primaria
    Min_Parametros DECIMAL(4,2), -- Valor minimo que pode receber da leitura sem danificar o produto 
    Max_Parametros DECIMAL(4,2), -- Valor maximo que pode receber da leitura sem danificar o produto 
    FKLocal_LM INT, -- Componente da Chave Primaria Que refere a Tabela Localizaçao
		CONSTRAINT FKLocal_LM FOREIGN KEY (FKLocal_LM)
			REFERENCES Localização(idLocal),
    FKSensor_LM INT, -- Componente da Chave Primaria que refere a Tabela Sensores
		CONSTRAINT FKSensor_LM FOREIGN KEY (FKSensor_LM)
			REFERENCES Sensores(idSensor),
	CONSTRAINT pkComposta PRIMARY KEY (idLimite,FKLocal_LM,FKSensor_LM) -- Chave Primaria Composta de Tres Elementos 
);

-- Criação da tabela que fara o Relacionamento dos sensores com os resultados e os clientes
CREATE TABLE Leitura (
	idCaptura INT AUTO_INCREMENT, -- Componente da Chave Primaria 
    Leitura DECIMAL(4,2), -- Resultado do sensor
    data_hora DATETIME, -- Data e hora em que os resultados foram computados
    FKSensor_LE INT, -- Componente da Chave Primaria que refere a Tabela Sensores
		CONSTRAINT FKSensor_LE FOREIGN KEY (FKSensor_LE)
			REFERENCES Sensores(idSensor),
	CONSTRAINT pkComposta PRIMARY KEY (idCaptura,FKSensor_LE) -- Chave Primaria composta de Dois elementos 
);

-- Inserção de Dados FANTASIOSOS para Testes 

-- Inserção na tabela Empresa
INSERT INTO Empresa VALUES 
	(NULL, 'Dois irmãos Transportadora', '12.123.123/0001-12.', 'Rua das Palmeiras', '8', 'Jardim Vitoria', 'São Paulo','(11)95959-9595', 'doisirmãos@gmail.com'),
	(NULL, 'Tres irmãos Transportadora', '21.321.321/0001-21.', 'Rua das Palmas', '23', 'Vila Gumercindo', 'São Paulo','(11)98989-9898', 'tresirmãos@gmail.com'),
	(NULL, 'Quatro irmãos Transportadora', '45.456.456/0001-45.', 'Rua das Palmeiras', '512', 'Borba gato', 'São Paulo','(11)93939-9393', 'quatroirmãos@gmail.com'),
	(NULL, 'Cinco irmãos Transportadora', '54.654.654/0001-54.', 'Rua das Rosas', '8', 'Vila Olimpia', 'São Paulo','(11)91919-9191', 'cincoirmãos@gmail.com'),
	(NULL, 'Seis irmãos Transportadora', '34.267.159/0001-88.', 'Rua das Margaridas', '15', 'Jardim Vitoria', 'São Paulo','(11)92929-9292', 'seisirmãos@gmail.com'),
	(NULL, 'sete irmãos Transportadora', '27.369.654/0001-33.', 'Rua das Rosas', '28', 'Vila Olimpia', 'São Paulo','(11)94949-9494', 'seteirmãos@gmail.com');
 
-- Inserção na Tabela Usuario
INSERT INTO Usuario VALUES
	(NULL, 'Davi', '(11)987654321', 'davi@gmail.com', 'teste_numero_01_____', 1),
	(NULL, 'Simone', '(11)912345678', 'simone@gmail.com', 'teste_numero_02_____', 2),
	(NULL, 'Bianca', '(11)987651234', 'bianca@gmail.com', 'teste_numero_03_____', 3),
	(NULL, 'César', '(11)912348765', 'cesar@gmail.com', 'teste_numero_04_____', 4),
	(NULL, 'Livia', '(11)918726354', 'livia@gmail.com', 'teste_numero_05_____', 5),
	(NULL, 'Guilherme', '(11)981273645', 'guilherme@gmail.com', 'teste_numero_06_____', 5);

-- inserção na tabela localização
INSERT INTO Localização VALUES
	(NULL, 'Container D1', 1),
	(NULL, 'Container T1', 2),
	(NULL, 'Container Q1', 3),
	(NULL, 'Container C1', 4),
	(NULL, 'Container S1', 5),
	(NULL, 'Container S1', 6),
	(NULL, 'Container D2', 1),
	(NULL, 'Container T3', 2);

-- Inserção na tabela Sensores
INSERT INTO Sensores VALUES 
	(NULL, 'DHT11', 'Umidade', 1),
	(NULL, 'LM35', 'Temperatura', 1),
	(NULL, 'DHT11', 'Umidade', 2),
	(NULL, 'LM35', 'Temperatura', 2),
	(NULL, 'DHT11', 'Umidade', 3),
	(NULL, 'LM35', 'Temperatura', 3),
	(NULL, 'DHT11', 'Umidade', 4),
	(NULL, 'LM35', 'Temperatura', 4),
	(NULL, 'DHT11', 'Umidade', 5),
	(NULL, 'LM35', 'Temperatura', 5),
	(NULL, 'DHT11', 'Umidade', 6),
	(NULL, 'LM35', 'Temperatura', 6),
	(NULL, 'DHT11', 'Umidade', 7),
	(NULL, 'LM35', 'Temperatura', 7),
	(NULL, 'DHT11', 'Umidade', 8),
	(NULL, 'LM35', 'Temperatura', 8);
	
-- Inserção na Tabela Limite_Parametros (Para limitar determinado dado)
INSERT INTO Limite_Parametros VALUES 
	(NULL, 60.00, 80.00, 1, 1),
	(NULL, 15.00, 20.00, 1, 2),
	(NULL, 60.00, 80.00, 2, 3),
	(NULL, 15.00, 20.00, 2, 4),
	(NULL, 60.00, 80.00, 3, 5),
	(NULL, 15.00, 20.00, 3, 6),
	(NULL, 60.00, 80.00, 4, 7),
	(NULL, 15.00, 20.00, 4, 8),
	(NULL, 60.00, 80.00, 5, 9),
	(NULL, 15.00, 20.00, 5, 10),
	(NULL, 60.00, 80.00, 6, 11),
	(NULL, 15.00, 20.00, 6, 12),
	(NULL, 60.00, 80.00, 7, 13),
	(NULL, 15.00, 20.00, 7, 14),
	(NULL, 60.00, 80.00, 8, 15),
	(NULL, 15.00, 20.00, 8, 16);
  
-- FORMATO DE INSERIR DATETIME YYYY-MM-DD hh:mm:ss[.nnn]
  
-- iNSERÇÃO DE DADOS DE LEITURAS FANTASIOSAS
INSERT INTO Leitura VALUES 
	(NULL, 65.24, '2023-04-03 10:00:00', 1),
	(NULL, 16.29, '2023-04-03 10:00:00', 2),
	(NULL, 75.84, '2023-04-03 11:00:00', 3),
    (NULL, 15.36, '2023-04-03 11:00:00', 4),
	(NULL, 62.44, '2023-04-03 12:00:00', 5),
    (NULL, 18.96, '2023-04-03 12:00:00', 6),
	(NULL, 60.99, '2023-04-03 13:00:00', 7),
    (NULL, 12.79, '2023-04-03 13:00:00', 8),
	(NULL, 81.46, '2023-04-03 14:00:00', 9),
    (NULL, 19.19, '2023-04-03 14:00:00', 10),
	(NULL, 78.95, '2023-04-03 15:00:00', 11),
    (NULL, 20.65, '2023-04-03 15:00:00', 12),
	(NULL, 54.64, '2023-04-03 16:00:00', 13),
    (NULL, 26.98, '2023-04-03 16:00:00', 14),
	(NULL, 89.56, '2023-04-03 17:00:00', 15),
    (NULL, 14.89, '2023-04-03 17:00:00', 16);
    
-- SELECTS PARA TESTE

SELECT * FROM 
	Empresa LEFT JOIN Usuario
		ON idEmpresa = FKEmpresa_U;

SELECT * FROM 
	Empresa JOIN Localização
		ON idEmpresa = FKEmpresa_L;

SELECT * FROM 
	Localização JOIN Limite_Parametros
		ON idLocal = FKLocal_LM ORDER BY idLocal ASC;
        
SELECT * FROM 
	Sensores JOIN Limite_Parametros
		ON idSensor = FKSensor_LM;

SELECT * FROM 
	Localização JOIN Sensores
		ON idLocal = FKLocal_S;
        
SELECT * FROM 
	Leitura JOIN Sensores
		ON idSensor = FKSensor_LE
			WHERE Sensores.Tipo = 'Temperatura';
            
SELECT * FROM 
	Leitura JOIN Sensores
		ON idSensor = FKSensor_LE
			WHERE Sensores.Tipo = 'Umidade';
            