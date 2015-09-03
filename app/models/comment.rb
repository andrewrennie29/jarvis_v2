class Comment < ActiveRecord::Base
  belongs_to :todo
  has_one :followup
end
