class CreateColumns < ActiveRecord::Migration
  def change
    create_table :columns do |t|
      t.string :name
      t.string :type
      t.integer :table_id

      t.timestamps
    end

    add_index :columns, :table_id
    add_index :columns, [:id, :name]
  end
end
