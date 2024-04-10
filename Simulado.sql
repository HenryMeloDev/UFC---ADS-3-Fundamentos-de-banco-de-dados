use empresapm;
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