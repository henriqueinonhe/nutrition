class Application::AddWeighing
  def initialize(weighings:, weighing_entry_persistence:)
    @weighings = weighings
    @weighing_entry_persistence = weighing_entry_persistence
  end

  def call(weight_in_kg)
    begin
      new_weighing_entry = Domain::WeighingEntry.new(
        date: Time.new(),
        weight_in_kg: weight_in_kg
      )
    rescue Errors::Error => error
      if error.has_tag?(:WeighingEntry) && error.has_tag?(:ConstructionFailure)
        raise Errors::Error.new(
          msg: error.msg,
          tags: [:ValidationError]
        )
      end

      raise error
    end

    @weighings.push(new_weighing_entry)

    @weighing_entry_persistence.store(@weighings)

    return @weighings
  end
end