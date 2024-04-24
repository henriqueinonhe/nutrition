Test.test {
  weights = [
    68.3,
    67,
    67.8,
    68,
    69,
    72,
    71.3,
    71.5
  ]

  weighings = weights.map do |weight|
    Domain::WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: weight
    )
  end

  expected_averages = [
    nil,
    nil,
    nil,
    nil,
    68.02,
    68.76,
    69.62,
    70.36
  ]

  actual_averages = Domain::ComputeWeighingAverages.call(weighings)

  Assertions.check {
    actual_averages.length == expected_averages.length
  }

  zipped_averages = expected_averages.zip(actual_averages)

  epsilon = 0.1

  Assertions.check {
    zipped_averages.all? { |expected, actual| ((expected || 0) - (actual || 0)).abs() < epsilon }
  }
}