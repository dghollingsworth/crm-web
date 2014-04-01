require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

@@rolodex = Rolodex.new 

post '/contacts' do 
	@@rolodex.create_contact(params[:first_name], params[:last_name], params[:email], params[:notes])
	redirect to('/contacts')
end

get '/contacts' do 
	#@contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor")
	#@contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")
	#@contacts << Contact.new("Chris", "Johnston", "chris@bitmakerlabs.com", "Instructor")
	erb :contacts
end

get '/contacts/new' do

	erb :new_contact
end

get '/contacts/:id' do 
	# so it doesn't literally match contacts/:id
	# it actually matches something like: contacts/poop, contacts/3, etc
	# how do i access the value of :id?
end

get '/contacts/:id/edit' do 
	# /contacts/SOMETHING/edit
end

get '/' do 
	@crm_app_name = "My CRM"
	@title_name = "Main Menu"
	erb :index
end