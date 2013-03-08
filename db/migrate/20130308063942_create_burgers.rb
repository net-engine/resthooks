class CreateBurgers < ActiveRecord::Migration
  def change
    create_table :burgers do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
