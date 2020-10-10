class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name, limit: 100, null: false
      t.text :description
      t.boolean :done, default: false
      t.datetime :deadline

      t.timestamps
    end
  end
end
