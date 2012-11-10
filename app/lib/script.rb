# string = steve_file
string = File.open("app/lib/data.txt")

content = string.read
new_content = JSON::parse(content)

new_content["data"].each do |row|
  Dataset.create(:unique_key => row[0],
                      :created_date => row[9],
                      :complaint_type => row[13],
                      :descriptor => row[14],
                      :location_type => row[15],
                      :incident_zip => row[16],
                      :incident_address => row[17],
                      :street_name => row[18],
                      :cross_street_1 => row[19],
                      :cross_street_2 => row[20],
                      :city => row[31],
                      :lattitude => row[57].to_f,
                      :longitude => row[58].to_f)
end


Dataset.all.each do |data|
  data.latitude = data.lattitude
  data.save
end
