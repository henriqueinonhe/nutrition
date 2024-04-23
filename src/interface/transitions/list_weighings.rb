class Interface::Transitions::ListWeighings
  def initialize(writer:, weighings:)
    @writer = writer
    @weighings = weighings
  end

  def call(*)
    @writer.write "Weighings:\n\n"

    @weighings.each do | weighing |
      @writer.write "#{weighing.date} #{weighing.weight_in_kg}Kg"
    end

    @writer.write("\n")

    return :WeighingMenu
  end
end