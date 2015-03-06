require 'rails_helper'
describe Restaurant do
  let(:db_restaurant) {Restaurant.create!({
    name: "Ovo Cafe",
    phone_number: "415-908-3888",
    source_name: "orderahead",
    source_url: "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca",
    logo_url: "https://d3de9ulu7b6z6y.cloudfront.net/uploads/store/logo/1660/thumb_ovo_cafe.png",
    yelp_url: "http://www.yelp.com/biz/ovo-cafe-san-francisco",
    delivery_hours_start: 480,
    delivery_hours_end: 1230,
  })}

  it "create!" do
    expect(db_restaurant.name).to eq("Ovo Cafe")
  end

  it "diff" do
    test_restaurant = Restaurant.new({
      name: "Ovo Cafe",
      phone_number: "415-908-3888",
      source_name: "orderahead",
      source_url: "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca",
      logo_url: "https://d3de9ulu7b6z6y.cloudfront.net/uploads/store/logo/1660/thumb_ovo_cafe.png",
      yelp_url: "http://www.yelp.com/biz/ovo-cafe-san-francisco",
      delivery_hours_start: 480,
      delivery_hours_end: 1230,
    })

    test_restaurant.name = "Evo Cafe"
    test_restaurant.phone_number = "432-123-1234"
    expect(test_restaurant.name).to eq "Evo Cafe"
    expect(test_restaurant.phone_number).to eq "432-123-1234"

    differences = db_restaurant.diff(test_restaurant)
    expect(differences.class).to be Array
    expect(differences).to include ("name")
    expect(differences).to include ("phone_number")
  end
end
