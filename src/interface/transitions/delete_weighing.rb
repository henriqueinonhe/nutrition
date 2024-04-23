class Interface::Transitions::DeleteWeighing
  def initialize(print_weighings:, delete_weighing:, weighings:)
    @print_weighings = print_weighings
    @delete_weighing = delete_weighing
    @weighings = weighings
  end

  def call(position)
    weighing_to_delete = @weighings[position - 1]

    entries = @delete_weighing.call(weighing_to_delete.id)

    @print_weighings.call(entries)

    return :WeighingMenu
  end
end