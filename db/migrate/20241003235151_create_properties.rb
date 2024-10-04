class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :address
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
