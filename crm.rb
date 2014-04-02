require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

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

get '/contacts/:id' do 
	# so it doesn't literally match contacts/:id
	# it actually matches something like: contacts/poop, contacts/3, etc
	# how do i access the value of :id?
end

get '/contacts/:id/edit' do 
	#/contacts/SOMETHING/edit
end

get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end