class CreateUserPlugins < ActiveRecord::Migration
  def change
    create_table :user_plugins do |t|
      t.integer :user_id,     null: false
      t.integer :plugin_id,   null: false
      t.datetime :deleted_at, default: nil

      t.timestamps
    end
    add_index :user_plugins, [:user_id, :plugin_id], name: "index_user_id_x_plugin_id", unique: true
  end
end
