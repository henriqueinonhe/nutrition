# frozen_string_literal: true

require 'json'

RSpec.describe Infra::FsFoodPersistence do
  context 'When storing and retrieving foods' do
    def setup
      food_persistence = Infra::FsFoodPersistence.new(
        foods_file_path: './storage/foods.test.json'
      )

      foods = [
        TestUtils::FoodFactory.call,
        TestUtils::FoodFactory.call,
        TestUtils::FoodFactory.call
      ]

      food_persistence.store(foods)

      retrieved_foods = food_persistence.retrieve

      {
        food_persistence:,
        foods:,
        retrieved_foods:
      }
    end

    it 'Retrieves the same foods that were stored' do
      result = setup

      foods = result[:foods]
      retrieved_foods = result[:retrieved_foods]

      expect(retrieved_foods).to contain_exactly(*foods)
    end
  end
end
