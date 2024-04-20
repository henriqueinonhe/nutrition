require "./src/domain/WeighingEntryPersistence"

module RetrieveWeighingEntries
  def self.call()
    WeighingEntryPersistence.retrieve()
  end
end