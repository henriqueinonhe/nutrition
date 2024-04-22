require "json"
require "./src/domain/WeighingEntry"

module FsWeighingEntryPersistence
  WEIGHINGS_PATH = ENV["ENV"] == "test" ? "./storage/weighings.test.json" : "./storage/weighings.json"

  def self.store(entries)
    file = File.open(WEIGHINGS_PATH, "w")

    file.write(entries.map { |entry| entry.to_h }.to_json)

    file.close()
  end

  def self.retrieve()
    file = File.open(WEIGHINGS_PATH, "r")

    list = JSON.parse(file.read(), {symbolize_names: true})

    file.close()

    list.map { |serialized_entry| 
      WeighingEntry.new(
        date: Time.new(serialized_entry[:date]),
        weight_in_kg: serialized_entry[:weight_in_kg]
      ) 
    }
  end
end