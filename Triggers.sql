create or replace function atualizar_estado_roupa()
returns trigger as $$
declare
    quantidade_pedidos integer;
begin
    -- Contar a quantidade de pedidos em que a roupa aparece
    select count(id_pedido)
    into quantidade_pedidos
    from pedidos_roupa
    where id_roupa = new.id_roupa;
    
    -- Atualizar o estado da roupa com base na quantidade de pedidos
    if quantidade_pedidos <= 5 then
        update roupa set estado = 'Nova';
    elsif quantidade_pedidos <= 10 then
        update roupa set estado = 'Pouco Usada';
	elsif quantidade_pedidos <= 15 then
		update roupa set estado = 'Usada';
	else 
		update roupa set estado = 'Muito Usada';
    end if;
    
    return null;
end;
$$ language plpgsql;

create trigger atualizacao_estado_roupa_trigger
after insert or update on pedidos_roupa
for each row
execute function atualizar_estado_roupa();

select * from pedidos_roupa;