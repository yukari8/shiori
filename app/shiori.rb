require 'sinatra/base'
require 'active_record'
require 'will_paginate'
require_relative 'models/bookmark'
require_relative 'db'

class Shiori < Sinatra::Base
  register WillPaginate::Sinatra

  set :public_folder, File.expand_path(File.join(root, '..', 'public'))

  #Vuewで使用するヘルパーメソッド群
  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end

  configure do
    DB.connect(
      File.expand_path(File.join(root, '..')),
      ENV['RACK_ENV'])   
    end

  get '/' do
    @bookmarks = Bookmark.order(
      'id DESC').page(params[:page])
    erb :index
  end
  
  get '/new' do
    erb :new
  end

  post '/create' do
    begin
      # データを保存できた場合は
      # '/'へリダイレクト
      Bookmark.create!(url: params[:url]) 
      redirect '/'
    rescue ActiveRecord::RecordInvalid => e
      # データの保存に失敗したら
      # 再度描画画面を描画
      @bookmark = e.record
      erb :new
    end
  end
  
end
