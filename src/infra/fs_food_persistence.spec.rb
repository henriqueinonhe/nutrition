Test.test {
  food_persistence = Infra::FsFoodPersistence.new(
    foods_file_path: "./storage/foods.test.json"
  )

  foods = [
    Domain::Food.new(
      id: "1",
      name: "Apple",
      kcal_per_gram: 0.52,
      carbohydrates_in_grams_per_gram: 0.14,
      protein_in_grams_per_gram: 0.01,
      total_fat_in_grams_per_gram: 0.01,
      fibers_in_grams_per_gram: 0.02,
      sodium_in_mg_per_gram: 0.01
    ),
    Domain::Food.new(
      id: "2",
      name: "Banana",
      kcal_per_gram: 0.89,
      carbohydrates_in_grams_per_gram: 0.23,
      protein_in_grams_per_gram: 0.01,
      total_fat_in_grams_per_gram: 0.01,
      fibers_in_grams_per_gram: 0.02,
      sodium_in_mg_per_gram: 0.01
    )
  ]

  food_persistence.store(foods)

  retrieved_foods = food_persistence.retrieve()

  Assertions.check {
    retrieved_foods.map { |entry| entry.to_h.to_json } == foods.map { |entry| entry.to_h.to_json } 
  }
}