class Interface::Printers::PrintWeighings
  def initialize(writer:)
    @writer = writer
  end

  def call(entries)
    # TEMP
    index = 0

    entries.each do | (weighing, average) |
      @writer.write "#{index + 1}. #{weighing.date.strftime("%d/%m/%Y")} #{weighing.weight_in_kg}Kg #{format_average(average)}"

      index += 1 
    end

    @writer.write("\n")
  end

  private

  def format_average(average)
    return "#{average}Kg" if average

    return "N/A"
  end
end