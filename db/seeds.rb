# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"
# 登録する初期データのみtrueに変更し、それ以外はfalseにすること
@is_exec_sub_category = true
@is_exec_category     = true

if @is_exec_sub_category
  # 全削除
  Sub_category.delete_all
  # idの自動インクリメントをリセット
  ActiveRecord::Base.connection.execute('ALTER TABLE sub_categories AUTO_INCREMENT = 1')
  CSV.foreach('db/insert_sub_categories_data.csv') do |info|
    Sub_category.create(:category2 => info[0], :categry_id => info[1], :color_code => info[2],  :disp_order => info[3], :is_open => '1' )
  end
end

if @is_exec_category
  # 全削除
  Category.delete_all
  # idの自動インクリメントをリセット
  ActiveRecord::Base.connection.execute('ALTER TABLE categories AUTO_INCREMENT = 1')
  CSV.foreach('db/insert_categories_data.csv') do |info|
    Category.create(:category1 => info[0], :disp_order => info[1], :is_open => '1' )
  end
end
