class AddDeliciousnessToBurgers < ActiveRecord::Migration
  def change
    add_column :burgers, :deliciousness, :integer
  end
end
