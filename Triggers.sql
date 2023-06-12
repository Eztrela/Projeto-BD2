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
