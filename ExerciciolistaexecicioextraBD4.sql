create database exerc4lista1bd
use exerc4lista1bd

drop database exerc4lista1bd
use master

CREATE TABLE Cliente (
cpf char(11),
nome varchar(255),
telefone char(8), 
primary key (cpf)
)
GO

CREATE TABLE fornecedor (
id int,
nome varchar(100),
logradouro varchar(100),
numero char(5),
complemento varchar(255),
cidade varchar(255)
primary key(id)
)
GO

CREATE TABLE produto (
codigo int identity(1,1),
descriçao varchar(255),
fornecedor int,
preco decimal(9,2),
primary key(codigo),
foreign key(fornecedor) references fornecedor (id)
)
GO

CREATE TABLE venda (
codigo int,
produto int,
cliente char(11),
quantidade int ,
valor_total decimal(9,2),
data date,
primary key(codigo),
foreign key (produto) references produto (codigo),
foreign key(cliente) references cliente (cpf)
)
GO

insert into Cliente (cpf,nome,telefone) 
values('34578909290', 'Julio Cesar', '82736541')
go
insert into Cliente (cpf,nome,telefone) 
values('251865337-10', 'Maria Antonia', '87652314')
go
insert into Cliente (cpf,nome,telefone) 
values('87627315416', 'Luiz Carlos', '61289012')
go
insert into Cliente (cpf,nome,telefone) 
values('79182639800', 'Paulo Cesar', '90765273')
go

insert into produto(descriçao,fornecedor,preco)
values('Monitor 19 pol.',1, '449,99')
go
insert into produto(descriçao,fornecedor,preco)
values('Netbook 1GB Ram 4 Gb HD',2, '699,99')
go
insert into produto(descriçao,fornecedor,preco)
values('Gravador de DVD - Sata',1, '99,99')
go
insert into produto(descriçao,fornecedor,preco)
values('Leitor de CD',1,'449,99')
go
insert into produto(descriçao,fornecedor,preco)
values('Processador - Phenom X3 - 2.1GHz',3,'349,99')
go
insert into produto(descriçao,fornecedor,preco)
values('Mouse',4,'19,99')
go
insert into produto(descriçao,fornecedor,preco)
values('Teclado',4,'25,99')
go
insert into produto(descriçao,fornecedor,preco)
values('Placa de Video - Nvidia 9800 GTX - 256MB/256 bits',5,'599,99')


insert into fornecedor ( nome, logradouro,numero,complemento,cidade)
values ('LG', 'Rod. Bandeirantes','70000', 'km 70', 'Sao paulo')

insert into fornecedor ( nome, logradouro,numero,complemento,cidade)
values ('LG', 'Rod. Bandeirantes','70000', 'km 70', 'Sao paulo')


select vend.data as 'Data da venda',+ ''+ Convert (varchar(10),vend.data,103)
from venda vend 
where vend.codigo= 4;

