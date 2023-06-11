create index sexoin on testacliente(sexo);

create index estadoin on endereco_cliente(estado);

/*
 a criação de um índice no campo "tamanho" da tabela "roupa" ajuda a acelerar as consultas que envolvem esse atributo,
 melhorando o desempenho geral do banco de dados ao reduzir a quantidade de dados a serem percorridos. Isso é especialmente 
 relevante quando existem consultas frequentes que filtram, agrupam ou ordenam os registros com base no tamanho das roupas.
*/
create index tamanhoin on testaroupa(tamanho);

/*

-- Teste para indice tamanhoin
create table testaRoupa as select * from roupa;
insert into roupa values(default, 'Disponível', '2022-11-08', 'Asics', 'XXL', 'Novo','Bermuda');
insert into roupa values(default, 'Disponível', '2022-11-08', 'Asics', 'SS', 'Novo','Bermuda');
insert into roupa values(default, 'Disponível', '2022-11-08', 'Asics', 'SSS', 'Novo','Bermuda');
insert into roupa values(default, 'Disponível', '2022-11-08', 'Asics', 'XXXL', 'Novo','Bermuda');

DO $$DECLARE i int:= 0;
BEGIN
    WHILE I <= 2000000 LOOP
        INSERT INTO testaroupa select * from roupa;
        I := I + 1;
    END LOOP;
END$$;

select tamanho from testaroupa where tamanho = 'SSS';

--drop table testaroupa cascade;
*/