class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.datetime :start_on
      t.datetime :end_on
      t.string :name
      t.text :description
      t.string :location
      t.references :user

      t.timestamps null: false
    end
  end
end
