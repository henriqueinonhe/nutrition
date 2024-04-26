RSpec.describe Infra::FsWeighingEntryPersistence do
  context "When storing and retrieving weighing entries" do
    def setup
      persistence = Infra::FsWeighingEntryPersistence.new(weighings_file_path: "./storage/weighings.test.json")

      weighing_entries = [
        TestUtils::WeighingEntryFactory.call(
          id: "1",
          weight_in_kg: 57
        ),
        TestUtils::WeighingEntryFactory.call(
          id: "2",
          weight_in_kg: 69
        ),
        TestUtils::WeighingEntryFactory.call(
          id: "3",
          weight_in_kg: 12
        ),
        TestUtils::WeighingEntryFactory.call(
          id: "4",
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