class Project < ActiveRecord::Base
	validates :slug, presence: true, uniqueness: { case_sensitive: false }
	before_validation :create_slug
	belongs_to :user
	has_many :todos

	def to_param
		slug
	end

private
		def create_slug
			self.slug = name.titleize.parameterize
		end

end