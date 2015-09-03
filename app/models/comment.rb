class Comment < ActiveRecord::Base
  belongs_to :todo
  has_one :followup, dependent: :destroy
end
