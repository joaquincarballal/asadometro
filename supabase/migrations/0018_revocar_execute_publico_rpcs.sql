-- Fix de seguridad: Postgres otorga EXECUTE a PUBLIC por default al crear una
-- función. 0017 le agregó el grant a `authenticated` a stats_participaciones()
-- pero nunca le sacó el de PUBLIC -- quedó llamable por cualquiera sin login
-- (/rest/v1/rpc/stats_participaciones con la anon key, sin Authorization),
-- devolviendo nombre/avatar/fecha de alta de usuarios reales.
--
-- cerrar_evento ya estaba a salvo en la práctica (chequea is_participant()
-- internamente, que da false para anon), pero se le saca igual el PUBLIC por
-- higiene -- no depender solo de la lógica interna cuando el grant también
-- puede expresar la intención real.

revoke execute on function stats_participaciones() from public;
revoke execute on function cerrar_evento(uuid) from public;

grant execute on function stats_participaciones() to authenticated;
grant execute on function cerrar_evento(uuid) to authenticated;
