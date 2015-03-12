# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Restaurant.create({
  name: "Ovo Cafe",
  phone_number: "415-908-3888",
  source_name: "orderahead",
  source_url: "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca",
  logo_url: "https://d3de9ulu7b6z6y.cloudfront.net/uploads/store/logo/1660/thumb_ovo_cafe.png",
  yelp_url: "http://www.yelp.com/biz/ovo-cafe-san-francisco",
  delivery_hours_start: 480,
  delivery_hours_end: 1230,
})
