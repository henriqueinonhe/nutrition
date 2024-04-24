Test.test {
  meal_entry_persistence = Infra::FsMealEntryPersistence.new(
    meal_entries_file_path: "./storage/meal_entries.test.json"
  )

  meal_entry_persistence.store([
    Domain::MealEntry.new(
      id: "1",
      date: Time.new(2021, 1, 1),
      food: Domain::Food.new(
        id: "1",
        name: "food1",
        kcal_per_gram: 1,
        carbohydrates_in_grams_per_gram: 1,
        protein_in_grams_per_gram: 1,
        total_fat_in_grams_per_gram: 1,
        fibers_in_grams_per_gram: 1,
        sodium_in_mg_per_gram: 1
      ),
      weight_in_grams: 100
    )
  ])
}