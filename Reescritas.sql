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