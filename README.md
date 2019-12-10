# README

Comentarios:
- Los endpoints están funcionando desde la creación del usuario hasta el listado y detalle de reservas.
- A pesar de que faltan cosas, mi mayor duda es acerca de los tests. Primero porque no me estaban funcionando como esperaba los fixtures (no se crean todos los items por ejemplo), y segundo porque no se si todo lo que estoy probando es apropiado.
  De todas maneras, solo hice algunos en el producto.
- Me quedo con dudas acerca de JSON:API y si lo implementé bien, ya que me costó traducir algunas cosas del enunciado a la especificación. Por ejemplo, el formato de petición para la creación de reservas.
- Usé la gema 'jsonapi-rails' para la serialización y deserialización del json.

Para levantar:
- rails db:create db:migrate db:seed (crea un usuario admin, un cliente y un par de productos)
- rails server