require "json"

Dir.mkdir("storage")

file = File.open("./storage/weighings.json", "w")

file.write([].to_json)

file.close()