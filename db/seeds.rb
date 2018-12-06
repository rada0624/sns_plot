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
@is_exec_sub_category = false
@is_exec_category     = true
@is_exic_color        = false
@is_exic_field        = false

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
  # 現在の行数(1行目はスキップする)
  @category_index = 0
  CSV.foreach('db/insert_categories_data.csv') do |info|
    if @category_index > 0
      Category.create(:category1 => info[0], :disp_order => info[1], :is_open => '1' )
    end
    @category_index = @category_index + 1
  end
end

if @is_exic_color
  # 全削除
  Color.delete_all
  # idの自動インクリメントをリセット
  ActiveRecord::Base.connection.execute('ALTER TABLE colors AUTO_INCREMENT = 1')
  CSV.foreach('db/insert_colors_data.csv') do |info|
    if info[2].to_i.eql?1
    Color.create(:color_name => info[0], :color_code => info[1], :is_available => '1' )
    end
  end
end

if @is_exic_field

  # 全削除
  Field.delete_all
  # idの自動インクリメントをリセット
  ActiveRecord::Base.connection.execute('ALTER TABLE fields AUTO_INCREMENT = 1')
  # シーケンスの増分
  @user_id_seq = 1
  CSV.foreach('db/insert_fields_data.csv') do |info|
    if info[2].to_i.eql?1
    Field.create(:user_id => 1, :user_id_seq => @user_id_seq , :color_code => info[1], :is_available => '1', :category1 => info[3], :category2 => info[4])
    @user_id_seq = @user_id_seq + 1
    end
  end
end
