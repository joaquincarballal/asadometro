export function Privacidad() {
  return (
    <div className="mx-auto flex min-h-dvh max-w-[640px] flex-col gap-md bg-background px-container-padding py-8 text-on-surface">
      <h1 className="font-display text-2xl font-bold text-primary">Política de Privacidad de Asadómetro</h1>
      <p className="text-sm text-on-surface-variant">Última actualización: septiembre de 2026.</p>

      <p>
        Asadómetro es una app personal, sin fines comerciales, para repartir los gastos de los
        asados entre un grupo de gente. Esta página explica qué datos pide y qué hace con ellos.
      </p>

      <h2 className="font-display text-lg font-semibold text-primary">Qué datos recopila</h2>
      <p>
        Al loguearte con Google, se guardan tu nombre, tu foto de perfil y tu email — los datos
        básicos que Google comparte en cualquier "Iniciar sesión con Google". No se pide ni se
        accede a nada más de tu cuenta de Google.
      </p>
      <p>
        Además, se guarda la información que vos cargás manualmente en la app: los asados que
        creás o a los que te sumás, los gastos que registrás y quién participó de cada uno.
      </p>

      <h2 className="font-display text-lg font-semibold text-primary">Para qué se usan</h2>
      <p>
        Para identificarte dentro de la app y calcular quién le debe qué a quién en cada asado.
        Tu nombre y foto son visibles para los demás participantes de tus asados, y también
        aparecen en las pantallas de ranking y estadísticas del grupo (quién asó más veces, % de
        asistencia). Tu email no se muestra a otros usuarios.
      </p>

      <h2 className="font-display text-lg font-semibold text-primary">Qué NO se hace</h2>
      <p>
        No se vende ni se comparte tu información con terceros. No hay publicidad ni rastreo de
        ningún tipo. Los datos solo se usan para que la app funcione.
      </p>

      <h2 className="font-display text-lg font-semibold text-primary">Dónde se guarda</h2>
      <p>
        Los datos viven en una base de datos de Supabase (Postgres), un proveedor de
        infraestructura en la nube. El código de la app es de código abierto.
      </p>

      <h2 className="font-display text-lg font-semibold text-primary">Borrar tus datos</h2>
      <p>
        Si querés que se elimine tu cuenta y todo lo asociado a ella, escribime a{' '}
        <a href="mailto:jt.carballal@gmail.com" className="text-primary underline">
          jt.carballal@gmail.com
        </a>
        .
      </p>
    </div>
  );
}
