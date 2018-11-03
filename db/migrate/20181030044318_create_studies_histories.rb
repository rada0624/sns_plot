class CreateStudiesHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :studies_histories do |t|

      t.string :users_id
      t.integer :users_id_seq
      t.string :color_code, limit:100
      t.string :category1, limit: 100
      t.string :category2, limit: 100
      t.text :content
      t.integer :is_open, null: false
      # t.timestampsでcreated_at/update_atが作成される
      t.timestamps null: false
    end
  end
end
