class CreateResourceSubscriptions < ActiveRecord::Migration
  def change
    create_table :resource_subscriptions do |t|
      t.references :user, index: true
      t.string :post_url
      t.integer :version
      t.string :resource

      t.timestamps
    end
  end
end
