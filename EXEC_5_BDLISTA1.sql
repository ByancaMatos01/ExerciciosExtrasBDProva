Create Database EXERC5_BDlist1
use EXERC5_BDlist1
use master
drop database EXERC5_BDlist1
create table Fornecedor(
codigo int identity (1001,1),
nome varchar(255),
atividade varchar(255),
telefone char(8)
primary key(codigo)
)
go
create table Produto (
codigo int identity(1,1),
nome varchar (255),
valor_unitario decimal(6,2),
estoque int,
descricao varchar(255),
cod_fornecedor int
primary key(codigo)
foreign key(cod_fornecedor) references Fornecedor (codigo)
)
go
create table Cliente(
codigo int identity (33601,1),
nome varchar(255),
logradouro varchar(255),
numero int,
telefone char(8),
data_nasc date
primary key(codigo)
)
go
create table Pedido (
codigo int,
codigo_cliente int,
codigo_produto int,
quantidade int,
previsao_entrega date
primary key(codigo, codigo_cliente, codigo_produto),
foreign key (codigo_cliente) references Cliente (codigo),
foreign key (codigo_produto) references Produto (codigo)

)

insert into Fornecedor (nome, atividade, telefone)
Values ('Estrela','Brinquedo','41525898'),
       ('Lacta','Chocolate','42698596'),
	    ('Asus','Informática','52014596'),
		 ('Tramontina','Utensílios Domésticos','50563985'),
		  ('Grow','Brinquedos','47896325'),
		   ('Mattel','Bonecos','59865898')

	   select *from Fornecedor



INSERT INTO Produto (nome, valor_unitario, estoque, descricao, cod_fornecedor)
VALUES 
('Banco Imobiliário', 65.00, 15, 'Versão Super Luxo', 1001),
('Puzzle 5000 peças', 50.00, 5, 'Mapas Mundo', 1005),
('Faqueiro', 350.00, 0, '120 peças', 1004),
('Jogo para churrasco', 75.00, 3, '7 peças', 1004),
('Tablet', 750.00, 29, 'Tablet', 1003),
('Detetive', 49.00, 0, 'Nova versão jogo', 1001),
('Chocolate paçoquinha', 6.00, 0, 'Barra', 1002),
('Galak', 5.00, 65, 'Barra', 1002);

select* from Produto

Insert into Cliente (nome, logradouro, numero, telefone, data_nasc)
Values ('Maria Clara', 'R. 1 de Abril', 870, '96325874','2000-08-15'),
       ('Alberto Souza', 'R. XV de Novembro', 987, '95873625','1985-02-02'),
	   ('Sonia Silva', 'R. Voluntários da Pátria', 1151, '75418596','1957-08-23'),
	   ('José Sobrinho', 'Av. Paulista', 250, '85236547','1986-12-09'),
	   ('Carlos Camargo', 'Av. Tiquatira', 9652, '75896325','1971-03-25')

	   select *from Cliente

INSERT INTO Pedido (codigo, codigo_cliente, codigo_produto, quantidade, previsao_entrega)
VALUES
(99001, 33601, 1, 1, '2012-06-07'),
(99001, 33601, 2, 1, '2012-06-07'),
(99001, 33601, 8, 3, '2012-06-09'),
(99002, 33602, 2, 1, '2012-06-09'),
(99002, 33602, 4, 3, '2012-06-09'),
(99003, 33605, 5, 1, '2012-06-15');

select* from pedido
select*from Produto
select*from Fornecedor
select* from Cliente
--Consultar a quantidade, valor total e valor total com desconto (25%) dos itens comprados par Maria Clara.
select (ped.quantidade*prod.valor_unitario) as ValorTotal , (ped.quantidade* prod.valor_unitario)* 0.75 as TotalDesconto
from Pedido ped
Inner Join Produto prod 
on prod.codigo= ped.codigo_produto
inner join Cliente cli
on cli.codigo= ped.codigo_cliente
where cli.nome like '%Maria%'

--Verificar quais brinquedos não tem itens em estoque.
select prod.nome as 'não tem item de estoque'
from Produto prod inner join Fornecedor forn
on prod.cod_fornecedor=forn.codigo
where forn.atividade like '%Brinquedo%' 
AND prod.estoque=0;

---Alterar para reduzir em 10% o valor das barras de chocolate.
Update Produto
set valor_unitario= valor_unitario * 0.9
where descricao like '%Barra%' 
select*from Produto

---Alterar a quantidade em estoque do faqueiro para 10 peças.

UPDATE Produto
set estoque=10
WHERE nome like '%faqueiro%'

select *from Produto

---Consultar quantos clientes tem mais de 40 anos.
select nome as 'nome do cliente', DATEDIFF(YEAR, data_nasc, GETDATE()) as 'Cliente acima de 40'
from Cliente 
where DATEDIFF(year,data_nasc, GetDate()) > 40

---Consultar Nome e telefone dos fornecedores de Brinquedos e Chocolate.
select nome as 'Nome dos fornecedores ', telefone as 'Telefone'
from Fornecedor
where atividade like '%Brinquedo%' or atividade like '%Chocolate%' 
-- Consultar nome e desconto de 25% no preço dos produtos que custam menos de R$50,00
SELECT nome, valor_unitario * 0.25 AS Desconto
FROM Produto
WHERE valor_unitario < 50.00;

---Consultar nome e aumento de 10% no preço dos produtos que custam mais de R$100,00
select nome, valor_unitario + valor_unitario * 0.9  AS 'CUSTAM MAIS DE 100'
FROM produto
where valor_unitario >100.00

--Consultar desconto de 15% no valor total de cada produto da venda 99001.
SELECT
    pro.nome AS 'Nome do Produto',
    pro.valor_unitario AS 'Preço Unitário',
    ped.quantidade AS 'Quantidade',
    pro.valor_unitario * ped.quantidade AS 'Valor Total',
    pro.valor_unitario * ped.quantidade * 0.15 AS 'Desconto de 15%'
FROM
    Pedido ped
INNER JOIN
    Produto pro ON ped.codigo_produto = pro.codigo
WHERE
    ped.codigo = 99001;
---Consultar Código do pedido, nome do cliente e idade atual do cliente
select DISTINCT
ped.codigo as 'codigo do pedido',
cli.nome as 'nome do cliente',
DateDiff(Year, cli.data_nasc, GETDATE()) as 'Idade dos clientes'
from Pedido ped Inner Join Cliente cli
on ped.codigo_cliente= cli.codigo



