class Contact
	@@counter = 1000

	attr_accessor :notes, :first_name, :last_name, :email, :id

	def initialize(first, last, email, notes)
		@id = Contact.get_id
		@first_name = first
		@last_name = last
		@email = email
		@notes = notes
	end

	def to_s
		"ID: #{@id}\nFirst Name: #{@first_name.capitalize}\nLast Name: #{@last_name.capitalize}\nEmail: #{@email}\nNotes: #{@notes}\n********"
	end

	def self.get_id
		@@counter += 1
		@@counter
	end
end

