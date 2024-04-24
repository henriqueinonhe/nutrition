class Domain::MealEntry
  attr_reader :id, :date, :weight_in_grams

  def initialize(
    id:,
    date:,
    food:,
    weight_in_grams:
  )
    @date = date
    @food = food
    @weight_in_grams = weight_in_grams
  end
  
  def stats
    @food.stats_for_weight(weight_in_grams)
  end

  def food_name
    @food.name
  end
end