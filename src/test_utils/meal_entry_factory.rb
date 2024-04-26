module TestUtils::MealEntryFactory
  def self.call(**overrides)
    default_values = {
      id: Random.uuid(),
      date: Time.new(),
      food: TestUtils::FoodFactory.call(),
      weight_in_grams: 100
    }

    result = default_values.merge(overrides)

    return Domain::MealEntry.new(**result)
  end
end