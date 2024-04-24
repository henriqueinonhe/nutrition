require "random/formatter"

class Application::AddFood
  def initialize(foods_hash:)
    @foods_hash = foods_hash
  end

  def call(
    name:,
    kcal_per_gram:,
    carbohydrates_in_grams_per_gram:,
    protein_in_grams_per_gram:,
    total_fat_in_grams_per_gram:,
    fibers_in_grams_per_gram:,
    sodium_in_mg_per_gram:
  )

    food = Domain::Food.new(
      id: Random.uuid(),
      name:,
      kcal_per_gram:,
      carbohydrates_in_grams_per_gram:,
      protein_in_grams_per_gram:,
      total_fat_in_grams_per_gram:,
      fibers_in_grams_per_gram:,
    )

  end
end