class Interface::Transitions::AddWeighing
  def initialize(writer:, weighings:, app_add_weighing:)
    @writer = writer
    @weighings = weighings
    @app_add_weighing = app_add_weighing
  end

  def call(weight_in_kg)
    begin
      updated_weighings = @app_add_weighing.call(weight_in_kg)
    rescue Errors::Error => error
      if error.has_tag?(:ValidationError)
        @writer.write("Invalid weight!\n\n")

        return :AddWeighing
      end

      raise error
    end

    @writer.write "Weighings:\n\n"

    @weighings.each do | weighing |
      @writer.write "#{weighing.date} #{weighing.weight_in_kg}Kg"
    end

    @writer.write("\n")

    return :WeighingMenu
  end
end