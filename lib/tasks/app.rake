namespace :app do 
  task :get_data => :environment do
    sess = Patron::Session.new
    sess.timeout = 100000
    sess.base_url = "http://data.cityofnewyork.us"
    response = sess.get(URI.encode("/resource/erm2-nwe9.json?$where=created_date>'2012-01-01'AND created_date <'2012-11-12'"))
    content = JSON::parse(response.body)

    content.each do |row|
      # look into missing location
      if row["location"]
        Dataset.create(:unique_key => row["unique_key"],
                        :created_date => row["created_date"],
                        :complaint_type => row["complaint_type"],
                        :descriptor => row["descriptor"],
                        :location_type => row["location_type"],
                        :incident_zip => row["incident_zip"],
                        :incident_address => row["incident_address"],
                        :street_name => row["street_name"],
                        :cross_street_1 => row["cross_street_1"],
                        :cross_street_2 => row["cross_street_2"],
                        :city => row["city"],
                        :latitude => row["location"]["latitude"].to_f,
                        :longitude => row["location"]["longitude"].to_f)
      end
    end
  end
end