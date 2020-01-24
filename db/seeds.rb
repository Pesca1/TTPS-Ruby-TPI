
IvaCondition.create!(name: 'IVA Responsable Inscripto')
IvaCondition.create!(name: 'IVA Responsable no Inscripto')
IvaCondition.create!(name: 'IVA no Responsable')
IvaCondition.create!(name: 'IVA Sujeto Exento')
IvaCondition.create!(name: 'Consumidor Final')
IvaCondition.create!(name: 'Responsable Monotributo')
IvaCondition.create!(name: 'Sujeto no Categorizado')
IvaCondition.create!(name: 'Proveedor del Exterior')
IvaCondition.create!(name: 'Cliente del Exterior')
IvaCondition.create!(name: 'IVA Liberado – Ley Nº 19.640')
IvaCondition.create!(name: 'IVA Responsable Inscripto – Agente de Percepción')
IvaCondition.create!(name: 'Pequeño Contribuyente Eventual')
IvaCondition.create!(name: 'Monotributista Social')
IvaCondition.create!(name: 'Pequeño Contribuyente Eventual Social')

u1 = User.create!(name: 'admin', password:'admin')

c1 = Client.create(name: 'client1', email: 'client1@gmail.com', iva_condition: IvaCondition.all.first, cuit: 'aaa111')
c2 = Client.create(name: 'client2', email: 'client2@gmail.com')
c1.phones << Phone.new(number: 1111, client: c1)
c1.save!
c1.phones.first.save!

p1 = Product.create!(code: 'ABC123456', description: 'Galletitas Portenitas', detail: 'Lorem ipsum dolor sit amen', price: 25.5)
p2 = Product.create!(code: 'ABC123457', description: 'Pepas de la abuela', detail: 'Lorem ipsum dolor sit amen', price: 20.5)
p3 = Product.create!(code: 'ABC123458', description: '9 de Oro', detail: 'Lorem ipsum dolor sit amen', price: 30.5)
p4 = Product.create!(code: 'ABC123459', description: 'Bay Biscuit', detail: 'Lorem ipsum dolor sit amen', price: 35.5)

#r1 = Reservation.create!(user: u1, client: c1)
#r2 = Reservation.create!(user: u1, client: c2)

Item.create!(product: p1)
Item.create!(product: p1)
Item.create!(product: p1)
Item.create!(product: p2)
Item.create!(product: p2)
Item.create!(product: p2)
Item.create!(product: p2)
#Item.create!(product: p2, reservation: r1)
#Item.create!(product: p2, reservation: r1)
#i1 = Item.create!(product: p3, reservation: r2)
#i2 = Item.create!(product: p4, reservation: r2)