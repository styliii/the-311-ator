class Changecolumnname < ActiveRecord::Migration
  def up
    add_column :datasets, :latitude, :float
  end

  def down
  end
end
