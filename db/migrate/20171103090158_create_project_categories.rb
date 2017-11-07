class CreateProjectCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :project_categories do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps
      t.index :name, unique: true
    end
  end
end
