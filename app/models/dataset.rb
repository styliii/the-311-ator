class Dataset < ActiveRecord::Base
# require '../lib/soda_extension.rb'
require 'SODA'
acts_as_gmappable

  # attr_accessible :title, :body

  def gmaps4rails_address
    "#{self.street_name}, #{self.city}, USA"
  end


  def self.get_all(url)
    @client = SODA::Client.new(:url => url)
    @client.get
  end

    def gmaps4rails_infowindow
      "#{self.incident_address} </br>
      #{self.descriptor}"
    end

    def gmaps4rails_title
      self.descriptor
    end
end
