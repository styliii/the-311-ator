class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.integer :unique_key
      t.datetime :created_date
      t.string :complaint_type
      t.string :descriptor
      t.string :location_type
      t.string :incident_zip
      t.string :incident_address
      t.string :street_name
      t.string :cross_street_1
      t.string :cross_street_2
      t.string :city
      t.float :lattitude
      t.float :longitude
      t.timestamps
    end
  end
end
