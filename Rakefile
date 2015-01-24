require 'csv'
require_relative 'app/db'
require_relative 'app/models/bookmark'

desc 'bookmark to csv'
task :csv do |t|
  DB.connect(
    __dir__,ENV['RACK_ENV'] || 'development')

  csv_path =
    File.join(__dir__,'bookmark.csv')
  CSV.open(csv_path, 'wb') do |csv|
  # CSVのヘッダ行を削除
  csv << Bookmark.attribute_names 

  # ActiveRecordのfind_eachメソッドを使って、
  # 一度に全件を取得するのではなく、
  # 1,000件(デフォルト)ずつ取得する
  Bookmark.find_each do |bookmark|
    csv << bookmark.attributes.values
  end
end

  DB.close
  puts "generate csv => #{csv_path}"
end
