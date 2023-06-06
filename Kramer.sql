-- TABELAS
create table funcionario (
	id_funcionario 		serial 			not null,
	nome 				varchar(100)	not null,
	CPF 				char(14) 	not null,
	data_nascimento 	date 			not null,
	sexo 				char(1),
	email 				varchar(45) 	not null,
	salario				varchar(45)		not null,
	setor				integer			not null
);

create table setor (
	id_setor 			serial 			not null,
	nome				varchar(45)		not null,
	gerente				integer			null
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

create table pedido (
	id_pedido			serial			not null,
	status				varchar(45)		not null,
	data_pedido			date			not null,
	rastreio			varchar(45)		not null,
	
	id_cliente			integer			not null,
	id_entregador		integer			not null
);

create table plano (
	id_plano 			integer			not null,
	tipo				varchar(45)		not null,
	preco				varchar(45)		not null
);

create table assina (
	id_cliente			integer			not null,
	id_plano			integer			not null,
	data_inicio			date			not null,
	duracao				varchar(45)		not null
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
	desc_categ			varchar(45)		not null
);

create table cor (
	id_cor				integer			not null,
	desc_cor			varchar(45)		not null
);

create table material (
	id_material			integer			not null,
	desc_mat			varchar(45)		not null
);

create table pedidos_roupa (
	id_pedido			integer			not null,
	id_cliente			integer			not null,
	id_roupa			integer			not null
);

create table roupa_categ (
	id_roupa			integer			not null,
	id_categ			integer			not null
);

create table roupa_cor (
	id_roupa			integer			not null,
	id_cor				integer			not null
);

create table roupa_mat (
	id_roupa			integer			not null,
	id_mat				integer			not null
);

-- CONSTRAINTS
-- PK
alter table funcionario add constraint
pk_funcionario primary key(id_funcionario);

alter table setor add constraint
pk_setor primary key(id_setor);

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
pk_categoria primary key(id_categoria);

alter table cor add constraint
pk_cor primary key(id_cor);

alter table material add constraint
pk_material primary key(id_material);

alter table roupa_categ add constraint
pk_roupa_categ primary key (id_roupa,id_categ);

alter table roupa_cor add constraint
pk_roupa_cor primary key (id_roupa,id_cor);

alter table roupa_mat add constraint
pk_roupa_mat primary key (id_roupa,id_mat);

alter table pedidos_roupa add constraint
pk_pedidos_roupa primary key (id_pedido,id_cliente,id_roupa);

alter table assina add constraint
pk_assina primary key (id_cliente,id_plano,data_inicio);

alter table pedido add constraint
pk_pedido primary key (id_pedido);

-- FK
alter table funcionario add constraint
fk_setor foreign key (setor) references setor;

alter table setor add constraint
fk_gerente foreign key (gerente) references setor;

alter table entregador add constraint
fk_funcionario_entregador foreign key(id_funcionario) references funcionario;

alter table endereco_cliente add constraint
fk_endereco_cliente foreign key(id_cliente) references cliente;

alter table roupa_categ add constraint
fk_roupa_categ foreign key(id_roupa) references roupa;

alter table roupa_cor add constraint
fk_roupa_cor foreign key(id_roupa) references roupa;

alter table roupa_mat add constraint
fk_roupa_mat foreign key(id_roupa) references roupa;

alter table roupa_categ add constraint
fk_categoria foreign key(id_categ) references categoria;

alter table roupa_cor add constraint
fk_cor foreign key(id_cor) references cor;

alter table roupa_mat add constraint
fk_material foreign key(id_mat) references material;

alter table pedidos_roupa add constraint
fk_pedidos_roupa_pedido foreign key (id_pedido) references pedido;

alter table pedidos_roupa add constraint
fk_pedidos_roupa_cliente foreign key (id_cliente) references cliente;

alter table pedidos_roupa add constraint
fk_pedidos_roupa_roupa foreign key (id_roupa) references roupa;

alter table assina add constraint
fk_assina_plano foreign key (id_plano) references plano;

alter table assina add constraint
fk_assina_cliente foreign key (id_cliente) references cliente;

alter table pedido add constraint
fk_pedido_cliente foreign key (id_cliente) references cliente;

alter table pedido add constraint
fk_pedido_entregador foreign key (id_entregador) references entregador;

-- fk id cliente para entrega

-- Unique
alter table funcionario add constraint
Uni_CPF_funcionario unique(CPF);

alter table funcionario add constraint
Uni_email_funcionario unique(email);

alter table cliente add constraint
Uni_CPF_cliente unique(CPF);

alter table cliente add constraint
Uni_email_cliente unique(email);


-- INSERÇÕES

-- Setor
insert into setor values(default, 'Entregas',null);
insert into setor values(default, 'Empacotamento',null);
insert into setor values(default, 'Suporte',null);

-- Funcionário
insert into funcionario values (default,'Alecsander Cruz','110.917.434-95','1993-07-29','M','alecsander@gmail.com','15000',1);
insert into funcionario values (default,'Bruno Rodrigues','375.667.084-81','1994-04-23','M','charles@gmail.com','10000',3);
insert into funcionario values (default,'Charles Jhansen','535.794.894-10','1990-11-13','M','bruno@gmail.com','12000',2);

-- primeiro funcionario a ser inserido dispara um trigger para torna-lo gerente do setor ao qual foi adicionado

-- Gerente

insert into funcionario values (default,'Juan Farias','985.569.294-27','2002-02-20','M','juan@gmail.com','5000',3);
insert into funcionario values (default,'Enzo Leclerc','495.245.234-42','2005-09-17','M','enzo@gmail.com','2500',1);
insert into funcionario values (default,'Maria raluca','210.810.134-94','1999-12-28','F','raluca@gmail.com','3500',2);

-- Entregador
insert into entregador values (5, '5229783620-1', 'Honda bros');

-- Cliente
insert into cliente values (default, 'Ana Souza', '789.123.456-00', '2000-03-20', 'F', 'ana.souza@example.com', 'senhaabc', '(41) 55555-5555');
insert into cliente values (default, 'Carlos Ferreira', '321.654.987-00', '1978-11-30', 'M', 'carlos.ferreira@example.com', 'senhaxyz', '(51) 77777-7777');
insert into cliente values (default, 'Pedro Santos', '456.789.123-00', '1985-09-15', 'M', 'pedro.santos@example.com', 'senha789', '(31) 12345-6789');
insert into cliente values (default, 'Maria Oliveira', '987.654.321-00', '1995-05-10', 'F', 'maria.oliveira@example.com', 'senha456', '(21) 99999-9999');
insert into cliente values (default, 'João Silva', '123.456.789-00', '1990-01-01', 'M', 'joao.silva@example.com', 'senha123', '(11) 98765-4321');

-- Categoria
insert into categoria values (default, 'Eletrônicos');
insert into categoria values (default, 'Roupas');
insert into categoria values (default, 'Acessórios');
insert into categoria values (default, 'Livros');
insert into categoria values (default, 'Cosméticos');

-- Cor
insert into cor values (default, 'Azul');
insert into cor values (default, 'Vermelho');
insert into cor values (default, 'Verde');
insert into cor values (default, 'Amarelo');
insert into cor values (default, 'Preto');

-- Material
insert into material values(default, 'Algodão');
insert into material values(default, 'Couro');
insert into material values(default, 'Plástico');
insert into material values(default, 'Metal');
insert into material values(default, 'Madeira');

-- Roupa


-- CONSULTAS

-- Básicas

select * from setor;
select * from funcionario;
select * from entregador;



-- drop table setor cascade;
-- drop table funcionario cascade;
-- drop table entregador cascade;
-- drop table cliente cascade;
-- drop table plano cascade;
-- drop table pedido cascade;
-- drop table assina cascade;
-- drop table pedidos_roupa cascade;
-- drop table categoria cascade;
-- drop table cor cascade;
-- drop table material cascade;
-- drop table roupa cascade;
-- drop table endereco_cliente cascade;