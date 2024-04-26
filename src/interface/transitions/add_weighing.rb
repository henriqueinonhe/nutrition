# frozen_string_literal: true

class Interface::Transitions::AddWeighing
  def initialize(writer:, weighings:, app_add_weighing:, print_weighings:)
    @writer = writer
    @weighings = weighings
    @app_add_weighing = app_add_weighing
    @print_weighings = print_weighings
  end

  def call(weight_in_kg)
    begin
      entries = @app_add_weighing.call(weight_in_kg)
    rescue Errors::Error => e
      if e.has_tag?(:ValidationError)
        @writer.write("Invalid weight!\n\n")

        return :AddWeighing
      end

      raise e
    end

    @writer.write "Weighings:\n\n"

    @print_weighings.call(entries)

    :WeighingMenu
  end
end
