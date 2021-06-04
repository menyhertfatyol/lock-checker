class CreateDoorlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :doorlocks do |t|
      t.string :state

      t.timestamps
    end
  end
end
