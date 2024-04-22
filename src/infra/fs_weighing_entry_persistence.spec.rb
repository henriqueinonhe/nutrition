Test.test {
  entries = [
      Domain::WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 57
    ),
      Domain::WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 69
    ),
      Domain::WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 12
    ),
      Domain::WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 34.5
    )
  ]

  Infra::FsWeighingEntryPersistence.store(entries)

  retrieved = Infra::FsWeighingEntryPersistence.retrieve()

  Assertions.check {
    retrieved.map { |entry| entry.to_h.to_json } == entries.map { |entry| entry.to_h.to_json } 
  }
}
