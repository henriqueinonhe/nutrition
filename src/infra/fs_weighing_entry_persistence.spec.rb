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

  persistence = Infra::FsWeighingEntryPersistence.new(weighings_file_path: "./storage/weighings.test.json")

  persistence.store(entries)

  retrieved = persistence.retrieve()

  Assertions.check {
    retrieved.map { |entry| entry.to_h.to_json } == entries.map { |entry| entry.to_h.to_json } 
  }
}
