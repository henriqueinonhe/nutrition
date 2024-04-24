Test.test {
  food = Domain::Food.new(
    id: "id",
    name: "Requeijão",
    kcal_per_gram: 1.57,
    carbohydrates_in_grams_per_gram: 0.018,
    protein_in_grams_per_gram: 0.12,
    total_fat_in_grams_per_gram: 0.11,
    fibers_in_grams_per_gram: 0.0,
    sodium_in_mg_per_gram: 1.47
  )

  stats = food.stats_for_weight(27)

  epsilon = 0.1

  Assertions.check {
    FloatTest.epsilon_equals(stats[:kcal], 42.39, epsilon)
  }

  Assertions.check {
    FloatTest.epsilon_equals(stats[:carbohydrates_in_grams], 0.486, epsilon)
  }

  Assertions.check {
    FloatTest.epsilon_equals(stats[:protein_in_grams], 3.24, epsilon)
  }

  Assertions.check {
    FloatTest.epsilon_equals(stats[:total_fat_in_grams], 2.97, epsilon)
  }

  Assertions.check {
    FloatTest.epsilon_equals(stats[:fibers_in_grams], 0.0, epsilon)
  }

  Assertions.check {
    FloatTest.epsilon_equals(stats[:sodium_in_mg], 39.69, epsilon)
  }

}