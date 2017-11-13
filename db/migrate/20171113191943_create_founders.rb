class CreateFounders < ActiveRecord::Migration[5.1]
  def change
    create_table :founders do |t|
      t.integer :project_id, null: false, foreign_key: true
      t.references :member, polymorphic: true
      t.integer :role
      t.timestamps
    end
    add_index :founders, :member_id, unique: true
    add_index :founders, :member_type, unique: true
    add_index :founders, :project_id, unique: true
  end
end
