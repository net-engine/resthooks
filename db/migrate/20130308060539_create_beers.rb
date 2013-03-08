class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
