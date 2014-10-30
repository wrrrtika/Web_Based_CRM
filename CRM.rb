require_relative 'contact'
require_relative 'rolodex'
require 'sinatra'


# $rolodex = Rolodex.new

@@rolodex = Rolodex.new

@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))


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

# get "/contacts" do
#   @contacts = []
#   @contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor")
#   @contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")
#   @contacts << Contact.new("Chris", "Johnston", "chris@bitmakerlabs.com", "Instructor")
# 	erb :contacts
# end

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