require 'faraday'
require 'json'
require_relative 'thumbnail.rb'

class Searcher
  attr_reader :query, :count_per_page, :pages
  def initialize query, count_per_page=8, pages=4
    @query = query
    @count_per_page = count_per_page
    @pages = pages
  end

  def page page_index
    @conn ||= Faraday.new :url => 'https://ajax.googleapis.com/'
    base_request = "ajax/services/search/images?v=1.0&q=#{@query}&"
    response = @conn.get(
      base_request +
      "&rsz=#{@count_per_page}&start=#{page_index*@count_per_page}")
    js = JSON.parse response.body

    [].tap do |search_results|
      js["responseData"]["results"].each do |result|
        search_results << Thumbnail.new(
          result["tbUrl"], result["tbWidth"].to_i, result["tbHeight"].to_i)
      end
    end
  end

  def results
    @results ||= [].tap do | search_results |
      @pages.times do |page_index|
        search_results.concat page page_index
      end
    end
  end
end