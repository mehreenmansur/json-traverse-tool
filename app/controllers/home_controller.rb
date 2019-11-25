class HomeController < ApplicationController
  require 'json'
  require 'ostruct'

  def index; end

  def search
    json_file = File.read('sample_json_traverse.json')

    json_data = JSON.parse(json_file, object_class: OpenStruct)

    search_data = params[:search_data].split('.')
    i = 0
    while (i < search_data.length)
      if i == 0
        value = json_data.send("#{search_data[i]}")
      else
        value = value.send("#{search_data[i]}")
      end
      i += 1
    end
    @answer = value
    respond_to do |format|
      format.html
    end
  end
end
