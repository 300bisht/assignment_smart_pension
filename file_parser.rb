# frozen_string_literal: true

class FileParser
  attr_reader :records

  def initialize(file_name)
    file_exists?(file_name)

    @file_name = file_name
    @records = Hash.new { |h, k| h[k] = [] }
  end

  def process_file
    return @records if @records.any?

    File.open(@file_name).each do |line|
      page, ip_address = line.split
      @records[page] << ip_address
    end
    @records
  end

  def most_page_views
    @most_page_views ||= get_sorted_record(caculate_view_count(false)).to_h
  end

  def unique_page_views
    @unique_page_views ||= get_sorted_record(caculate_view_count(true)).to_h
  end

  private

  def file_exists?(path)
    raise "File doesn't exsit" unless File.exist? path
  end

  def caculate_view_count(unique)
    @records.transform_values do |value|
      unique ? value.uniq.size : value.size
    end
  end

  def get_sorted_record(result)
    result.sort_by { |_k, v| -v }
  end
end
