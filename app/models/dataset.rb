class Dataset < ActiveRecord::Base

acts_as_gmappable

  def gmaps4rails_address
    "#{self.street_name}, #{self.city}, USA"
  end

  def gmaps4rails_infowindow
    "#{self.incident_address} </br>
    #{self.descriptor}"
  end

  def gmaps4rails_title
    self.descriptor
  end
end
