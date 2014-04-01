require_relative 'contact'
require 'sinatra'

get '/contacts' do 
	@contacts_title = "Contacts"
	erb :contacts
end

get '/contacts/new' do

end

get '/contacts/:id' do 
	# so it doesn't literally match contacts/:id
	# it actually matches something like: contacts/poop, contacts/3, etc


	# how do i access the value of :id?
	"hello #{params[:name]}!"
end

get '/contacts/:id/edit' do 
	# /contacts/SOMETHING/edit
end

get '/' do 
	@crm_app_name = "My CRM"
	@title_name = "Main Menu"
	erb :index
end