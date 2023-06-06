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
