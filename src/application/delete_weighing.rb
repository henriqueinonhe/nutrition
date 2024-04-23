class Application::DeleteWeighing
  def initialize(weighings:, weighing_entry_persistence:)
    @weighings = weighings
    @weighing_entry_persistence = weighing_entry_persistence
  end

  def call(weighing_id)
    @weighings.filter! { |weighing| weighing.id != weighing_id }
    
    @weighing_entry_persistence.store(@weighings)

    return @weighings.zip(Domain::ComputeWeighingAverages.call(@weighings))
  end
end