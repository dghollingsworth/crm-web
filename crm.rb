require_relative 'rolodex'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")


class Contact
	
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :notes, String

end

DataMapper.finalize
DataMapper.auto_upgrade!

@@message = ""
@@rolodex = Rolodex.new 



#This is the Contact Form
get '/contacts/new' do
	#add new contacts form
	erb :new_contact
end

######this one is a post to
post '/contacts' do 
	#POST TO the contacts page with info from the 'create_contact method' form on contacts/new
	contact = Contact.create(
		:first_name=> params[:first_name],
		:last_name=> params[:last_name],
		:email=> params[:email],
		:notes=>params[:notes]
	)
	redirect to('/contacts')
end

get '/contacts' do
	@contacts = Contact.all
	erb :contacts
end


#####go to edit contact form#####
get '/contacts/:id/edit' do 
	#/contacts/SOMETHING/edit
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :edit
	else
		raise Sinatra::NotFound
	end
end

get '/find' do 
	@found_contacts = []
	@@message = ""
	if params[:last_name]
		# find the matching contacts, if any (could be many)
		@contact = Contact.each do |contact| 
			if contact.last_name==params[:last_name] 
				@found_contacts << contact
			else
				@@message = "Sorry...nothing found"
			end
		end
	end
	erb :find
end

delete "/contacts/:id" do 
	@@message = ""
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		@@rolodex.delete_contact(@contact)
		@@message = "Contact Deleted"
		redirect to("/delete")
	else
		raise Sinatra::NotFound
	end
end

get "/delete" do
	@message = "Contact Deleted" 
	erb :delete
end

put "/contacts/:id" do 
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.notes = params[:notes]

		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end



get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end






