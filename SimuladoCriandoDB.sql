CREATE DATABASE empresapm;
use empresapm;
CREATE TABLE EMPLOYEE
( Fname           VARCHAR(10)   NOT NULL,
  Minit           CHAR,
  Lname           VARCHAR(20)      NOT NULL,
  Ssn             CHAR(9)          NOT NULL,
  Bdate           DATE,
  Address         VARCHAR(30),
  Sex             CHAR(1),
  Salary          DECIMAL(5),
  Super_ssn       CHAR(9),
  Dno             INT               NOT NULL,
PRIMARY KEY   (Ssn));

CREATE TABLE DEPARTMENT
( Dname           VARCHAR(15)       NOT NULL,
  Dnumber         INT               NOT NULL,
  Mgr_ssn         CHAR(9)           NOT NULL,
  Mgr_start_date  DATE,
PRIMARY KEY (Dnumber),
UNIQUE      (Dname),
FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn) );

CREATE TABLE DEPT_LOCATIONS
( Dnumber         INT               NOT NULL,
  Dlocation       VARCHAR(15)       NOT NULL,
PRIMARY KEY (Dnumber, Dlocation),
FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber) );

CREATE TABLE PROJECT
( Pname           VARCHAR(15)       NOT NULL,
  Pnumber         INT               NOT NULL,
  Plocation       VARCHAR(15),
  Dnum            INT               NOT NULL,
PRIMARY KEY (Pnumber),
UNIQUE      (Pname),
FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber) );

CREATE TABLE WORKS_ON
( Essn            CHAR(9)           NOT NULL,
  Pno             INT               NOT NULL,
  Hours           DECIMAL(3,1)      NOT NULL,
PRIMARY KEY (Essn, Pno),
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber) );

CREATE TABLE DEPENDENT
( Essn            CHAR(9)           NOT NULL,
  Dependent_name  VARCHAR(15)       NOT NULL,
  Sex             CHAR,
  Bdate           DATE,
  Relationship    VARCHAR(8),
PRIMARY KEY (Essn, Dependent_name),
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn) );

INSERT INTO EMPLOYEE
VALUES      ('John','B','Smith',123456789,'1965-01-09','731 Fondren, Houston TX','M',30000,333445555,5),
            ('Franklin','T','Wong',333445555,'1965-12-08','638 Voss, Houston TX','M',40000,888665555,5),
            ('Alicia','J','Zelaya',999887777,'1968-01-19','3321 Castle, Spring TX','F',25000,987654321,4),
            ('Jennifer','S','Wallace',987654321,'1941-06-20','291 Berry, Bellaire TX','F',43000,888665555,4),
            ('Ramesh','K','Narayan',666884444,'1962-09-15','975 Fire Oak, Humble TX','M',38000,333445555,5),
            ('Joyce','A','English',453453453,'1972-07-31','5631 Rice, Houston TX','F',25000,333445555,5),
            ('Ahmad','V','Jabbar',987987987,'1969-03-29','980 Dallas, Houston TX','M',25000,987654321,4),
            ('James','E','Borg',888665555,'1937-11-10','450 Stone, Houston TX','M',55000,null,1);

INSERT INTO DEPARTMENT
VALUES      ('Research',5,333445555,'1988-05-22'),
            ('Administration',4,987654321,'1995-01-01'),
            ('Headquarters',1,888665555,'1981-06-19');

INSERT INTO PROJECT
VALUES      ('ProductX',1,'Bellaire',5),
            ('ProductY',2,'Sugarland',5),
            ('ProductZ',3,'Houston',5),
            ('Computerization',10,'Stafford',4),
            ('Reorganization',20,'Houston',1),
            ('Newbenefits',30,'Stafford',4);

INSERT INTO WORKS_ON
VALUES     (123456789,1,32.5),
           (123456789,2,7.5),
           (666884444,3,40.0),
           (453453453,1,20.0),
           (453453453,2,20.0),
           (333445555,2,10.0),
           (333445555,3,10.0),
           (333445555,10,10.0),
           (333445555,20,10.0),
           (999887777,30,30.0),
           (999887777,10,10.0),
           (987987987,10,35.0),
           (987987987,30,5.0),
           (987654321,30,20.0),
           (987654321,20,15.0),
           (888665555,20,16.0);

