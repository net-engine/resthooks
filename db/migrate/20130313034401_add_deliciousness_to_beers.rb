class AddDeliciousnessToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :deliciousness, :integer
  end
end
