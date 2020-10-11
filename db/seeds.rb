# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Vote.delete_all

Article.delete_all

Category.delete_all

User.delete_all

user = User.create!(name: 'tunjit')

%w[African Asian European Vegan Vegetarian].map.with_index do |item, i|
  c = Category.find_or_create_by!(name: item, priority: i)

  a = Article.create(title: "Kitfo#{c.id}", text: "
      This classic Ethiopian dish may be served either raw or cooked.
       In our cooked version, sauteed chiles, ginger, and Ethiopian spices perfume the dish.
       Be sure to serve it warm or at room temperature because when it's cold the flavors become muted.
     ", user_id: user.id, category_id: c.id)

  Vote.create!(article_id: a.id, user_id: user.id, created_at: '2020-10-02 18:25:16', updated_at: '2020-10-02 18:25:16')
end
