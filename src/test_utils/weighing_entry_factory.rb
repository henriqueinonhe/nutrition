module TestUtils::WeighingEntryFactory
  def self.call(**overrides)
    default = {
      id: Random.uuid(),
      date: Time.new(),
      weight_in_kg: Random.rand(10..100)
    }

    result = default.merge(overrides)

    return Domain::WeighingEntry.new(**result)
  end
end