INSERT INTO DEPENDENT
VALUES      (333445555,'Alice','F','1986-04-04','Daughter'),
            (333445555,'Theodore','M','1983-10-25','Son'),
            (333445555,'Joy','F','1958-05-03','Spouse'),
            (987654321,'Abner','M','1942-02-28','Spouse'),
            (123456789,'Michael','M','1988-01-04','Son'),
            (123456789,'Alice','F','1988-12-30','Daughter'),
            (123456789,'Elizabeth','F','1967-05-05','Spouse');

INSERT INTO DEPT_LOCATIONS
VALUES      (1,'Houston'),
            (4,'Stafford'),
            (5,'Bellaire'),
            (5,'Sugarland'),
            (5,'Houston');

ALTER TABLE DEPARTMENT
 ADD CONSTRAINT Dep_emp FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);

ALTER TABLE EMPLOYEE
 ADD CONSTRAINT Emp_emp FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn);
ALTER TABLE EMPLOYEE
 ADD CONSTRAINT Emp_dno FOREIGN KEY  (Dno) REFERENCES DEPARTMENT(Dnumber);
ALTER TABLE EMPLOYEE
 ADD CONSTRAINT Emp_super FOREIGN KEY  (Super_ssn) REFERENCES EMPLOYEE(Ssn);
-- descobrindo o nome dos departamentos da empresa ->

describe department; -- para descobrir os campos da tabela department.
select * from department; -- analizando todas as informações presentes na tabela.
select Dname from department; -- procurando especificamente pelo nome dos departamentos.
-- DEPARTAMENTOS EXISTENTES: 'Administration', 'Headqarters' e 'Research'

-- descobrindo o numero de funcionarios do departamento 'Research'
describe employee; -- para descobrir os campos da tabela department e vendo que o funcionario tem um atributo 'Dno' referente ao numero do departamento
select Dnumber from department where Dname = 'Research'; -- descubro que o numero referente ao departamento 'Research' é 5
select * from employee where Dno = 5; -- procurando pelas informações dos funconarios com Dno 5, isto é, funcionarios do departamento 'Research'
-- ME RETORNA UM TOTAL DE 4 FUNCIONARIOS.

-- incluir novo departamento 'datascience' Dnumber = 7
select * from employee;		
insert into department values ('Datascience', 7, '123456789', '2024-04-09');
select * from department;
-- O NOVO DEPARTAMENTO 'datascience' FOI INCLUIDO	

-- Incluir pelo menos dois cientistas de dados no novo departamento com os atributos básicos
select * from employee;
insert into employee values ('Pedro', 'H', 'Melo', '999999999', '2004-11-25', '100 Conviver, Itapaje CE', 'M', 7200, '123456789', 7); -- Incluindo o primeiro cientista
insert into employee values ('Nelson', 'F', 'Araujo', '111111111', '2002-10-19', '123 RuaInss, Itapaje CE', 'M', 7200, '123456789', 7); -- Incluido o segundo cientista
update department set Mgr_ssn = '999999999' where Dname = 'Datascience'; -- o primeiro cientista criado foi colocado como gerente do departamento
update employee set Super_ssn = '999999999' where Dno = 7; -- modificado o ssn do superior para 
-- INCLUIDOS OS CIENTISTAS PEDRO E NELSON E OS ATRIBUTOS FORAM MODIFICADOS PARA UM SER O GERENTE O OS ATRIBUTOS RESPEITAREM A ORDEM

-- Aumentar o salário de todos os empregados em 23.5% do valor atual
select * from employee;
update employee set Salary = Salary * 1.235; -- reajusta os salarios aumentando em exatamente 23,5% de todos os funcionarios
-- O SALARIO DE TODOS OS FUNCIONARIOS FOI AUMENTADO

-- Mudar a endereço de residência ("Address") do departamento 4 ("Administration") para Itapajé, CE;
select * from employee;
update employee set Address = 'Itapaje, CE' where Dno = 4; -- altera o endereço de todos os funcionarios do departamento 4 para itapaje CE
-- TODOS OS FUNCIONARIOS DO DEPARTAMENTO 4 AGORA RESIDEM EM ITAPAJE CE