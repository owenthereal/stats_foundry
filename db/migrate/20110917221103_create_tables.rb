class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end

    add_index :tables, :user_id
  end
end
