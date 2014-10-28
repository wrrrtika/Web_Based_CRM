require 'sinatra'
require_relative 'contact'
require_relative 'rolodex'

$rolodex = Rolodex.new

get '/' do 
	@crm_app_name = "MY CRM"
	erb :index
end

gets '/contacts' do
	erb :contacts
end

get  '/contacts/new'
	erb :