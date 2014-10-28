require 'sinatra'

get '/' do 
	@crm_app_name = "MY CRM"
	erb :index
end