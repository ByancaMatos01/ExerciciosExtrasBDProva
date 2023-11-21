Create database execicio1
use execicio1

create table ALUNO(
ra INT  UNIQUE,
nome VARCHAR (60)  CHECK(LEN(nome) >= 3),
sobrenome VARCHAR(60)  CHECK(LEN(sobrenome) >= 3),
rua VARCHAR(255),
numero int,
bairro varchar(255),
cep char(7) CHECK(LEN(cep) = 7) ,
telefone char(08)
primary key (ra)
)

create table CURSO(
codigo int identity(1,1),
nome varchar(60) CHECK(LEN(nome) >= 3),
carga_horaria int,
tuno varchar(60) ,
primary key (codigo)
)

create table DICIPLINA (
codigo int identity(1,1),
nome varchar(60) CHECK(LEN(nome) >= 3),
carga_horaria int,
tuno varchar(60) ,
semestre int,
primary key (codigo)
)

INSERT INTO ALUNO (ra,nome,sobrenome,rua,numero,bairro,cep,telefone) 
VALUES (12345,'José', 'Silva','Almirante Noronha',236,'Jardim São Paulo','1589000', '69875287')

INSERT INTO ALUNO (ra,nome,sobrenome,rua,numero,bairro,cep,telefone) 
VALUES (12346,'Ana', 'Maria Bastos','Anhaia',1568,'Barra Funda','3569000', '25698526')

INSERT INTO ALUNO (ra,nome,sobrenome,rua,numero,bairro,cep) 
VALUES (12347,'Mario', 'Santos','XV de Novembro',1841,'Centro','1020030')

INSERT INTO ALUNO (ra,nome,sobrenome,rua,numero,bairro,cep,telefone) 
VALUES (12348,'Marcia', 'Neves','Voluntários da Patria',225,'Santana','2785090', '78964152')


INSERT INTO CURSO(nome,carga_horaria,tuno) 
VALUES ('Informatica', 2800,'Tarde')

INSERT INTO CURSO(nome,carga_horaria,tuno) 
VALUES ('Informatica', 2800,'Noite')


INSERT INTO CURSO(nome,carga_horaria,tuno) 
VALUES ('Logistica', 2650,'Tarde')

INSERT INTO CURSO(nome,carga_horaria,tuno) 
VALUES ('Logistica', 2650,'Noite')

INSERT INTO CURSO(nome,carga_horaria,tuno) 
VALUES ('Plastico', 2500,'Tarde')

INSERT INTO CURSO(nome,carga_horaria,tuno) 
VALUES ('Plastico', 2500,'Noite')


INSERT INTO DICIPLINA(nome,carga_horaria,tuno, semestre) 
VALUES ('Informatica', 4,'tarde', 1)

INSERT INTO DICIPLINA(nome,carga_horaria,tuno, semestre) 
VALUES ('Informatica', 4,'noite', 1)

INSERT INTO DICIPLINA(nome,carga_horaria,tuno, semestre) 
VALUES ('Quimica', 4,'tarde', 1)

INSERT INTO DICIPLINA(nome,carga_horaria,tuno, semestre) 
VALUES ('Quimica', 4,'noite', 1)

INSERT INTO DICIPLINA(nome,carga_horaria,tuno, semestre) 
VALUES ('Banco de Dados I', 2,'tarde', 3)

INSERT INTO DICIPLINA(nome,carga_horaria,tuno, semestre) 
VALUES ('Banco de Dados I', 2,'noite', 3)

INSERT INTO DICIPLINA(nome,carga_horaria,tuno, semestre) 
VALUES ('Estrutura de Dados', 4,'tarde', 4)

INSERT INTO DICIPLINA(nome,carga_horaria,tuno, semestre) 
VALUES ('Estrutura de Dados', 4,'noite', 4)




drop table aluno


select* from ALUNO
select* from DICIPLINA

select*from CURSO
drop table CURSO

select nome+' '+sobrenome as alunosMatriculados
from ALUNO

select nome +' '+ sobrenome + ' '+rua+' '+ CAST(numero AS VARCHAR(10))+' '+ ''+ bairro +' '+cep as alunosemTelefone
from ALUNO
where telefone is null


select telefone 
from ALUNO
where RA=12348

select nome+ ' '+ tuno as CursosHoras
from CURSO
where carga_horaria=2800

select semestre
from DICIPLINA
where nome  LIKE '% de dados %' 