require 'sinatra'
require 'rubygems'
require 'data_mapper'


DataMapper::setup(:default, 'mysql://root@localhost/list')

class Item
	include DataMapper::Resource
	  
	property :id,	Serial
	property :task, Text, :required => true
	property :done, Boolean, :default => false, :required => true
	property :created, DateTime
end
Item.auto_upgrade!
DataMapper.finalize


get '/' do
  @items = Item.all(:order => :created.desc)
  redirect '/new' if @items.empty?
  erb :index
end

get '/new' do
  @title = "Add todo item"
  erb :new
end

post '/new' do
  Item.create(:task => params[:task], :created => Time.now)
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

