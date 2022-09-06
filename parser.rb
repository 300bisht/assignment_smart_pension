# frozen_string_literal: true

require_relative 'file_parser'
require_relative 'print'

filename = ARGV[0]
parser = FileParser.new(filename)
parser.process_file
result = { visits: parser.most_page_views, unique_views: parser.unique_page_views }
p = Print.new(result)
p.data
