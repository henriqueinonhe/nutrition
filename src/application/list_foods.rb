class Application::ListFoods
  def initialize(foods_hash:)
    @foods_hash = foods_hash
  end

  def call()
    return @foods_hash.to_a().map { |_, food| food }
  end
end