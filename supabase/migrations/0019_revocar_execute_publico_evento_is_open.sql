-- Mismo patrón que 0018: evento_is_open() es security definer y nunca tuvo un
-- grant explícito (solo el EXECUTE a PUBLIC que Postgres da por default al
-- crear una función), así que cualquier anon puede preguntar si un evento
-- puntual (conociendo su UUID) está abierto o cerrado. Severidad baja -- no es
-- dato sensible y el UUID no es adivinable -- pero se cierra por consistencia
-- con el resto de las funciones security definer.
--
-- is_participant() tiene el mismo problema técnico pero no se toca: para
-- anon, auth.uid() es null, así que siempre devuelve false sin filtrar nada
-- (no hay ninguna fila de evento_participante con participante_id = null).

revoke execute on function evento_is_open(uuid) from public;
grant execute on function evento_is_open(uuid) to authenticated;
