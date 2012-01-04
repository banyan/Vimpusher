class CreatePlugins < ActiveRecord::Migration
  def change
    create_table :plugins do |t|
      t.string     :url
      t.integer    :group_id
      t.timestamps
    end
  end
end
