# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require 'cgi'
require_relative 'models/memo'

get '/' do
  redirect '/memos'
end

get '/memos' do
  @memos = all
  @page_title = 'Top page'
  erb :top
end

get '/memos/new' do
  @page_title = 'New page'
  erb :new
end

get '/memos/:id' do
  memo = show(params[:id])
  @title = memo[:title]
  @content = memo[:content]
  @page_title = 'Show page'
  erb :show
end

post '/memos' do
  title = params[:title]
  content = params[:content]
  create(title, content)
  redirect '/memos'
end

get '/memos/:id/edit' do
  memo = show(params[:id])
  @title = memo[:title]
  @content = memo[:content]
  @page_title = 'Edit page'
  erb :edit
end

patch '/memos/:id' do
  title = params[:title]
  content = params[:content]
  update(title, content, params[:id])
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  delete(params[:id])
  redirect '/memos'
end

not_found do
  'This is nowhere to be found'
end
