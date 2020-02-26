require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require './models/user'
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "mydb.db")


get '/' do 
    @users = User.all
    erb :user_list
end 

get '/new' do 
    erb :user_form
end 

get '/remove' do 
    erb :user_delete
end 

post '/create' do 
    user = User.new
    user.name = params[:name]
    user.email = params[:email]
    user.save
    "User created. ID: #{user.id} Name: #{user.name} Email #{user.email}"
end 

post '/delete' do
    user = User.find_by(name: params[:name])
    if !user.nil?
        user.destroy
        "User #{params[:name]} deleted"
    else 
        "User #{params[:name]} not found"
    end 
end