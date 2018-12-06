class CreateFields < ActiveRecord::Migration[5.2]
  def change
    create_table :fields do |t|
      t.integer    :user_id, null: false
      t.integer    :user_id_seq, null: false
      t.string     :color_code, limit: 30, null: false
      t.string     :category1, limit: 100
      t.string     :category2, limit: 100
      t.integer    :is_available, null: false
      t.integer    :disp_order
      t.timestamps
    end
  end
end
