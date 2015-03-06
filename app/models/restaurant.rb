class Restaurant < ActiveRecord::Base
  validate :find_and_save_or_update

  def find_and_save_or_update
    existing_record = Restaurant.find_by name: self.name
    return if existing_record.nil?

    if self.diff?(existing_record)
      errors.add(:existing, "update")
    else
      errors.add(:existing, "exact")
    end
  end

  def diff other_restaurant
    skip_attr = [
      "id",
      "created_at",
      "updated_at",
    ]

    differences = []
    other_restaurant.attributes.map do |attribute|
      attr_method = attribute[0]
      next if skip_attr.include?(attr_method)

      if self.send(attr_method) != other_restaurant.send(attr_method)
        differences << attr_method
      end
    end
    differences
  end

  def diff? other_restaurant
    !self.diff(other_restaurant).empty?
  end
end
