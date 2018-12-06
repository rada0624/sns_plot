class Color < ApplicationRecord
  # has_many :fields
  self.primary_key = 'color_code'
  has_many :fields, :class_name => :Field, foreign_key: 'color_code'


end
