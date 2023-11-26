create database EXERC04
use EXERC04

drop database EXERC04
use master

CREATE TABLE CLIENTE (
cpf				char(12)			not null,
nome			varchar(255)		not null,
telefone		char(8)				not null, 
primary key (cpf)
)
GO

CREATE TABLE FORNECEDOR (
id				int					NOT NULL,
nome			varchar(100)		NOT NULL,
logradouro		varchar(100)		NOT NULL,
numero			char(5)				NOT NULL,
complemento		varchar(255)		NOT NULL,
cidade			varchar(255)		NOT NULL,
primary key(id)
)
GO

CREATE TABLE PRODUTO (
codigo			int					NOT NULL identity(1,1),
descricao		varchar(255)		NOT NULL,
fornecedor_id	int					NOT NULL,
preco			decimal(9,2)		NOT NULL,
primary key(codigo),
foreign key(fornecedor_id) references FORNECEDOR (id)
)
GO

CREATE TABLE venda (
codigo			int	 identity NOT NULL,
produto_codigo	int			NOT NULL,
cliente_cpf		char(12)	NOT NULL,
quantidade		int 				NOT NULL,
valor_total		decimal(9,2)		NOT NULL,
datinha			date				NOT NULL,
primary key(codigo),
foreign key (produto_codigo) references PRODUTO (codigo),
foreign key(cliente_cpf) references CLIENTE (cpf)
)
GO

insert into CLIENTE(cpf, nome, telefone)
values
('345789092-90', 'Julio Cesar', '82736541'),
('251865337-10', 'Maria Antonia', '87652314'),
('876273154-16', 'Luiz Carlos', '61289012'),
('791826398-00', 'Paulo Cesar', '90765273')
GO

insert into FORNECEDOR (id, nome, logradouro,numero,complemento,cidade)
values 
('1',	'LG',	'Rod. Bandeirantes',	'70000',	'Km 70',	'Itapeva'),
('2',	'Asus',	'Av. Nações Unidas',	'10206',	'Sala 225',	'São Paulo'),
('3',	'AMD',	'Av. Nações Unidas',	'10206',	'Sala 1095',	'São Paulo'),
('4',	'Leadership',	'Av. Nações Unidas',	'10206',	'Sala 87',	'São Paulo'),
('5',	'Inno',	'Av. Nações Unidas',	'10206',	'Sala 34',	'São Paulo')
GO

INSERT INTO PRODUTO (descricao, fornecedor_id, preco)
VALUES
('Monitor 19 pol.', 1, 449.99),
('Netbook 1GB Ram 4 Gb HD', 2, 699.99),
('Gravador de DVD - Sata', 1, 99.99),
('Leitor de CD', 1, 449.99),
('Processador - Phenom X3 - 2.1GHz', 3, 349.99),
('Mouse', 4, 19.99),
('Teclado', 4, 25.99),
('Placa de Video - Nvidia 9800 GTX - 256MB/256 bits', 5, 599.99);
GO


insert into VENDA (produto_codigo, cliente_cpf, quantidade, valor_total, datinha)
values
( '1', '251865337-10', '1', 449.99, '03/09/2009'),
( '4', '251865337-10', '1', 49.99, '03/09/2009'),
( '5', '251865337-10', '1', 349.99, '03/09/2009'),
( '6', '791826398-00', '4', 79.96, '06/09/2009'),
( '8', '876273154-16', '1', 599.99, '06/09/2009'),
( '3', '876273154-16', '1', 99.99, '06/09/2009'),
( '7', '876273154-16', '1', 25.99, '06/09/2009'),
( '2', '345789092-90', '2', 1399.98, '08/09/2009');



--Consultar no formato dd/mm/aaaa:
--Data da Venda 4
SELECT Convert (varchar(10),vend.datinha,103) as  'Data da venda'
from VENDA vend 
where vend.codigo= 4;

--Inserir na tabela Fornecedor, a coluna Telefone
--e os seguintes dados:

	--1	7216-5371
	--2	8715-3738
	--4	3654-6289

	alter table Fornecedor 
	add telefone char (11)

UPDATE FORNECEDOR
SET telefone = '72165371'
WHERE id = 1;

UPDATE FORNECEDOR
SET telefone = '87153738'
WHERE id = 2;

UPDATE FORNECEDOR
SET telefone = '36546289'
WHERE id = 4;

select*from FORNECEDOR

--Consultar por ordem alfabética de nome, o nome, o enderço concatenado e o telefone dos fornecedores
select forne.nome +' '+ forne.logradouro +' '+ CAST(forne.numero as varchar)+' '+ forne.complemento+' '+forne.cidade+' '+''+ forne.telefone as 'Consulta por ordem alfabetica'
from FORNECEDOR forne
where forne.telefone is not null
ORDER by forne.nome
--Consultar:
--Produto, quantidade e valor total do comprado por Julio Cesar
select*from PRODUTO
select*from CLIENTE
select*from venda

select  cli.nome,vend.quantidade, vend.valor_total as 'Compras total '
from venda vend inner join CLIENTE cli
on vend.cliente_cpf= cli.cpf
where cli.nome like '%Julio%'

--Data, no formato dd/mm/aaaa e valor total do produto comprado por  Paulo Cesar
select Convert (varchar(10),vend.datinha,103)as  'Data da venda', vend.valor_total as  'Valor Total'
from venda vend inner join CLIENTE cli
on vend.cliente_cpf= cli.cpf
where cli.nome like '%Paulo%'
--Consultar, em ordem decrescente, o nome e o preço de todos os produtos 
select prod.descricao, prod.preco as 'Todos os precos'
from PRODUTO prod
ORDER BY prod.descricao, prod.preco DESC

