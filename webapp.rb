require 'sinatra'
require 'rubygems'
require 'data_mapper'
DB_HOST=ENV['DB_HOST'] || "localhost"
DB_PASS=ENV['DB_PASS'] || "password"
DB_USER=ENV['DB_USER'] || "root"

DataMapper::setup(:default, "mysql://#{DB_USER}:#{DB_PASS}@#{DB_HOST}/list")

class Item
	include DataMapper::Resource
	  
	property :id,	Serial
	property :task, Text, :required => true
	property :done, Boolean, :default => false, :required => true
	property :created, DateTime
end
Item.auto_upgrade!
DataMapper.finalize

class Webapp < Sinatra::Base

get '/' do
  @item = Item.all(:order => :created.desc)
  redirect '/new' if @item.empty?
  erb :index
end

get '/new' do
  @title = "Add todo item"
  erb :new
end

post '/new' do
  Item.create(:task => params[:task], :done => params[:done], :created => Time.now)
  redirect '/'
end

get '/delete/:id' do
  @item = Item.first(:id => params[:id])
  erb :delete
end

post '/delete/:id' do
  if params.has_key?("ok")
    item = Item.first(:id => params[:id])
    item.destroy
    redirect '/'
  else
    redirect '/'
  end
end

post '/item/:id' do
  item = Item.first(:id => params[:id])
  item.done = !item.done
  item.save
  redirect '/'
end

end
