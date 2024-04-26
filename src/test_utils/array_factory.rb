module TestUtils::ArrayFactory
  def self.call(factory, length)
    Array.new(length) { factory.call }
  end
end