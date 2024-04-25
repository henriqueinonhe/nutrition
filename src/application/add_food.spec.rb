RSpec.describe Application::AddFood do
  context "When food name is duplicated" do
    def setup
      foods_hash = {
        "1": Domain::Food.new(
          id: "1",
          name: "Apple",
          kcal_per_gram: 0.52,
          carbohydrates_in_grams_per_gram: 0.14,
          protein_in_grams_per_gram: 0.01,
          total_fat_in_grams_per_gram: 0.01,
          fibers_in_grams_per_gram: 0.02,
          sodium_in_mg_per_gram: 0.01
        ),
        "2": Domain::Food.new(
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

      add_food = Application::AddFood.new(foods_hash:, foods_persistence:)

      return {
        foods_hash: foods_hash,
        foods_persistence: foods_persistence,
        add_food: add_food
      }
    end

    it "Raises a validation error" do
      result = setup()

      add_food = result[:add_food]

      expect {
        add_food.call(
          name: "Apple",
          kcal_per_gram: 1.52,
          carbohydrates_in_grams_per_gram: 0.14,
          protein_in_grams_per_gram: 3.01,
          total_fat_in_grams_per_gram: 0.21,
          fibers_in_grams_per_gram: 123,
          sodium_in_mg_per_gram: 0.01
        )
      }.to raise_error(
        having_attributes(
          tags: [:ValidationError, :DuplicateName]
        )
      )
    end
  end

  context "When adding a new food" do
    def setup
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
  
      foods_persistence = Infra::FsFoodPersistence.new(
        foods_file_path: "./storage/foods.test.json"
      )
  
      add_food = Application::AddFood.new(foods_hash:, foods_persistence:)

      return {
        add_food:,
        foods_hash:,
        foods_persistence:
      }
    end

    it "Adds the new food to the foods hash" do
      result = setup()

      add_food = result[:add_food]
      foods_hash = result[:foods_hash]
      foods_persistence = result[:foods_persistence]

      new_food = add_food.call(
        name: "Orange",
        kcal_per_gram: 1.52,
        carbohydrates_in_grams_per_gram: 0.14,
        protein_in_grams_per_gram: 3.01,
        total_fat_in_grams_per_gram: 0.21,
        fibers_in_grams_per_gram: 123,
        sodium_in_mg_per_gram: 0.01
      )

      expect(foods_hash[new_food.id]).to eq(new_food)
  
      retrieved_foods = foods_persistence.retrieve()

      expect(retrieved_foods).to eq(foods_hash.values)
    end
  end
end
