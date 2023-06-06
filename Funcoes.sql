-- Funções
create or replace function mediaSalario()
returns float
as $$
declare media float;

begin
	select round(avg(salario), 2) into media from funcionario;
	return media;
	
end; $$ language plpgsql;

select mediaSalario();


-- create or replace function pedidoMaisRecente()
-- returns date
-- as $$
-- declare data date;

-- begin
-- 	select max(data_pedido) into data from pedido;
-- 	return data;
	
-- end; $$ language plpgsql;

-- select pedidoMaisRecente()

