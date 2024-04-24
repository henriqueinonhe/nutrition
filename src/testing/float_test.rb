module FloatTest
  def self.epsilon_equals(a, b, epsilon)
    (a - b).abs < epsilon
  end
end