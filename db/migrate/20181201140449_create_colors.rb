class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.string     :color_code, limit: 30, null: false
      t.string     :color_name, limit: 100, null: false
      t.integer    :is_available, null: false
      t.timestamps
    end
  end
end
