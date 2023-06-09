/* 
		Justificativa semântica:

Para garantir a consistência dos dados
é necessário haver um gerente para os setores.

Como a criação do setor antecede
a criação do funcionário,
os setores são criados com o gerente nulo.

Logo, faz sentido que o primeiro funcionário
daquele setor seja o gerente.
*/
create or replace function tornar_gerente()
returns trigger as $$
declare ger integer;
begin
	select gerente into ger from setor where id_setor = new.setor;
	
	if (ger is null) then
		update setor
		set gerente = new.id_funcionario
		where id_setor = new.setor;
	
	
    end if;
    return new;
end;
$$ language plpgsql;

create or replace trigger trigger_tornar_gerente
after insert on funcionario
for each row
execute function tornar_gerente();