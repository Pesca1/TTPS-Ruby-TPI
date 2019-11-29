# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: 'admin', password:'admin')

Product.create(code: 'ABC123', description: 'Galletitas Portenitas', detail: 'Lorem ipsum dolor sit amen', price: 25.5)
Product.create(code: 'ABC124', description: 'Pepas de la abuela', detail: 'Lorem ipsum dolor sit amen', price: 20.5)
Product.create(code: 'ABC125', description: '9 de Oro', detail: 'Lorem ipsum dolor sit amen', price: 30.5)
Product.create(code: 'ABC126', description: 'Bay Biscuit', detail: 'Lorem ipsum dolor sit amen', price: 35.5)

Item.create(product: Produc)

IvaCondition.create(name: 'IVA Responsable Inscripto')
IvaCondition.create(name: 'IVA Responsable no Inscripto')
IvaCondition.create(name: 'IVA no Responsable')
IvaCondition.create(name: 'IVA Sujeto Exento')
IvaCondition.create(name: 'Consumidor Final')
IvaCondition.create(name: 'Responsable Monotributo')
IvaCondition.create(name: 'Sujeto no Categorizado')
IvaCondition.create(name: 'Proveedor del Exterior')
IvaCondition.create(name: 'Cliente del Exterior')
IvaCondition.create(name: 'IVA Liberado – Ley Nº 19.640')
IvaCondition.create(name: 'IVA Responsable Inscripto – Agente de Percepción')
IvaCondition.create(name: 'Pequeño Contribuyente Eventual')
IvaCondition.create(name: 'Monotributista Social')
IvaCondition.create(name: 'Pequeño Contribuyente Eventual Social')