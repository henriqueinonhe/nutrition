# require "./src/interface/CommandLineInterface"

# CommandLineInterface.new.start

require "./src/infra/FsWeighingEntryPersistence"
require "./src/domain/WeighingEntry"

FsWeighingEntryPersistence.store([
  WeighingEntry.new(
    date: Time.new(),
    weight_in_kg: 67.3
  )
])

FsWeighingEntryPersistence.retrieve()


