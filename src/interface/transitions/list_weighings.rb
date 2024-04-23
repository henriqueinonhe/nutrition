class Interface::Transitions::ListWeighings
  def initialize(writer:, list_weighings:)
    @writer = writer
    @list_weighings = list_weighings
  end

  def call(*)
    @writer.write "Weighings:\n\n"

    entries = @list_weighings.call()

    entries.each do | (weighing, average) |
      @writer.write "#{weighing.date.strftime("%d/%m/%Y")} #{weighing.weight_in_kg}Kg #{format_average(average)}"
    end

    @writer.write("\n")

    return :WeighingMenu
  end

  private

  def format_average(average)
    return "#{average}Kg" if average

    return "N/A"
  end
end