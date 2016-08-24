class AddPublishedToGroupEvents < ActiveRecord::Migration
  def change
    add_column :group_events, :published, :boolean, default: false
  end
end
