require 'json'

sess = Patron::Session.new
sess.timeout = 100000
sess.base_url = "http://data.cityofnewyork.us"

response = sess.get("/api/views/erm2-nwe9/rows.json?max_rows=500")
# Check our response code
if response.code != "200"
  raise "Error querying \"#{uri.to_s}\": #{response.body}"
else
  # Return a bunch of mashes
  new_content = JSON::parse(response.body)

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
                        :latitude => row[57].to_f,
                        :longitude => row[58].to_f)
  end
end


