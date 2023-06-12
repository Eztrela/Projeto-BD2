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
group by pl.tipo;