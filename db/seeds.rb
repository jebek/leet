# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

more_sets = [
  {:title => 'Aladdin', :description => 'G'},
  {:title => 'When Harry Met Sally', :description => 'R'},
  {:title => 'The Help', :description => 'PG-13'},
  {:title => 'Raiders of the Lost Ark', :description => 'PG'}
]

more_sets.each do |set|
  Vset.create!(set)
end