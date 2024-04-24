Test.test {
  foods_hash = {}
  foods_persistence = Infra::FsFoodPersistence.new(
    foods_file_path: "./storage/foods.test.json"
  )

  delete_food = Application::DeleteFood.new(
    foods_hash:, 
    foods_persistence:
  )

  begin
    delete_food.call("1")
    Assertions.should_not_get_here()
  rescue Errors::Error => e
    Assertions.check { e.has_tag?(:ValidationError) && e.has_tag?(:FoodNotFound) }
  end
}

Test.test {
  foods_hash ={
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

  foods_persistence = Infra::FsFoodPersistence.new(
    foods_file_path: "./storage/foods.test.json"
  )

  delete_food = Application::DeleteFood.new(
    foods_hash:, 
    foods_persistence:
  )

  delete_food.call("1")

  Assertions.check { foods_hash["1"].nil? }

  retrieved_foods = foods_persistence.retrieve()

  Assertions.check { retrieved_foods.all? { |food| foods_hash[food.id].to_h.to_json == food.to_h.to_json } }
}