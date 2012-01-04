class CreateGitmodules < ActiveRecord::Migration
  def change
    create_table :gitmodules do |t|
      t.references :user
      t.string     :url
      t.timestamps
    end
  end
end
