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
  memos = all
  @title = memos[params[:id]]['title']
  @content = memos[params[:id]]['content']
  @page_title = 'Show page'
  erb :show
end

post '/memos' do
  title = params[:title]
  content = params[:content]

  memos = all
  id = (memos.keys.map(&:to_i).max + 1).to_s
  memos[id] = { 'title' => title, 'content' => content }
  create(memos)

  redirect '/memos'
end

get '/memos/:id/edit' do
  memos = all
  @title = memos[params[:id]]['title']
  @content = memos[params[:id]]['content']
  @page_title = 'Edit page'
  erb :edit
end

patch '/memos/:id' do
  title = params[:title]
  content = params[:content]

  memos = all
  memos[params[:id]] = { 'title' => title, 'content' => content }
  create(memos)

  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  memos = all
  memos.delete(params[:id])
  create(memos)

  redirect '/memos'
end
not_found do
  'This is nowhere to be found'
end
