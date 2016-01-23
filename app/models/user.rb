class User < ActiveRecord::Base
	before_save { self.email=email.downcase! }
	befor_create :crete_remember_token
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true,
					  format: {with: VALID_EMAIL_REGEX},
					  uniqueness: {case_sensitive: false }
	has_secure_password
	validates :password, length: {minimum: 5}
	validates :password_confirmation, presence: true

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token)
	end

	private

	def crete_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end
end
