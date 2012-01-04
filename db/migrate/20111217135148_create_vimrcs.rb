class CreateVimrcs < ActiveRecord::Migration
  def change
    create_table :vimrcs do |t|
      t.references :user
      t.string     :url
      t.timestamps
    end
  end
end
