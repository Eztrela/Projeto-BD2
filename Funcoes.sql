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

create or replace procedure inserir_roupa_cor_categ_mat(
    i_status varchar(45),
    i_data_aquisicao date,
    i_marca varchar(45),
    i_tamanho varchar(45),
    i_estado varchar(45),
    i_desc_roupa varchar(45),
    i_desc_cor varchar(45),
    i_desc_mat varchar(45),
    i_desc_categ varchar(45)) 
as $$
declare
    check_id_roupa integer;
    check_id_cor integer;
    check_id_mat integer;
    check_id_categ integer;
begin
    -- Inserir a roupa
    insert into roupa values (default, i_status, i_data_aquisicao, i_marca, i_tamanho, i_estado, i_desc_roupa)
	returning id_roupa into check_id_roupa;

    -- Verificar se a cor já existe na tabela cor
    select id_cor into check_id_cor from cor where desc_cor = i_desc_cor;
    if check_id_cor is NULL then
        -- Inserir a cor
        insert into cor values (default, i_desc_cor)
		returning id_cor into check_id_cor;
    end if;

    -- Verificar se o material já existe na tabela material
    select id_material into check_id_mat from material where desc_mat = i_desc_mat;
    if check_id_mat is NULL then
        -- Inserir o material
        insert into material values (default, i_desc_mat)
		returning id_mat into check_id_mat;
    end if;

    -- Verificar se a categoria já existe na tabela categoria
    select id_categoria into check_id_categ from categoria where desc_categ = i_desc_categ;
    if check_id_categ is NULL then
        -- Inserir a categoria
        insert into categoria values (default, i_desc_categ)
		returning id_categoria into check_id_categ;
    end if;
	
    -- Inserir a relação entre a roupa e a cor
    insert into roupa_cor values (check_id_roupa, check_id_cor);

    -- Inserir a relação entre a roupa e o material
    insert into roupa_mat values (check_id_roupa, check_id_mat);

    -- Inserir a relação entre a roupa e a categoria
    insert into roupa_categ values (check_id_roupa, check_id_categ);
    
    raise notice 'Roupa inserida com sucesso! ID da roupa: %', check_id_roupa;
end;
$$ language plpgsql;

call inserir_roupa_cor_categ_mat('Disponivel', '2019-12-29', 'Kings', 'G', 'Novo', 'Camisa', 'Branco', 'Algodão', 'Casual')