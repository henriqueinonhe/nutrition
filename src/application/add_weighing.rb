# frozen_string_literal: true

class Application::AddWeighing
  def initialize(weighings:, weighing_entry_persistence:)
    @weighings = weighings
    @weighing_entry_persistence = weighing_entry_persistence
  end

  def call(weight_in_kg)
    begin
      new_weighing_entry = Domain::WeighingEntry.new(
        id: Random.uuid,
        date: Time.new,
        weight_in_kg:
      )
    rescue Errors::Error => e
      if e.has_tag?(:WeighingEntry) && e.has_tag?(:ConstructionFailure)
        raise Errors::Error.new(
          msg: e.msg,
          tags: [:ValidationError]
        )
      end

      raise e
    end

    @weighings.push(new_weighing_entry)

    @weighing_entry_persistence.store(@weighings)

    @weighings.zip(Domain::ComputeWeighingAverages.call(@weighings))
  end
end
