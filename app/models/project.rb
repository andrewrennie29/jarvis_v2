class Project < ActiveRecord::Base
	validates :slug, presence: true, uniqueness: { case_sensitive: false }
	before_validation :create_slug
	belongs_to :user
	has_many :todos, dependent: :destroy

	def to_param
		slug
	end

	def update_slug
		
	end	

private
	def create_slug
		self.slug = [user_id, name.parameterize].join("-")
	end

end