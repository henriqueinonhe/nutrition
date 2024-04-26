module TestUtils::FoodFactory
  def self.call(**overrides)
    default_values = {
      id: Random.uuid(),
      name: "Requeijão",
      kcal_per_gram: 1.57,
      carbohydrates_in_grams_per_gram: 0.018,
      protein_in_grams_per_gram: 0.12,
      total_fat_in_grams_per_gram: 0.11,
      fibers_in_grams_per_gram: 0.0,
      sodium_in_mg_per_gram: 1.47
    }

    result = default_values.merge(overrides)

    return Domain::Food.new(**result)
  end
end