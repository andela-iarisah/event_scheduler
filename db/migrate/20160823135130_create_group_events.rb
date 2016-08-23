class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.string :name
      t.text :description
      t.string :location

      t.timestamps null: false
    end
  end
end
