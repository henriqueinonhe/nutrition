class Infra::FsMealEntryPersistence
   def initialize(
    meal_entries_file_path:
  )
    @meal_entries_file_path = meal_entries_file_path
  end

  def store(meal_entries)
    file = File.open(@meal_entries_file_path, "w")

    file.write(meal_entries.map { |entry|
      {
        id: entry.id,
        date: entry.date,
        food_id: entry.food.id,
        weight_in_grams: entry.weight_in_grams
      }
    }.to_json)

    file.close()
  end

  def retrieve(foods_hash:)
    file = File.open(@meal_entries_file_path, "r")

    serialized_meal_entries = JSON.parse(file.read(), {symbolize_names: true})

    file.close()

    return serialized_meal_entries.map { |serialized_food| 
      food = foods_hash[serialized_food[:food_id]]

      if !food
        raise Errors::Error.new(
          msg: "Food with id #{serialized_food[:food_id]} not found",
          tags: [:PreconditionViolation]
        )
      end

      Domain::MealEntry.new(
        id: serialized_food[:id],
        date: Time.new(serialized_food[:date]),
        food:,
        weight_in_grams: serialized_food[:weight_in_grams]
      )
    }
  end
end