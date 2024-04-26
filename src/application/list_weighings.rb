# frozen_string_literal: true

class Application::ListWeighings
  def initialize(weighings:)
    @weighings = weighings
  end

  def call
    @weighings.zip(Domain::ComputeWeighingAverages.call(@weighings))
  end
end
