require 'date'
require 'json'

# Convert json file to ruby hash
json = JSON.parse(File.read("data/input.json"))

progress_records = []
json["progress_records"].each do |progress_record|

  objective = json["objectives"].detect {|o| o["id"] == progress_record["objective_id"] }

  # LEVEL_1 - Computing progress value
  ratio = (100.0 / (objective["target"] - objective["start"]))
  progress = ratio * ( progress_record["value"] - objective["start"])

  # LEVEL_2 - Computing excess value
  ratio = 100.0 / (Date.parse(objective["start_date"])...Date.parse(objective["end_date"])).count
  expected = ratio * (Date.parse(objective["start_date"])...Date.parse(progress_record["date"])).count
  excess = (progress - expected) / expected * 100

  progress_records << { id: progress_record["id"], excess: excess.round }
end

# Printing ruby hash in json format file
json = JSON.pretty_generate({ progress_records: progress_records })
File.write("data/output.json", "#{json}")
