require_relative 'rolodex'
require 'sinatra'
require 'data_mapper'

Datamapper.setup(:default, "sqlite3:database.sqlite3")


@@rolodex = Rolodex.new

@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))


class
  include Datamapper::Resource

  property :id, Serial
  property :first_name, String,
  property :last_name, String,
  property :email, String
  property :note, String

  Datamapper.finalize
  Datamapper.auto_upgrade!


end



get '/' do 
	@crm_app_name = "Compu-Global-Hyper-Mega-Net"
	erb :index
end

get '/contacts' do
	erb :contacts
end

get  '/contacts/new' do
	erb :new_contact
end

get '/contacts/delete' do
  erb :delete_contact
end

get '/contacts/modify' do
  erb :modify_contact
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  @@rolodex.add_contact(new_contact)
  redirect to('/contacts')
end

get "/contacts/1000" do
  @contact = @@rolodex.find(1000)
  erb :show_contact
end

get "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/modify_contact" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :modify_contact
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
    @contact.note = params[:note]

    redirect to("/contacts")
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
    @contact.note = params[:note]

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @@rolodex.remove_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end