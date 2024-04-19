class WeighingEntry
  def self.validate_date(date)
    if !date.is_a? Time
      # TODO: Use a specialized exception
      raise "Date (#{date}) is not a valid date!"
    end
  end

  def self.validate_weight(weight)
    if !(weight.is_a? Numeric) || weight <= 0
      # TODO: Use a specialized exception
      raise "Weight (#{weight}) is not a valid weight!"
    end
  end

  def initialize(date:, weight_in_kg:)
    self.class.validate_date(date)
    self.class.validate_weight(weight_in_kg)

    @date = date
    @weight_in_kg = weight_in_kg
  end

  def to_s()
    <<~HEREDOC
    WeightEntry
      date: #{@date}
      weight_in_kg: #{@weight_in_kg}
    HEREDOC
  end
end
