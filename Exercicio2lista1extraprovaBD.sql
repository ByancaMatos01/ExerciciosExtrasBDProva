create database exercicio2
use exercicio2
drop database exercicio2
use master
CREATE TABLE Carro (
placa varchar(07) not null,
marca varchar(20) not null,
modelo varchar(20) not null,
cor varchar(20) not null,
ano int  not null,
primary key (placa)
)

Create table Pecas(
codigo int identity(1,1),
nome varchar(255),
valor int,
primary key(codigo)
)

Create Table servico(
carro varchar (07) not null,
peca_servico int not null,
quantidade int not null,
valor int not null,
data date not null,
primary key(carro, peca_servico,data),
foreign key(carro) references Cliente (carro),
foreign key (peca_servico) references Pecas (codigo)
)

create table cliente(
nome varchar (255),
lougradouro varchar(255),
Numero int not null,
bairro varchar(255) not null,
telefone char(9) not null,
carro varchar(07) not null,
primary key (carro),
foreign key (carro) references carro (placa)
)

INSERT INTO cliente VALUES
('João Alves', 'R. Pereira Barreto', 1258, 'Jd. Oliveiras', '2154-9658', 'DXO9876'),
('Ana Maria', 'R. 7 de Setembro', 259, 'Centro', '9658-8541', 'LKM7380'),
('Clara Oliveira', 'Av. Nações Unidas', 10254, 'Pinheiros', '2458-9658', 'EGT4631'),
('José Simões', 'R. XV de Novembro', 36, 'Água Branca', '7895-2459', 'BCD7521'),
('Paula Rocha', 'R. Anhaia', 548, 'Barra Funda', '6958-2548', 'AFT9087')

INSERT INTO carro VALUES
('AFT9087', 'VW', 'Gol', 'Preto', 2007),
('DXO9876', 'Ford', 'Ka', 'Azul', 2000),
('EGT4631', 'Renault', 'Clio', 'Verde', 2004),
('LKM7380', 'Fiat', 'Palio', 'Prata', 1997),
('BCD7521', 'Ford', 'Fiesta', 'Preto', 1999)

INSERT INTO Pecas VALUES
('Vela', 70),
('Correia Dentada', 125),
('Trambulador', 90),
('Filtro de Ar', 30)

INSERT INTO servico VALUES
('DXO9876', 1, 4, 280, '2020-08-01'),
('DXO9876', 4, 1, 30, '2020-08-01'),
('EGT4631', 3, 1, 90, '2020-08-02'),
('DXO9876', 2, 1, 125, '2020-08-07')

select*from Servico
select*from cliente

select*from Pecas
select*from Carro



---Consulta com subqueres 
---Telefone do dono do carro Ka, Azul
select c.telefone as 'Telefone'
from cliente c
Inner join carro car ON c.carro=car.placa
where car.modelo = 'Ka' AND car.cor = 'Azul'

--Endereço concatenado do cliente que fez o serviço do dia 2020-08-02
select c.lougradouro +' '+ CAST( c.numero as varchar(11)) +' '+ c.bairro as 'Endereco'
from cliente c Inner Join servico s 
ON c.carro=s.carro
where s.data='2020-08-02'
--Placas dos carros de anos anteriores a 2001
select c.ano as 'Carros posteriores', c.modelo as 'Modelo'
from Carro c
where c.ano <2001

-- Código e nome das peças que custam menos de R$80,00
select  Cast (p.codigo as varchar(1))+ ' '+ p.nome  as 'PECAS BARATAS'
FROM pecas p
where p.valor <80
