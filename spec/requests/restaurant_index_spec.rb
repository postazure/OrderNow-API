require 'rails_helper'


describe "GET /restaurants" do
  let(:db_restaurant) {Restaurant.new({
    name: "Ovo Cafe",
    phone_number: "415-908-3888",
    source_name: "orderahead",
    source_url: "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca",
    logo_url: "https://d3de9ulu7b6z6y.cloudfront.net/uploads/store/logo/1660/thumb_ovo_cafe.png",
    yelp_url: "http://www.yelp.com/biz/ovo-cafe-san-francisco",
    delivery_hours_start: 480,
    delivery_hours_end: 1230,
  })}

  it "returns restaurants core data" do
    db_restaurant.save!
    get restaurants_path, {}, {"Accept" => "application/json"}
    expect(response.status).to eq 200
    body = JSON.parse(response.body)

    json_restaurant = body.first
    id = json_restaurant["id"]
    name = json_restaurant["name"]
    source_url = json_restaurant["source_url"]
    delivery_hours_start = json_restaurant["delivery_hours_start"]
    delivery_hours_end = json_restaurant["delivery_hours_end"]

    expect(id).to eq db_restaurant.id
    expect(name).to eq "Ovo Cafe"
    expect(source_url).to eq "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca"
    expect(delivery_hours_start).to eq 480
    expect(delivery_hours_end).to eq 1230
  end
end
