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


more_words = [
  {:name => 'a', :definition => '1', :vset_id => '1'},
  {:name => 'b', :definition => '2', :vset_id => '2'},
  {:name => 'c', :definition => '3', :vset_id => '3'},
  {:name => 'd', :definition => '4', :vset_id => '4'}]
  
more_words.each do |words|
  Word.create!(words)
end