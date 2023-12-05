# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: 'test@test', password: 'testpass')

Genre.create!(id: 1, name: 'ケーキ')
Genre.create!(id: 2, name: 'プリン')
Genre.create!(id: 3, name: '焼き菓子')

Item.create!(genre_id: 1, name: 'ケーキ', introduction: 'ケーキです', price: 3500, is_active: true)
Item.create!(genre_id: 2, name: 'プリン', introduction: 'プリンです', price: 400, is_active: true)
Item.create!(genre_id: 3, name: '焼き菓子', introduction: '焼き菓子です', price: 3500, is_active: false)