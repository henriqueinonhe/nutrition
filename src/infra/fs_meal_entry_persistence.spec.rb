# frozen_string_literal: true

RSpec.describe Infra::FsMealEntryPersistence do
  context 'When storing and retrieving meal entries' do
    def setup
      meal_entry_persistence = Infra::FsMealEntryPersistence.new(
        meal_entries_file_path: './storage/meal_entries.test.json'
      )

      foods_hash = {
        '1' => Domain::Food.new(
          id: '1',
          name: 'Apple',
          kcal_per_gram: 0.52,
          carbohydrates_in_grams_per_gram: 0.14,
          protein_in_grams_per_gram: 0.01,
          total_fat_in_grams_per_gram: 0.01,
          fibers_in_grams_per_gram: 0.02,
          sodium_in_mg_per_gram: 0.01
        ),
        '2' => Domain::Food.new(
          id: '2',
          name: 'Banana',
          kcal_per_gram: 0.89,
          carbohydrates_in_grams_per_gram: 0.23,
          protein_in_grams_per_gram: 0.01,
          total_fat_in_grams_per_gram: 0.01,
          fibers_in_grams_per_gram: 0.02,
          sodium_in_mg_per_gram: 0.01
        )
      }

      meal_entries = [
        Domain::MealEntry.new(
          id: '1',
          date: Time.new,
          food: foods_hash['1'],
          weight_in_grams: 100
        ),
        Domain::MealEntry.new(
          id: '2',
          date: Time.new,
          food: foods_hash['2'],
          weight_in_grams: 200
        )
      ]

      meal_entry_persistence.store(meal_entries)

      retrieved_meal_entries = meal_entry_persistence.retrieve(foods_hash:)

      {
        meal_entries:,
        retrieved_meal_entries:
      }
    end

    it 'Retrieves the same meal entries that were stored' do
      result = setup

      meal_entries = result[:meal_entries]
      retrieved_meal_entries = result[:retrieved_meal_entries]

      expect(retrieved_meal_entries).to contain_exactly(*meal_entries)
    end
  end
end
