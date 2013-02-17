require 'digest/sha1'
class Subject < ActiveRecord::Base
	attr_accessor :password
	attr_protected :hashed_password, :salt

	before_save :create_hashed_password
	after_save :clear_password

	def self.hash_with_salt(password="", salt="")
		Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
	end
	def self.make_salt(name="")
		Digest::SHA1.hexdigest("use #{name} with #{Time.now} to make salt")
	end

	def self.authenticate(name="", password="")
		subject = Subject.find_by_name(name)
		if subject && subject.password_match?(password)
			return subject
		else
			return false
		end
	end

	def password_match?(password="")
		hashed_password == Subject.hash_with_salt(password, salt)
	end

	private #can only be called by the class
	def create_hashed_password
		#whenever :password has a value hashing is needed
		unless password.blank?
			self.salt = Subject.make_salt(name) if salt.blank?
			self.hashed_password = Subject.hash_with_salt(password, salt)
		end
	end
	def clear_password
		self.password = nil
	end

end
