
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
    FKEmpresa_U INT, -- Chave Estrangeira da Tabela Empresa
		CONSTRAINT FKEmpresa_U FOREIGN KEY (FKEmpresa_U)
			REFERENCES Empresa(idEmpresa),
	FKAdmin_U INT, -- Chave Estrangeira de Recursividade (User - Admin)
		CONSTRAINT FKAdmin_U FOREIGN KEY (FKAdmin_U)
			REFERENCES Usuario(idUsuario)
);

-- Criação da tabela onde ficara as informações do local onde será retirada as leituras
CREATE TABLE Local(
	idLocal INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primaria
    Nome VARCHAR(80), -- Nome do Local EX(Sala 01,Sala 02)
    FKEmpresa_L INT, -- Chave Estrangeira da Tabela Empresa
		CONSTRAINT FKEmpresa_L FOREIGN KEY (FKEmpresa_L)
			REFERENCES Empresa(idEmpresa),
	FKLimite_L INT, -- Chave Estrangeira da parametrização de limites (1-n)
		CONSTRAINT FKLimite_L FOREIGN KEY (FKLimite_L) 
			REFERENCES Limite_Parametros(idLimite)
);

-- Criação de uma tabela exclusiva para os sensores (não para os resultados somente para os sensores)
CREATE TABLE Sensores(
	idSensor INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primaria
    Nome VARCHAR(20), -- Nome do sensor
    Tipo VARCHAR(30), -- Tipagem do Sensor EX(Temperatura,Umidade,Luminosidade)
    FKLocal_S INT, -- Chave Estrangeira da Tabela Localizaçao
		CONSTRAINT FKLocal_S FOREIGN KEY (FKLocal_S)
			REFERENCES Local(idLocal)
);

-- Criação da tabela onde ficara guardado os limites(min e max) dos sensores
CREATE TABLE Limite_Parametros(
	idLimite INT PRIMARY KEY AUTO_INCREMENT, -- Primeiro componente da Chave Primaria
    Min_Temperatura FLOAT, -- Valor minimo de temp. que pode receber da leitura sem danificar o produto 
    Max_Temperatura FLOAT, -- Valor maximo de temp. que pode receber da leitura sem danificar o produto 
    Min_Umidade FLOAT, -- Valor minimo de temp. que pode receber da leitura sem danificar o produto 
    Max_Umidade FLOAT -- Valor maximo de temp. que pode receber da leitura sem danificar o produto 
);

-- Criação da tabela que fara o Relacionamento dos sensores com os resultados e os clientes
CREATE TABLE Leitura (
	idLeitura INT AUTO_INCREMENT, -- Componente da Chave Primaria 
    Leitura_Temp FLOAT,-- Resultado do sensor
    Leitura_Umid FLOAT,-- Resultado do sensor
    Data_Hora DATETIME, -- Data e hora em que os resultados foram computados
    FKSensor_LE INT, -- Componente da Chave Primaria que refere a Tabela Sensores
		CONSTRAINT FKSensor_LE FOREIGN KEY (FKSensor_LE)
			REFERENCES Sensores(idSensor),
	CONSTRAINT pkComposta PRIMARY KEY (idLeitura,FKSensor_LE) -- Chave Primaria composta de Dois elementos 
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
	(NULL, 'Davi', 'davi@gmail.com', '95161-0726', 'teste_numero_01_____', 1, NULL); -- USER ADMIN FKADMIN NULL
    
INSERT INTO Usuario VALUES
	(NULL, 'Bianca', 'bianca@gmail.com', '95161-0726', 'teste_numero_01_____', 1, 1), -- USER COMUM DA EMPRESA 1
	(NULL, 'Guilherme', 'guilherme@gmail.com', '95161-0726', 'teste_numero_02_____', 1, 1), -- USER COMUM DA EMPRESA 1
	(NULL, 'Simone', 'simone@gmail.com', '95161-0726', 'teste_numero_02_____', 1, 1); -- USER COMUM DA EMPRESA 1
    

-- inserção na tabela localização
INSERT INTO Local VALUES
	(NULL, 'Container D1', 1, 1), -- todos os registros são da empresa 1
	(NULL, 'Container T1', 1, 1),
	(NULL, 'Container Q1', 1, 1),
	(NULL, 'Container C1', 1, 1),
	(NULL, 'Container S1', 1, 1),
	(NULL, 'Container S1', 1, 1),
	(NULL, 'Container D2', 1, 1),
	(NULL, 'Container T3', 1, 1);

-- Inserção na tabela Sensores
INSERT INTO Sensores VALUES 
	(NULL, 'DHT11', 'Umidade', 1),
	(NULL, 'LM35', 'Temperatura', 1);
	
	
-- Inserção na Tabela Limite_Parametros (Para limitar determinado dado)
INSERT INTO Limite_Parametros VALUES 
	(NULL, 15, 25, 45, 50); -- pode ser usado em mais de um lugar por isso não possui FK

-- FORMATO DE INSERIR DATETIME YYYY-MM-DD hh:mm:ss[.nnn]
  
-- iNSERÇÃO DE DADOS DE LEITURAS FANTASIOSAS
INSERT INTO Leitura VALUES 
	(NULL, 25.24, 45.56, '2023-04-03 10:00:00', 1),
	(NULL, 26.30, 47.37, '2023-04-03 10:30:00', 1),
	(NULL, 23.12, 46.21, '2023-04-03 11:00:00', 1),
	(NULL, 25.12, 40.84, '2023-04-03 11:30:00', 1),
	(NULL, 27.45, 44.24, '2023-04-03 12:00:00', 1),
	(NULL, 26.76, 45.43, '2023-04-03 12:30:00', 1);
	
    
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
        

SELECT * FROM 
	Local JOIN Sensores
		ON idLocal = FKLocal_S;
        
