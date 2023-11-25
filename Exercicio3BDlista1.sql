create database exerc3
use exerc3
create table pacientes(
cpf char(11),
nome varchar(255),
rua varchar(255),
numero int,
bairro varchar(255),
telefone char(8),
data_nasc date
primary key(cpf)
)
go
create table medico (
codigo int identity(1,1),
nome varchar(255),
especialidade varchar(255),
primary key(codigo)
)
go
create table prontuario(
data date,
cpf_paciente char (11),
codigo_medico int,
diagnostico varchar(255),
medicamento varchar(255),
primary key(data,cpf_paciente,codigo_medico),
foreign key(cpf_paciente) references pacientes (cpf),
foreign key (codigo_medico) references medico (codigo)
)
 Insert into pacientes values 
 ('35454562890','José Rubens','Campos Salles',2750,'Centro','21450998','1954-10-18'),
 ('29865439810', 'Ana Claudia', 'Sete de Setembro', 178, 'Centro', '97382764', '1960-05-29'),
('82176534800', 'Marcos Aurélio', 'Timóteo Penteado', 236, 'Vila Galvão', '68172651', '1980-09-24'),
('12386758770', 'Maria Rita', 'Castello Branco', 7765, 'Vila Rosália', ' ', '1975-03-30'),
('92173458910', 'Joana de Souza', 'XV de Novembro', 298, 'Centro', '21276578', '1944-04-24')

INSERT INTO medico VALUES
( 'Wilson Cesar', 'Pediatra'),
( 'Marcia Matos', 'Geriatra'),
( 'Carolina Oliveira', 'Ortopedista'),
( 'Vinicius Araujo', 'Clínico Geral')

INSERT INTO prontuario VALUES
('2020-09-10', '35454562890', 2, 'Reumatismo', 'Celebra'),
('2020-09-10', '92173458910', 2, 'Renite Alérgica', 'Allegra'),
('2020-09-12', '29865439810', 1, 'Inflamação de garganta', 'Nimesulida'),
('2020-09-13', '35454562890', 2, 'H1N1', 'Tamiflu'),
('2020-09-15', '82176534800', 4, 'Gripe', 'Resprin'),
('2020-09-15', '12386758770', 3, 'Braço Quebrado', 'Dorflex + Gesso')
-------------------------------------------------------------------------------------------------------------------------
select *from pacientes
select*from medico
select*from prontuario
-------------Consultas-----------------------------------------------------
--Nome e Endereço (concatenado) dos pacientes com mais de 50 anos
select p.nome+ ' '+ p.rua+ ' '+ cast(p.numero  as varchar(10))+' '+bairro as 'Endereco'
from pacientes p
where DATEDIFF(YEAR, p.data_nasc, GETDATE()) > 50 -- toda vez que for pegar idade mudar para ano e depois get date não esquecer 

--Qual a especialidade de Carolina Oliveira

select m.especialidade as 'especialidade'
from medico m
where m.nome like '%Carolina%'

--Qual medicamento receitado para reumatismo
select pront.medicamento as ' Nome do medicamento para Tratamento'
from prontuario pront
where pront.diagnostico= 'Reumatismo'

--Diagnóstico e Medicamento do paciente José Rubens em suas consultas
select pront.diagnostico + ' '+ pront.medicamento as 'Diagnostico / Medicamentos'
from prontuario pront inner join pacientes ps
on pront.cpf_paciente = ps.cpf
where ps.nome like '%Rubens%'

---Nome e especialidade do(s) Médico(s) que atenderam José Rubens. Caso a especialidade tenha mais de 3 concatenada com um ponto final (.)	
SELECT m.nome,
       CASE
        WHEN LEN(m.especialidade) <= 3 THEN especialidade
        ELSE LEFT(m.especialidade, 3) + '.'
    END AS especialidade_abreviada
FROM prontuario p INNER JOIN pacientes pac
ON p.cpf_paciente = pac.cpf
INNER JOIN medico m ON p.codigo_medico = m.codigo 
WHERE pac.nome = 'José Rubens'
----------------------------------------------------------------------------------------------------------------------
--CPF (Com a máscara XXX.XXX.XXX-XX), Nome, Endereço completo (Rua, nº - Bairro), Telefone (Caso nulo, mostrar um traço (-)) dos pacientes do médico Vinicius

SELECT p.nome+ ' '+ SUBSTRING (p.cpf,1,3) + '.' + SUBSTRING(p.cpf,4,3) + '.' + SUBSTRING(p.cpf,7,3) + '.' + SUBSTRING(p.cpf,10,2)+ ''+
CONCAT(p.rua, p.numero, p.bairro) +''+
CASE
      WHEN LEN(p.telefone) IS NULL THEN  '(-)'
        ELSE p.telefone
    END AS 'Endereço do paciente'
FROM MEDICO m    inner join PRONTUARIO pro 
on m.codigo =   pro.codigo_medico
inner join PACIENTES p
on p.cpf = pro.cpf_paciente
WHERE m.nome like '%Vinicius%'

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Quantos dias fazem da consulta de Maria Rita até hoje
select DATEDIFF(Day, paci.data, GETDATE()) as 'Quantos dias fazem da consulta'
from prontuario paci join pacientes p
on paci.cpf_paciente= p.cpf
where  p.nome like '%maria%'

