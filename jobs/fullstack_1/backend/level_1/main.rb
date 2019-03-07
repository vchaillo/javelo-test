require 'json'

# Convert json file to ruby hash
json = JSON.parse(File.read("data/input.json"))

progress_records = []
json["progress_records"].each do |progress_record|

  objective = json["objectives"].detect {|o| o["id"] == progress_record["objective_id"] }

  # Computing progress value
  ratio = (100.0 / (objective["target"] - objective["start"]))
  progress = (ratio * ( progress_record["value"] - objective["start"])).round

  progress_records << { id: progress_record["id"], progress: progress }
end

# Printing ruby hash in json format file
json = JSON.pretty_generate({ progress_records: progress_records })
File.write("data/output.json", "#{json}")
