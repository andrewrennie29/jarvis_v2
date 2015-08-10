class User < ActiveRecord::Base
	has_many :projects
	has_many :todos, through: :projects
	attr_accessor :password
	validates_confirmation_of :password
	before_save :encrypt_password

	def encrypt_password

	  unless password.nil?

	    self.password_salt = BCrypt::Engine.generate_salt
	    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)

	  end

	end

	def self.authenticate(username, password)

		user = User.where(username: username).first

		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)

			user

		else

			nil

		end

	end

end
