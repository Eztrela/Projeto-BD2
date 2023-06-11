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
	sexo				char(1),
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
	id_plano 			serial			not null,
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
	id_roupa			serial        	not null,
	status				varchar(45)		not null,
	data_aquisicao		date			not null,
	marca        		varchar(45),
	tamanho				varchar(45)		not null,
	estado 				varchar(45)		not null,
	desc_roupa			varchar(45)		not null
);

create table categoria (
	id_categoria		serial			not null,
	desc_categ			varchar(45)		not null
);

create table cor (
	id_cor				serial			not null,
	desc_cor			varchar(45)		not null
);

create table material (
	id_material			serial			not null,
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
-- setor
alter table setor add constraint
pk_setor primary key(id_setor);

alter table setor add constraint
fk_gerente foreign key (gerente) references setor;

-- funcionario
alter table funcionario add constraint
pk_funcionario primary key(id_funcionario);

alter table funcionario add constraint
fk_setor foreign key (setor) references setor;

-- entregador
alter table entregador add constraint
pk_entregador primary key(id_funcionario);

alter table entregador add constraint
fk_funcionario_entregador foreign key(id_funcionario) references funcionario;

-- cliente
alter table cliente add constraint
pk_cliente primary key(id_cliente);

-- endereco_cliente
alter table endereco_cliente add constraint
pk_endereco_cliente primary key(id_endereco, id_cliente);

alter table endereco_cliente add constraint
fk_endereco_cliente foreign key(id_cliente) references cliente;

-- plano
alter table plano add constraint
pk_plano primary key(id_plano);

-- pedido
alter table pedido add constraint
pk_pedido primary key (id_pedido);

alter table pedido add constraint
fk_pedido_cliente foreign key (id_cliente) references cliente;

alter table pedido add constraint
fk_pedido_entregador foreign key (id_entregador) references entregador;

-- roupa
alter table roupa add constraint
pk_roupa primary key(id_roupa);


-- categoria
alter table categoria add constraint
pk_categoria primary key(id_categoria);

-- cor
alter table cor add constraint
pk_cor primary key(id_cor);

-- material
alter table material add constraint
pk_material primary key(id_material);

-- roupa_categ
alter table roupa_categ add constraint
fk_roupa_categ foreign key(id_roupa) references roupa;

alter table roupa_categ add constraint
fk_categoria foreign key(id_categ) references categoria;

alter table roupa_categ add constraint
pk_roupa_categ primary key (id_roupa,id_categ);

-- roupa_cor
alter table roupa_cor add constraint
fk_roupa_cor foreign key(id_roupa) references roupa;

alter table roupa_cor add constraint
pk_roupa_cor primary key (id_roupa,id_cor);

alter table roupa_cor add constraint
fk_cor foreign key(id_cor) references cor;

-- roupa_mat
alter table roupa_mat add constraint
fk_roupa_mat foreign key(id_roupa) references roupa;

alter table roupa_mat add constraint
fk_material foreign key(id_mat) references material;

alter table roupa_mat add constraint
pk_roupa_mat primary key (id_roupa,id_mat);

-- pedidos_roupa
alter table pedidos_roupa add constraint
fk_pedidos_roupa_pedido foreign key (id_pedido) references pedido;

alter table pedidos_roupa add constraint
fk_pedidos_roupa_cliente foreign key (id_cliente) references cliente;

alter table pedidos_roupa add constraint
fk_pedidos_roupa_roupa foreign key (id_roupa) references roupa;

alter table pedidos_roupa add constraint
pk_pedidos_roupa primary key (id_pedido,id_cliente,id_roupa);

-- assina
alter table assina add constraint
fk_assina_plano foreign key (id_plano) references plano;

alter table assina add constraint
fk_assina_cliente foreign key (id_cliente) references cliente;

alter table assina add constraint
pk_assina primary key (id_cliente,id_plano,data_inicio);




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
insert into funcionario values (default,'João Silva', '123.456.789-00', '1990-01-01', 'M', 'joao.silva@example.com', '5000.00', 1);     -- Funcionário 1: João Silva, CPF 123.456.789-00, data de nascimento 1990-01-01, sexo masculino, e-mail joao.silva@example.com, salário 5000.00, setor 1
insert into funcionario values (default,'Maria Oliveira', '987.654.321-00', '1995-05-10', 'F', 'maria.oliveira@example.com', '4500.00', 2);  -- Funcionário 2: Maria Oliveira, CPF 987.654.321-00, data de nascimento 1995-05-10, sexo feminino, e-mail maria.oliveira@example.com, salário 4500.00, setor 2
insert into funcionario values (default,'Pedro Santos', '456.789.123-00', '1988-07-20', 'M', 'pedro.santos@example.com', '5500.00', 1);      -- Funcionário 3: Pedro Santos, CPF 456.789.123-00, data de nascimento 1988-07-20, sexo masculino, e-mail pedro.santos@example.com, salário 5500.00, setor 1

-- primeiro funcionario a ser inserido dispara um trigger para torna-lo gerente do setor ao qual foi adicionado

-- Gerente

insert into funcionario values (default,'Juan Farias','985.569.294-27','2002-02-20','M','juan@gmail.com','5000',3);
insert into funcionario values (default,'Enzo Leclerc','495.245.234-42','2005-09-17','M','enzo@gmail.com','2500',1);
insert into funcionario values (default,'Maria raluca','210.810.134-94','1999-12-28','F','raluca@gmail.com','3500',2);

-- Entregador
insert into entregador values (5, '5229783620-1', 'Honda bros');
insert into entregador values (1, '123456789', 'Carro');   -- Entregador 1: Funcionário 1, CNH 123456789, Veículo Carro
insert into entregador values (2, '987654321', 'Moto');    -- Entregador 2: Funcionário 2, CNH 987654321, Veículo Moto
insert into entregador values (3,  '456789123', 'Bicicleta');  -- Entregador 3: Funcionário 3, CNH 456789123, Veículo Bicicleta

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
insert into roupa values(default, 'Disponível', '2022-01-15', 'Nike', 'M', 'Novo','Camisa');
insert into roupa values(default, 'Disponível', '2022-03-20', 'Adidas', 'S', 'Novo','Short');
insert into roupa values(default, 'Indisponível', '2022-02-10', 'Puma', 'L', 'Usado','Meia');
insert into roupa values(default, 'Disponível', '2022-05-05', 'Reebok', 'XL', 'Novo','Camisa');
insert into roupa values(default, 'Indisponível', '2022-04-01', 'Under Armour', 'M', 'Usado','Leg');
insert into roupa values(default, 'Disponível', '2022-06-12', 'Chico Rei', 'S', 'Novo','Moleton');
insert into roupa values(default, 'Indisponível', '2022-07-25', 'Vans', 'L', 'Novo','Camisa');
insert into roupa values(default, 'Disponível', '2022-08-18', 'Zara', 'M', 'Semi-novo','Vestido');
insert into roupa values(default, 'Disponível', '2022-09-30', 'Fila', 'XL', 'Semi-novo','Saia');
insert into roupa values(default, 'Disponível', '2022-11-08', 'Asics', 'S', 'Novo','Bermuda');

-- Plano
insert into plano values (default,'Plano Casual', 'R$ 19,99');
insert into plano values (default,'Plano Workaholic', 'R$ 29,99');
insert into plano values (default,'Plano Party', 'R$ 49,99');
insert into plano values (default,'Plano Custom', 'R$ 39,99');
insert into plano values (default,'Plano Business', 'R$ 79,99');

--Endereço

-- Inserir endereço para o cliente João Silva
INSERT INTO endereco_cliente (id_cliente, rua, numero, cidade, estado, bairro, CEP)
VALUES (1, 'Rua A', '123', 'São Paulo', 'SP', 'Centro', '01234-567');

-- Inserir endereço para a cliente Maria Oliveira
INSERT INTO endereco_cliente (id_cliente, rua, numero, cidade, estado, bairro, CEP)
VALUES (2, 'Rua B', '456', 'Rio de Janeiro', 'RJ', 'Copacabana', '98765-432');

-- Inserir endereço para o cliente Pedro Santos
INSERT INTO endereco_cliente (id_cliente, rua, numero, cidade, estado, bairro, CEP)
VALUES (3, 'Rua C', '789', 'Belo Horizonte', 'MG', 'Savassi', '54321-876');

-- Inserir endereço para a cliente Ana Souza
INSERT INTO endereco_cliente (id_cliente, rua, numero, cidade, estado, bairro, CEP)
VALUES (4, 'Rua D', '321', 'Curitiba', 'PR', 'Batel', '45678-901');

-- Inserir endereço para o cliente Carlos Ferreira
INSERT INTO endereco_cliente (id_cliente, rua, numero, cidade, estado, bairro, CEP)
VALUES (5, 'Rua E', '654', 'Porto Alegre', 'RS', 'Moinhos de Vento', '78901-234');

-- Roupa_categ
insert into roupa_categ values (1, 2);  -- Roupas do cliente João Silva são da categoria "Roupas"
insert into roupa_categ values (2, 2);  -- Roupas da cliente Maria Oliveira são da categoria "Roupas"
insert into roupa_categ values (3, 1);  -- Roupas do cliente Pedro Santos são da categoria "Eletrônicos"
insert into roupa_categ values (4, 3);  -- Roupas do cliente Ana Souza são da categoria "Acessórios"
insert into roupa_categ values (5, 2);  -- Roupas do cliente Carlos Ferreira são da categoria "Roupas"

-- Roupa_cor
insert into roupa_cor values (1, 1);  -- Roupas do cliente João Silva são da cor "Azul"
insert into roupa_cor values (2, 2);  -- Roupas da cliente Maria Oliveira são da cor "Vermelho"
insert into roupa_cor values (3, 3);  -- Roupas do cliente Pedro Santos são da cor "Verde"
insert into roupa_cor values (4, 4);  -- Roupas do cliente Ana Souza são da cor "Amarelo"
insert into roupa_cor values (5, 5);  -- Roupas do cliente Carlos Ferreira são da cor "Preto"

-- Roupa_mat
insert into roupa_mat values (1, 1);  -- Roupas do cliente João Silva são feitas de "Algodão"
insert into roupa_mat values (2, 2);  -- Roupas da cliente Maria Oliveira são feitas de "Couro"
insert into roupa_mat values (3, 3);  -- Roupas do cliente Pedro Santos são feitas de "Plástico"
insert into roupa_mat values (4, 4);  -- Roupas do cliente Ana Souza são feitas de "Metal"
insert into roupa_mat values (5, 5);  -- Roupas do cliente Carlos Ferreira são feitas de "Madeira"

-- Assina
insert into assina values(1, 1, '2022-01-01', '1 semanas');   -- Cliente João Silva assina o Plano Básico
insert into assina values(2, 2, '2022-02-15', '2 semanas');   -- Cliente Maria Oliveira assina o Plano Padrão
insert into assina values(3, 3, '2022-03-10', '4 semanas');   -- Cliente Pedro Santos assina o Plano Premium
insert into assina values(4, 4, '2022-04-20', '2 semanas');   -- Cliente Ana Souza assina o Plano Família
insert into assina values(5, 5, '2022-05-05', '4 semanas');   -- Cliente Carlos Ferreira assina o Plano Empresarial

-- Pedido
insert into pedido values (default,'Pendente', '2022-01-10', 'RA123456', 1, 1);    -- Pedido 1: Pendente, cliente João Silva, entregador 1
insert into pedido values (default,'Em trânsito', '2022-02-15', 'RA234567', 2, 2); -- Pedido 2: Em trânsito, cliente Maria Oliveira, entregador 2
insert into pedido values (default,'Entregue', '2022-03-20', 'RA345678', 3, 1);    -- Pedido 3: Entregue, cliente Pedro Santos, entregador 1
insert into pedido values (default,'Pendente', '2022-04-25', 'RA456789', 4, 3);    -- Pedido 4: Pendente, cliente Ana Souza, entregador 3
insert into pedido values (default,'Em trânsito', '2022-05-30', 'RA567890', 5, 2); -- Pedido 5: Em trânsito, cliente Carlos Ferreira, entregador 2
insert into pedido values (default,'Entregue', '2022-06-10', 'RA678901', 1, 3);    -- Pedido 6: Entregue, cliente João Silva, entregador 3
insert into pedido values (default,'Pendente', '2022-07-15', 'RA789012', 2, 1);    -- Pedido 7: Pendente, cliente Maria Oliveira, entregador 1
insert into pedido values (default,'Em trânsito', '2022-08-20', 'RA890123', 3, 2); -- Pedido 8: Em trânsito, cliente Pedro Santos, entregador 2
insert into pedido values (default,'Entregue', '2022-09-25', 'RA901234', 4, 3);    -- Pedido 9: Entregue, cliente Ana Souza, entregador 3
insert into pedido values (default,'Pendente', '2022-10-30', 'RA012345', 5, 1);    -- Pedido 10: Pendente, cliente Carlos Ferreira, entregador 1

-- Pedidos_Roupa
insert into pedidos_roupa values (1, 1, 1);    -- Pedido 1: Cliente João Silva comprou a roupa 1
insert into pedidos_roupa values (1, 1, 2);    -- Pedido 1: Cliente João Silva comprou a roupa 2
insert into pedidos_roupa values (2, 2, 3);    -- Pedido 2: Cliente Maria Oliveira comprou a roupa 3
insert into pedidos_roupa values (2, 2, 4);    -- Pedido 2: Cliente Maria Oliveira comprou a roupa 4
insert into pedidos_roupa values (3, 3, 5);    -- Pedido 3: Cliente Pedro Santos comprou a roupa 5
insert into pedidos_roupa values (3, 3, 1);    -- Pedido 3: Cliente Pedro Santos comprou a roupa 1
insert into pedidos_roupa values (4, 4, 2);    -- Pedido 4: Cliente Ana Souza comprou a roupa 2
insert into pedidos_roupa values (4, 4, 3);    -- Pedido 4: Cliente Ana Souza comprou a roupa 3
insert into pedidos_roupa values (5, 5, 4);    -- Pedido 5: Cliente Carlos Ferreira comprou a roupa 4
insert into pedidos_roupa values (5, 5, 5);    -- Pedido 5: Cliente Carlos Ferreira comprou a roupa 5
insert into pedidos_roupa values (6, 1, 3);    -- Pedido 6: Cliente João Silva comprou a roupa 3
insert into pedidos_roupa values (7, 2, 4);    -- Pedido 7: Cliente Maria Oliveira comprou a roupa 4
insert into pedidos_roupa values (7, 2, 5);    -- Pedido 7: Cliente Maria Oliveira comprou a roupa 5
insert into pedidos_roupa values (8, 3, 1);    -- Pedido 8: Cliente Pedro Santos comprou a roupa 1
insert into pedidos_roupa values (9, 4, 2);    -- Pedido 9: Cliente Ana Souza comprou a roupa 2
insert into pedidos_roupa values (9, 4, 3);    -- Pedido 9: Cliente Ana Souza comprou a roupa 3
insert into pedidos_roupa values (10, 5, 4);   -- Pedido 10: Cliente Carlos Ferreira comprou a roupa 4
insert into pedidos_roupa values (10, 5, 5);   -- Pedido 10: Cliente Carlos Ferreira comprou a roupa 5


-- CONSULTAS

-- Básicas
select * from setor;
select * from funcionario;
select * from entregador;
select * from cliente;
select * from categoria;
select * from cor;
select * from material;
select * from roupa;


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
-- drop table roupa_categ cascade;
-- drop table roupa_mat cascade;
-- drop table roupa_cor cascade;
