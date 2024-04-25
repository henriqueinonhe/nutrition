require "json"

RSpec.describe Infra::FsFoodPersistence do
  context "When storing and retrieving foods" do
    def setup
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

      return {
        food_persistence:,
        foods:,
        retrieved_foods:
      }
    end

    it "Retrieves the same foods that were stored" do
      result = setup()

      foods = result[:foods]
      retrieved_foods = result[:retrieved_foods]

      expect(retrieved_foods).to contain_exactly(*foods)
    end
  end
end

