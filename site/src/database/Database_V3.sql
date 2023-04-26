DROP DATABASE Secure_Ship;
-- Criação do Banco de Dados
CREATE DATABASE Secure_Ship;

USE Secure_Ship;

DROP TABLE limite_parametros;
DROP TABLE empresa;

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

-- Criação da tabela onde ficara guardado os limites(min e max) dos sensores
CREATE TABLE Limite_Parametros(
	idLimite INT PRIMARY KEY AUTO_INCREMENT, -- Primeiro componente da Chave Primaria
    Min_Temperatura FLOAT, -- Valor minimo de temp. que pode receber da leitura sem danificar o produto 
    Max_Temperatura FLOAT, -- Valor maximo de temp. que pode receber da leitura sem danificar o produto 
    Min_Umidade FLOAT, -- Valor minimo de temp. que pode receber da leitura sem danificar o produto 
    Max_Umidade FLOAT -- Valor maximo de temp. que pode receber da leitura sem danificar o produto 
);

-- Criação da tabela onde ficara as informações do local onde será retirada as leituras
CREATE TABLE Locallização(
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
			REFERENCES Locallização(idLocal)
);

-- Criação da tabela que fara o Relacionamento dos sensores com os resultados e os clientes
CREATE TABLE Leitura (
	idLeitura INT AUTO_INCREMENT, -- Componente da Chave Primaria 
    Leitura FLOAT,-- Resultado do sensor
    Data_Hora DATETIME DEFAULT CURRENT_TIMESTAMP, -- Data e hora em que os resultados foram computados
    FKSensor_LE INT, -- Componente da Chave Primaria que refere a Tabela Sensores
		CONSTRAINT FKSensor_LE FOREIGN KEY (FKSensor_LE)
			REFERENCES Sensores(idSensor),
	CONSTRAINT pkComposta PRIMARY KEY (idLeitura,FKSensor_LE) -- Chave Primaria composta de Dois elementos 
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
  
INSERT INTO Locallização VALUES
	(NULL, 'Container 1', NULL, NULL);
  
INSERT INTO Sensores VALUES
	(NULL, 'DHT11', 'Umidade', 1),
	(NULL, 'LM35', 'Temperatura', 1);
  
  
SELECT * FROM Leitura;

INSERT INTO Usuario VALUES
	(NULL, 'Davi Rodrigues', 'davirodrigues@gmail.com', '959164441', '123456789123456789', 1, NULL);

SELECT * FROM Empresa;