RSpec.describe Infra::FsWeighingEntryPersistence do
  context "When storing and retrieving weighing entries" do
    def setup
      persistence = Infra::FsWeighingEntryPersistence.new(weighings_file_path: "./storage/weighings.test.json")

      weighing_entries = [
          Domain::WeighingEntry.new(
          id: "1",
          date: Time.new(),
          weight_in_kg: 57
        ),
          Domain::WeighingEntry.new(
          id: "2",
          date: Time.new(),
          weight_in_kg: 69
        ),
          Domain::WeighingEntry.new(
          id: "3",
          date: Time.new(),
          weight_in_kg: 12
        ),
          Domain::WeighingEntry.new(
          id: "4",
          date: Time.new(),
          weight_in_kg: 34.5
        )
      ]

      persistence.store(weighing_entries)

      retrieved_weighing_entries = persistence.retrieve()

      return {
        weighing_entries:,
        retrieved_weighing_entries:
      }
    end

    it "Retrieves the same weighing entries that were stored" do
      result = setup()
      retrieved_weghing_entries = result[:retrieved_weighing_entries]
      weighing_entries = result[:weighing_entries]

      expect(retrieved_weghing_entries).to eq(weighing_entries)
    end
  end
end