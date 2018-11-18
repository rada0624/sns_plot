class CreateSubCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_categories do |t|
      t.integer    :categry_id
      t.string     :category2, limit: 100, null: false
      t.string     :color_code, limit: 30, null: false
      t.integer    :is_open, null: false
      t.integer    :disp_order
      t.timestamps
    end
  end
end
