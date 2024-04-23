require "zeitwerk"
require "json"

loader = Zeitwerk::Loader.new
loader.push_dir("#{Dir.pwd}/src")
loader.ignore("#{Dir.pwd}/src/**/*.spec.rb")
loader.setup

# App

weighings = Application::RetrieveWeighingEntries.call()

reader = Interface::StdinReader
writer = Interface::StdoutWriter

initial_ui = Interface::Ui::Initial.new()
weighing_menu_ui = Interface::Ui::WeighingMenu.new()
add_weighing_menu_ui = Interface::Ui::AddWeighingMenu.new()

app_add_weighing = Application::AddWeighing.new(weighings:)

exit_transition = Interface::Transitions::Exit.new(writer:)
list_weighings_transition = Interface::Transitions::ListWeighings.new(writer:, weighings:)
add_weighing_transition = Interface::Transitions::AddWeighing.new(writer:, weighings:, app_add_weighing:)

Interface::CommandLine.new(
  reader:,
  writer:,
  initial_ui:,
  weighing_menu_ui:,
  add_weighing_menu_ui:,
  app_add_weighing:,
  exit_transition:,
  list_weighings_transition:,
  add_weighing_transition:
).start



