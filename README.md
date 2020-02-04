# README

Trabajo de fin de cursada para el Taller de Tecnologías de Producción de Software - Opción Ruby.

Nota:
Durante el desarrollo se usó sqlite3 como base de datos por motivos de rendimiento, pero se puede utilizar mysql o postgres
sin ningún incoveniente.

Para levantar:
- git clone https://github.com/Pesca1/TTPS-Ruby-TPI.git
- cd TTPS-Ruby-TPI
- bundle install
- rails db:create db:migrate db:seed (crea un usuario admin, un cliente y un par de productos)
- rails server