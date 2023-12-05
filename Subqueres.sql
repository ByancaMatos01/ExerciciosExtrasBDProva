CREATE DATABASE transporte
GO
USE transporte
GO
CREATE TABLE motorista
(
	codigo INT IDENTITY(12341, 1) NOT NULL,
	nome VARCHAR(100) NOT NULL,
	data_nascimento DATE NOT NULL,
	naturalidade VARCHAR(50) NOT NULL
	PRIMARY KEY (codigo)
)
GO
CREATE TABLE onibus
(
	placa CHAR(7) NOT NULL,
	marca VARCHAR(25) NOT NULL,
	ano INT NOT NULL,
	descricao VARCHAR(50) NOT NULL
	PRIMARY KEY (placa)
)
GO
CREATE TABLE viagem
(
	codigo INT IDENTITY(101, 1) NOT NULL,
	onibus CHAR(7) NOT NULL,
	motorista INT NOT NULL,
	hora_saida TIME NOT NULL,
	hora_chegada TIME NOT NULL,
	destino VARCHAR(50) NOT NULL
	PRIMARY KEY (codigo)
	FOREIGN KEY (onibus) REFERENCES onibus (placa),
	FOREIGN KEY (motorista) REFERENCES motorista (codigo)
)

INSERT INTO motorista
VALUES
('Julio Cesar', '1978-04-18', 'São Paulo'),
('Mario Carmo', '2002-07-29', 'Americana'),
('Lucio Castro', '1969-12-01', 'Campinas'),
('André Figueiredo', '1999-05-14', 'São Paulo'),
('Luiz Carlos', '2001-01-09', 'São Paulo')

INSERT INTO onibus
VALUES
('adf0965', 'Mercedes', 1999, 'Leito'),
('bhg7654', 'Mercedes', 2002, 'Sem Banheiro'),
('dtr2093', 'Mercedes', 2001, 'Ar Condicionado'),
('gui7625', 'Volvo', 2001, 'Ar Condicionado')

INSERT INTO viagem
VALUES
('adf0965', 12343, '10:00:00', '12:00:00', 'Campinas'),
('gui7625', 12341, '07:00:00', '12:00:00', 'Araraquara'),
('bhg7654', 12345, '14:00:00', '22:00:00', 'Rio de Janeiro'),
('dtr2093', 12344, '18:00:00', '21:00:00', 'Sorocaba')

select*from viagem
select*from motorista
select*from onibus
--Da tabela viagem, todas as horas de chegada e saída, convertidas em formato HH:mm (108) e seus destinos.
select CONVERT(Varchar, vi.hora_saida,108) as 'Saida de viagem', CONVERT(varchar,vi.hora_chegada,108) as 'Hora chegada', vi.destino as'Destino'
from viagem vi
--Com subquery, o nome do motorista que viaja para Sorocaba.
select mot.nome 
from motorista mot 
where codigo IN( select viagem.motorista as 'Nome' 
                  from viagem
				  where viagem.destino='Sorocaba'
				  )

--Com subquery, a descrição do ônibus que vai para o Rio de Janeiro.
select oni.descricao as 'Descricao'
from onibus oni
where oni.placa in( select onibus
                    from viagem
					where destino like 'Rio%'
					)

--Com Subquery, a descrição, a marca e o ano do ônibus dirigido por Luiz Carlos.
select oni.descricao as 'Descricao', oni.marca as 'Marca', oni.ano as 'Ano'
from onibus oni
where oni.placa in(select onibus
                    from viagem
					where motorista in(
					select codigo
					from motorista
					where nome like'Luiz%'
					)
					)
--O nome, a idade e a naturalidade dos motoristas com mais de 30 anos.
select nome as 'Nome do motorista', naturalidade as 'Naturalidade'
from motorista
where DateDiff(year,data_nascimento,GETDATE())>30
