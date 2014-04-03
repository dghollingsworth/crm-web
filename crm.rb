require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'
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
	@@rolodex.create_contact(params[:first_name], params[:last_name], params[:email], params[:notes])
	redirect to('/contacts')
end

get '/contacts' do
	#get to/link to the contacts page 
	#show all contacts
	erb :contacts
end

#######Show specified contact
get '/contacts/:id' do 
	@contact = @@rolodex.find(params[:id].to_i)	
	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end
end

#####go to edit contact form#####
get '/contacts/:id/edit' do 
	#/contacts/SOMETHING/edit
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		erb :edit
	else
		raise Sinatra::NotFound
	end
end

get '/find' do 
	@found_contacts = []
	
	if params[:last_name]
		# find the matching contacts, if any (could be many)
		@@rolodex.contacts.each do |contact| 
			if contact.last_name==params[:last_name] 
				@found_contacts << contact
			else
				"Sorry...None Found"
			end
		end
	end
	erb :find
end

delete "/contacts/:id" do 
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		@@rolodex.delete_contact(@contact)
		@@message = "Contact Deleted"
		redirect to("/find")
	else
		raise Sinatra::NotFound
	end
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






