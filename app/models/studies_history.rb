class Studies_history < ApplicationRecord

  self.primary_key = 'id'
  belongs_to :users, :class_name => :User, foreign_key: 'users_id', optional: true

end
