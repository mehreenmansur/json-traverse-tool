class HomeController < ApplicationController
  require 'json'
  require 'ostruct'

  def index
    @json = read_json_file
  end

  def search
    @json = read_json_file
    json_data = JSON.parse(@json, object_class: OpenStruct)

    @data = params[:search_data]
    search_data = @data.split('.')

    i = 0
    while (i < search_data.length)
      @answer = if i.equal?(0)
                  json_data.send("#{search_data[i]}")
                else
                  @answer.send("#{search_data[i]}")
                end
      i += 1
    end

    respond_to do |format|
      format.html
    end
  end

  def read_json_file
    File.read('sample_json_traverse.json')
  end
end
