-- 2 - Criação e uso de objetos bãsicoscliente
-- a. II

-- Consulta com is null
select nome from cliente where sexo is null;

-- 3 Consultas com inner join
select distinct(f.nome), count(*) as "Numero de Pedidos"  from pedido p 
join entregador e
on p.id_entregador = e.id_funcionario
join funcionario f 
on f.id_funcionario = e.id_funcionario
group by f.nome;

select c.desc_categ, count(*)
from categoria c
join roupa_categ rc 
on rc.id_categ = c.id_categoria
join roupa r 
on r.id_roupa = rc.id_roupa
group by c.desc_categ;

select m.desc_mat, count(*)
from material m
join roupa_mat rm
on rm.id_mat = m.id_material
join roupa r 
on r.id_roupa = rm.id_roupa
group by m.desc_mat;

-- Left join
select c.desc_cor, count(rc.id_cor)
from cor c
left join roupa_cor rc
on rc.id_cor = c.id_cor
group by c.desc_cor;

-- Group by
select tamanho, count(*) as "quantidade" from roupa GROUP by tamanho;

SELECT ec.estado, COUNT(*) AS count_clientes
FROM endereco_cliente ec
JOIN cliente c ON ec.id_cliente = c.id_cliente
GROUP BY ec.estado;

-- Union
SELECT id_cliente, nome, CPF, data_nascimento, email
FROM cliente
UNION
SELECT id_funcionario, nome, CPF, data_nascimento, email
FROM funcionario;
FROM funcionario;

-- Subqueries 
select f.nome as "Entregadores" from funcionario f 
where f.id_funcionario in (select e.id_funcionario from entregador e);

select pl.tipo, count(*) as "Clientes" from plano pl 
where pl.id_plano in (
  SELECT a.id_plano from assina a
  where a.id_cliente in (
    select c.id_cliente from cliente c))
 group by pl.tipo;
 
 -- View que permite inserção
 create or replace view roupasoriginal
 as select id_roupa, status, data_aquisicao, tamanho, estado, desc_roupa 
     from roupa where marca is null;
 
 --select * from roupasoriginal
 --insert into roupasoriginal values (DEFAULT, 'Disponível', '2020-01-20', 'XL', 'Semi-novo', 'Bermuda');

-- Views robustas 
create or replace view qtndPedidosPorPlano
as select pl.tipo, count(p.id_pedido) as "Pedidos" FROM plano pl 
join assina a 
on a.id_plano = pl.id_plano
join cliente c 
on c.id_cliente = a.id_cliente
join pedido p 
on p.id_cliente = c.id_cliente
group by pl.tipo;

select * from qtndPedidosPorPlano;

create or replace view numMaterialEmPedidos
as select m.desc_mat, count(r.id_roupa) as "Numero de Pedidos"
from material m
join roupa_mat rm
on rm.id_mat = m.id_material
join roupa r 
on r.id_roupa = rm.id_roupa
join pedidos_roupa pr
on pr.id_roupa = r.id_roupa
GROUP by m.desc_mat;

select * from numMaterialEmPedidos;



