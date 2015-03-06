class Restaurant < ActiveRecord::Base
  def diff other_restaurant
    skip_attr = [
      "id",
      "created_at",
      "updated_at",
    ]

    other_restaurant.attributes.map do |attribute|
      attr_method = attribute[0]
      next if skip_attr.include?(attr_method)

      if self.send(attr_method) != other_restaurant.send(attr_method)
        attr_method
      end
    end
  end
end
