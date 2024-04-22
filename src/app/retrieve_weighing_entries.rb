module RetrieveWeighingEntries
  def self.call()
    WeighingEntryPersistence.retrieve()
  end
end