require "./src/domain/WeighingEntryPersistence"

module StoreWeighingEntries
  def self.call(entries)
    WeighingEntryPersistence.store(entries)
  end
end