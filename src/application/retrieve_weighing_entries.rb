class Application::RetrieveWeighingEntries
  def initialize(weighing_entry_persistence:, weighings:)
    @weighings = weighings
    @weighing_entry_persistence = weighing_entry_persistence
  end

  def call()
    @weighings.clear()
    @weighings.append(*@weighing_entry_persistence.retrieve())
  end
end