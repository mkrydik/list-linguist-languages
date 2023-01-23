#!/usr/bin/env ruby

require 'open-uri'
require 'pathname'
require 'yaml'

languages_yaml_file_name = 'languages.yml'
languages_yaml_uri       = 'https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml'
languages_txt_file_name  = 'languages.txt'

languages_yaml_file_path = Pathname.new('./').join(languages_yaml_file_name)
languages_txt_file_path  = Pathname.new('./').join(languages_txt_file_name)

puts '+-----------------------------+'
puts '|   List Linguist Languages   |'
puts '+-----------------------------+'

puts ''
if File.file?(languages_yaml_file_path)
  puts "#{languages_yaml_file_name} ファイルが存在します・ダウンロードせずに続行します"
else
  puts "#{languages_yaml_file_name} ファイルが存在しません・ダウンロードします"
  languages_yaml_response = URI.open(languages_yaml_uri)
  File.write(languages_yaml_file_path, languages_yaml_response.read)
  puts "#{languages_yaml_file_name} ファイルのダウンロード・保存完了"
end

raw_languages = YAML.load_file(languages_yaml_file_path)
languages = raw_languages.keys

puts ''
puts "========== #{languages.length} Languages =========="
puts languages
puts "---------- #{languages.length} Languages ----------"

File.write(languages_txt_file_path, "#{languages.join("\n")}\n")

puts ''
puts 'Finished'
