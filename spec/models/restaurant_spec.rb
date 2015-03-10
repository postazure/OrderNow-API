require 'rails_helper'
describe Restaurant do
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
  let(:test_restaurant) {Restaurant.new({
    name: "Ovo Cafe",
    phone_number: "415-908-3888",
    source_name: "orderahead",
    source_url: "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca",
    logo_url: "https://d3de9ulu7b6z6y.cloudfront.net/uploads/store/logo/1660/thumb_ovo_cafe.png",
    yelp_url: "http://www.yelp.com/biz/ovo-cafe-san-francisco",
    delivery_hours_start: 480,
    delivery_hours_end: 1230,
  })}

  before :each do
    db_restaurant.save!
  end

  it "create!" do
    expect(db_restaurant.name).to eq("Ovo Cafe")
  end

  it "diff" do
    test_restaurant.name = "Evo Cafe"
    test_restaurant.phone_number = "432-123-1234"
    differences = db_restaurant.diff(test_restaurant)

    expect(differences).to eq ["name", "phone_number"]
  end

  describe ".diff?" do
    it "should not be different" do
      expect(test_restaurant.diff?(db_restaurant)).to be false
    end

    it "should be different" do
      test_restaurant.name = "Evo Cafe"
      test_restaurant.phone_number = "432-123-1234"

      expect(test_restaurant.diff?(db_restaurant)).to be true
    end
  end

  describe "Validations" do
    describe "already exists" do
      it "has no change" do
        is_saved = test_restaurant.save

        expect(is_saved).to be false
        expect(test_restaurant.errors["existing"]).to eq ["exact"]
      end
      it "has change" do
        test_restaurant.phone_number = "123-123-1234"
        is_saved = test_restaurant.save

        expect(is_saved).to be false
        expect(test_restaurant.errors["existing"]).to eq ["update"]
      end
    end

    describe "same restaurant, but different service" do
      it "saves with duplicate information aslong as the service is different" do
        test_restaurant.source_name = "New Test Service"
        is_saved = test_restaurant.save
        expect(is_saved).to be true
      end
    end
  end
end
