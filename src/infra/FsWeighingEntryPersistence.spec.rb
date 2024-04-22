require "./src/infra/FsWeighingEntryPersistence"
require "./src/testing/Assertions"
require "./src/testing/Test"
require "./src/domain/WeighingEntry"

Test.test {
  entries = [
      WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 57
    ),
      WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 69
    ),
      WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 12
    ),
      WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 34.5
    )
  ]

  FsWeighingEntryPersistence.store(entries)

  retrieved = FsWeighingEntryPersistence.retrieve()

  Assertions.check {
    retrieved.map { |entry| entry.to_h.to_json } == entries.map { |entry| entry.to_h.to_json } 
  }
}
