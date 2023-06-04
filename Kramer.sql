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

create table endereco_cliente (
	id_endereco		    serial          not null,
	id_cliente			integer			not null,
	rua 				varchar(100)    not null,
	numero				varchar(10)     not null,
	cidade				varchar(45)     not null,
	estado 				varchar(45)		not null,
	bairro				varchar(45) 	not null,
	CEP                 varchar(20)     not null
);

-- colocar pedido aqui

create table plano (
	id_plano 			integer			not null,
	tipo				varchar(45)		not null,
	preco				varchar(45)		not null
);

create table roupa (
	id_roupa			integer        	not null,
	status				varchar(45)		not null,
	data_aquisicao		date			not null,
	marca        		varchar(45),
	tamanho				varchar(45)		not null,
	estado 				varchar(45)		not null
);

create table categoria (
	id_categoria		integer			not null,
	id_roupa            integer			not null
);

create table cor (
	id_cor				integer			not null,
	id_roupa            integer			not null
);

create table material (
	id_material			integer			not null,
	id_roupa            integer			not null
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

alter table endereco_cliente add constraint
pk_endereco_cliente primary key(id_endereco, id_cliente);

alter table plano add constraint
pk_plano primary key(id_plano);

alter table roupa add constraint
pk_roupa primary key(id_roupa);

alter table categoria add constraint
pk_categoria primary key(id_categoria, id_roupa);

alter table cor add constraint
pk_cor primary key(id_cor, id_roupa);

alter table material add constraint
pk_material primary key(id_material, id_roupa);


-- FK
alter table funcionario add constraint
fk_gerente foreign key(gerente) references gerente;

alter table gerente add constraint
fk_setor foreign key(id_setor) references setor;

alter table gerente add constraint
fk_funcionario_gerente foreign key(id_funcionario) references funcionario;

alter table entregador add constraint
fk_funcionario_entregador foreign key(id_funcionario) references funcionario;

alter table endereco_cliente add constraint
fk_endereco_cliente foreign key(id_cliente) references cliente;

alter table categoria add constraint
fk_categoria_roupa foreign key(id_roupa) references roupa;

alter table cor add constraint
fk_cor_roupa foreign key(id_roupa) references roupa;

alter table material add constraint
fk_material_roupa foreign key(id_roupa) references roupa;

-- Unique
alter table funcionario add constraint
Uni_CPF_funcionario unique(CPF);

alter table funcionario add constraint
Uni_email_funcionario unique(email);

alter table cliente add constraint
Uni_CPF_cliente unique(CPF);

alter table cliente add constraint
Uni_email_cliente unique(email);


--drop table gerente cascade;
--drop table setor cascade;
--drop table funcionario cascade;
--drop table entregador cascade;
--drop table cliente cascade;
--drop table plano cascade;
