# frozen_string_literal: true

require 'json'
require 'sinatra/reloader' if development?
require 'pg'

def connection
  @connection ||= PG.connect(dbname: 'memosdb')
end

configure do
  result = connection.exec("SELECT * FROM information_schema.tables WHERE table_name = 'memos'")
  connection.exec('CREATE TABLE memos (id serial, title varchar(255), content text)') if result.values.empty?
end

def all
  connection.exec('SELECT * FROM memos')
end

def show(id)
  result = connection.exec_params('SELECT * FROM memos WHERE id = $1;', [id])
  result.tuple_values(0)
end

def save(title, content)
  connection.exec_params('INSERT INTO memos(title, content) VALUES ($1, $2);', [title, content])
end
