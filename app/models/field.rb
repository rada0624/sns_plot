class Field < ApplicationRecord
  belongs_to :colors, :class_name => :Color, foreign_key: 'color_code', optional: true
end
