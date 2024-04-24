Test.test {
  foods_hash = {
    "1" => Domain::Food.new(
      id: "1",
      name: "Apple",
      kcal_per_gram: 0.52,
      carbohydrates_in_grams_per_gram: 0.14,
      protein_in_grams_per_gram: 0.01,
      total_fat_in_grams_per_gram: 0.01,
      fibers_in_grams_per_gram: 0.02,
      sodium_in_mg_per_gram: 0.01
    ),
    "2" => Domain::Food.new(
      id: "2",
      name: "Banana",
      kcal_per_gram: 0.89,
      carbohydrates_in_grams_per_gram: 0.23,
      protein_in_grams_per_gram: 0.01,
      total_fat_in_grams_per_gram: 0.01,
      fibers_in_grams_per_gram: 0.02,
      sodium_in_mg_per_gram: 0.01
    )
  }

  list_foods = Application::ListFoods.new(
    foods_hash: foods_hash
  )

  foods = list_foods.call()

  Assertions.check { foods.map { |food| food.to_h.to_json } == foods_hash.map { |_, food| food.to_h.to_json } }
}