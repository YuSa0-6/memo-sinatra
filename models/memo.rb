# frozen_string_literal: true

require 'json'
require 'sinatra/reloader' if development?
FILE_PATH = 'public/data.json'

def all
  File.open(FILE_PATH) { |file| JSON.parse(file.read) }
end

def save(memos)
  File.open(FILE_PATH, 'w') { |file| JSON.dump(memos, file) }
end
