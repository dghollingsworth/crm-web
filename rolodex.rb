class Rolodex

	attr_accessor :contacts

	def initialize
		@contacts = []
	end

	def create_contact(first_name, last_name, email, notes)
		contact = Contact.new
		contact.first_name = first_name
		contact.last_name = last_name
		contact.email = email
		contact.notes = notes+"\n"
		@contacts << contact
	end

	
end