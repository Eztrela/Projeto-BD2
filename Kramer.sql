-- TABELAS
create table funcionario (
	id_funcionario 		serial 			not null,
	nome 				varchar(100)	not null,
	CPF 				char(14) 	not null,
	data_nascimento 	date 			not null,
	sexo 				char(1),
	email 				varchar(45) 	not null,
	
	
	gerente				integer 		not null
);

create table setor (
	id_setor 			serial 			not null
);

create table gerente (
	id_funcionario 		integer			not null,
	id_setor 			integer			not null
);

create table entregador (
	id_funcionario		integer 		not null,
	cnh					varchar(45)		not null,
	veiculo				varchar(45)		not null
);

create table cliente (
	id_cliente			serial			not null,
	nome				varchar(100)	not null,
	CPF					char(14)		not null,
	data_nascimento		date			not null,
	sexo				char(1)			not null,
	email				varchar(100)	not null,
	senha 				varchar(100)	not null,
	telefone			varchar(45)		not null
);

-- colocar pedido aqui

create table plano (
	id_plano 			integer			not null,
	tipo				varchar(45)		not null,
	preco				varchar(45)		not null
);

-- CONSTRAINTS
-- PK
alter table funcionario add constraint
pk_funcionario primary key(id_funcionario);

alter table setor add constraint
pk_setor primary key(id_setor);

alter table gerente add constraint
pk_gerente primary key(id_funcionario);

alter table entregador add constraint
pk_entregador primary key(id_funcionario);

alter table cliente add constraint
pk_cliente primary key(id_cliente);

alter table plano add constraint
pk_plano primary key(id_plano);


-- FK
alter table funcionario add constraint
fk_gerente foreign key(gerente) references gerente;

alter table gerente add constraint
fk_setor foreign key(id_setor) references setor;

alter table gerente add constraint
fk_funcionario_gerente foreign key(id_funcionario) references funcionario;

alter table entregador add constraint
fk_funcionario_entregador foreign key(id_funcionario) references funcionario;


-- Unique
alter table funcionario add constraint
Uni_CPF_funcionario unique(CPF);

alter table funcionario add constraint
Uni_email_funcionario unique(email);

alter table cliente add constraint
Uni_CPF_cliente unique(CPF);

alter table cliente add constraint
Uni_email_cliente unique(email);


-- drop table gerente cascade;
-- drop table setor cascade;
-- drop table funcionario cascade;
-- drop table entregador cascade;
-- drop table cliente cascade;
