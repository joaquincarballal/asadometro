-- Fix: unirseAEvento() (el link de invitación) hace un upsert con onConflict
-- (evento_id, participante_id) por si alguien re-confirma. Postgres exige que
-- la policy de UPDATE también se cumpla para ese statement, aunque nunca haya
-- conflicto real (0009 ya documentó esto). El problema: evento_participante_update
-- solo dejaba pasar a quien YA es participante -- imposible para alguien que se
-- está uniendo por primera vez. Resultado: el link de invitación fallaba
-- siempre para gente nueva ("No se pudo confirmar la asistencia"), y solo
-- andaba si alguien ya adentro te agregaba a mano por "+ Agregar gente"
-- (ahí el que ejecuta el upsert es quien agrega, que sí es participante).
--
-- Mismo criterio que ya tiene evento_participante_insert desde 0008: dejar
-- pasar también cuando la fila es la del propio usuario.

drop policy evento_participante_update on evento_participante;

create policy evento_participante_update on evento_participante for update
  to authenticated
  using (is_participant(evento_id) or participante_id = auth.uid())
  with check (is_participant(evento_id) or participante_id = auth.uid());
