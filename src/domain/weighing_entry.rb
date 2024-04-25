require "random/formatter"

class Domain::WeighingEntry
  attr_reader :id, :date, :weight_in_kg

  def self.validate_id(id)
    if !id.is_a? String || id.empty?
      raise Errors::Error.new(
        msg: "ID (#{id}) is not a valid ID!",
        tags: [:PreconditionViolation, :ConstructionFailure, :WeighingEntry, :InvalidId]
      )
    end
  end

  def self.validate_date(date)
    if !date.is_a? Time
      raise Errors::Error.new(
        msg: "Date (#{date}) is not a valid date!",
        tags: [:PreconditionViolation, :ConstructionFailure, :WeighingEntry, :InvalidDate]
      )
    end
  end

  def self.validate_weight(weight)
    if !(weight.is_a? Numeric) || weight <= 0
      raise Errors::Error.new(
        msg: "Weight (#{weight}) is not a valid weight!",
        tags: [:PreconditionViolation, :ConstructionFailure, :WeighingEntry, :InvalidWeight]
      )
    end
  end

  def initialize(id:, date:, weight_in_kg:)
    self.class.validate_id(id)
    self.class.validate_date(date)
    self.class.validate_weight(weight_in_kg)

    @id = id
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

  def to_h()
    {
      id: @id,
      date: @date,
      weight_in_kg: @weight_in_kg
    }
  end

  def ==(other)
    return other.instance_of?(Domain::WeighingEntry) &&
      other.id == @id &&
      other.date.to_i == @date.to_i &&
      other.weight_in_kg == @weight_in_kg
  end
end
