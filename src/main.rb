require "./src/interface/CommandLineInterface"
require "./src/interface/InterfaceReader"
require "./src/interface/InterfaceWriter"

CommandLineInterface.new(
  reader: InterfaceReader,
  writer: InterfaceWriter
).start



