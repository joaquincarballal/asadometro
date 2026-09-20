-- Bug real encontrado probando el flujo de plata en vivo: eliminarEvento()
-- borra la fila de `evento`, que por "on delete cascade" (0001_init.sql) arrastra
-- a evento_participante -- y eso dispara evento_participante_guard_delete()
-- (0014), que bloquea sacar a cualquiera que haya pagado un gasto. El trigger
-- fue pensado para "sacar a UNA persona de un evento que sigue en pie", no para
-- "borrar el evento entero" -- pero no distinguía los dos casos, así que
-- eliminarEvento() fallaba siempre que hubiera al menos un gasto pagado (o sea,
-- en cualquier asado real ya usado).
--
-- Fix: si el evento ya no existe (porque el DELETE vino en cascada desde borrar
-- el evento entero), se salta todo el guard -- no hay nada que "redistribuir",
-- se está borrando todo junto.

create or replace function evento_participante_guard_delete()
returns trigger
language plpgsql
as $$
declare
  v_gasto record;
  v_restantes int;
begin
  if not exists (select 1 from evento where id = old.evento_id) then
    return old;
  end if;

  if exists (
    select 1 from gasto
    where evento_id = old.evento_id and pagador_id = old.participante_id
  ) then
    raise exception 'No se puede sacar a alguien que pagó gastos de este evento.';
  end if;

  for v_gasto in
    select distinct g.id
    from gasto g
    join gasto_participante gp on gp.gasto_id = g.id
    where g.evento_id = old.evento_id and gp.participante_id = old.participante_id
  loop
    select count(*) into v_restantes
    from gasto_participante
    where gasto_id = v_gasto.id and participante_id <> old.participante_id;

    if v_restantes = 0 then
      raise exception 'No se puede sacar: quedaría un gasto sin nadie que lo pague.';
    end if;

    delete from gasto_participante
    where gasto_id = v_gasto.id and participante_id = old.participante_id;

    update gasto_participante
    set proporcion = proporcion / (
      select sum(proporcion) from gasto_participante where gasto_id = v_gasto.id
    )
    where gasto_id = v_gasto.id;
  end loop;

  return old;
end;
$$;
