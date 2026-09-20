-- 0020 arregló la policy de UPDATE pero el upsert de unirseAEvento() seguía
-- fallando igual. Causa real: INSERT ... ON CONFLICT DO UPDATE necesita
-- evaluar la policy de SELECT para decidir si la fila en conflicto es
-- "visible" -- y evento_participante_select solo dejaba ver filas de eventos
-- de los que ya sos parte. Para alguien uniéndose por primera vez, su propia
-- fila (que ni siquiera existe todavía) queda "invisible", y esa falta de
-- visibilidad es lo que dispara el error de RLS en el upsert, no el USING de
-- UPDATE (que ya estaba bien).

drop policy evento_participante_select on evento_participante;

create policy evento_participante_select on evento_participante for select
  to authenticated using (is_participant(evento_id) or participante_id = auth.uid());
