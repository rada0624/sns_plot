class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table   :categories do |t|
      t.string     :category1, limit: 100, null: false
      t.integer    :is_open, null: false
      t.integer    :disp_order
      t.timestamps
    end
  end
end
