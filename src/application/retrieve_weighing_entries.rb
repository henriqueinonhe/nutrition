module Application::RetrieveWeighingEntries
  def self.call()
    Domain::WeighingEntryPersistence.retrieve()
  end
end