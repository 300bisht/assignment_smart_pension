# frozen_string_literal: true

class Print
  VIEWS_TEXT = { visits: 'Most page views', unique_views: 'Unique page views' }.freeze
  def initialize(result)
    @result = result
  end

  def data
    @result.each do |k, data|
      a = "<<#{VIEWS_TEXT[k]}<<"
      File.write('log.txt', a, mode: 'a')
      puts a
      data.each do |page, count|
        b = " #{page} | #{count} | #{k}"
        File.write('log.txt', b, mode: 'a')
        puts b
      end
    end
  end
end
