class Domain::Food
  attr_reader :id, 
              :name, 
              :kcal_per_gram, 
              :carbohydrates_in_grams_per_gram, 
              :protein_in_grams_per_gram, 
              :total_fat_in_grams_per_gram, 
              :fibers_in_grams_per_gram, 
              :sodium_in_mg_per_gram

  def initialize(
    id:,
    name:,
    kcal_per_gram:,
    carbohydrates_in_grams_per_gram:,
    protein_in_grams_per_gram:,
    total_fat_in_grams_per_gram:,
    fibers_in_grams_per_gram:,
    sodium_in_mg_per_gram:
  )

    @id = id
    @name = name
    @kcal_per_gram = kcal_per_gram
    @carbohydrates_in_grams_per_gram = carbohydrates_in_grams_per_gram
    @protein_in_grams_per_gram = protein_in_grams_per_gram
    @total_fat_in_grams_per_gram = total_fat_in_grams_per_gram
    @fibers_in_grams_per_gram = fibers_in_grams_per_gram
    @sodium_in_mg_per_gram = sodium_in_mg_per_gram
  end

  def stats_for_weight(weight_in_grams)
    # NOTE: Maybe extract this to a value object
    {
      kcal: kcal_per_gram * weight_in_grams,
      carbohydrates_in_grams: carbohydrates_in_grams_per_gram * weight_in_grams,
      protein_in_grams: protein_in_grams_per_gram * weight_in_grams,
      total_fat_in_grams: total_fat_in_grams_per_gram * weight_in_grams,
      fibers_in_grams: fibers_in_grams_per_gram * weight_in_grams,
      sodium_in_mg: sodium_in_mg_per_gram * weight_in_grams
    }
  end
end