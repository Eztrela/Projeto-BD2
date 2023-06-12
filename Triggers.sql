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
    return null;

end;
$$ language plpgsql;

create or replace trigger trigger_tornar_gerente
after insert on funcionario
for each row
execute function tornar_gerente();


-- Inserção 1
INSERT INTO funcionario (id_funcionario, nome, CPF, data_nascimento, sexo, email, salario, setor)
VALUES (default, 'Ana Santos', '111.222.333-44', '1995-08-12', 'F', 'ana.santos@example.com', 2500.00, 3);

-- Inserção 2
INSERT INTO funcionario (id_funcionario, nome, CPF, data_nascimento, sexo, email, salario, setor)
VALUES (default, 'Pedro Oliveira', '444.555.666-77', '1998-03-25', 'M', 'pedro.oliveira@example.com', 3200.00, 2);

-- Inserção 3
INSERT INTO funcionario (id_funcionario, nome, CPF, data_nascimento, sexo, email, salario, setor)
VALUES (default, 'Mariana Costa', '888.999.000-11', '1993-12-05', 'F', 'mariana.costa@example.com', 2900.00, 3);

/* 
		Justificativa semântica:

Para que os dados se mantenham atualizados,
o trigger abaixo atualiza a media salarial do setor

Logo, faz sentido que o primeiro funcionário
daquele setor seja o gerente.
*/

create or replace function atualizar_media_salario()
returns trigger as $$
begin
    update setor
    set media_salarial = (
        select avg(salario)
        from funcionario
        where setor = new.setor
    )
    where id_setor = new.setor;
    return new;
end;
$$ language plpgsql;

create or replace trigger trigger_atualizar_media_salarial
after insert or delete or update on funcionario
for each row
execute procedure atualizar_media_salario();

insert into funcionario values (default,'Juan Farias','985.569.294-27','2002-02-20','M','juan@gmail.com',5000,3);
insert into funcionario values (default,'Enzo Leclerc','495.245.234-42','2005-09-17','M','enzo@gmail.com',2500,1);
insert into funcionario values (default,'Maria Raluca','210.810.134-94','1999-12-28','F','raluca@gmail.com',3500,2);

select nome, media_salarial from setor;

