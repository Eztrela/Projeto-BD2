/* 

Podemos usar WITH para alocar
a subconsulta interna antes realizada como: 

select pl.tipo, count(*) as "Clientes" from plano pl 
where pl.id_plano in (
  SELECT a.id_plano from assina a
  where a.id_cliente in (
    select c.id_cliente from cliente c))
 group by pl.tipo;

assim, podemos melhorar a 
leitura da consulta
*/
with cliente_assina as (
  select id_plano
  from assina
  where id_cliente in (
    select id_cliente
    from cliente
  )
)


select pl.tipo, count(*) as "Clientes"
from plano pl
join cliente_assina ca on pl.id_plano = ca.id_plano
/*
Podemos reescrever
nossa consula de subqueries
usando joins,
o código original está abaixo:

select pl.tipo, count(*) as "Clientes" from plano pl 
where pl.id_plano in (
  SELECT a.id_plano from assina a
  where a.id_cliente in (
    select c.id_cliente from cliente c))
 group by pl.tipo;

podemos reescrevê-lo da seguinte forma
*/

select pl.tipo, count(*) as "Clientes"
from plano pl
join assina a on a.id_plano = pl.id_plano
join cliente c on c.id_cliente = a.id_cliente

group by pl.tipo;