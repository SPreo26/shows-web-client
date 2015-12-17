class ShowsController < ApplicationController

  attr_accessor :show_fields, :show_params_hash

  def initialize()
    @show_fields = [:datetime, :artsists, :venue, :city, :region, :country]
    @show_params_hash = Hash[@show_fields.zip([0]*show_fields.length)]
    #convert show_fields array [field1, field2...] to a hash full of zeros like {field1 => 0, field2 =>0}
  end

  def index
    @shows = Show.all
    p "AAAAAAAAaaaaaaa"
    p @shows
  end

  def show
    @show = Show.find(params[:id])
  end 

  def new

  end

  def create
    fill_params_hash
    @show = Unirest.post("http://localhost:3000/shows.json", headers: {"Accept" => "application/json"}, 
      parameters: show_params_hash).body
    # p "AAAAAAAAaaaaaaa"
    # p @show
    redirect_to "/shows/#{@show["id"]}"
  end

  def edit
    @form_is_edit = true  
    @show = Show.find(params[:id])
  end

  def update
    fill_params_hash
    @show = Show.find(params[:id])
    if !@show
      redirect_to "/shows"
    end
      @show.update(@show_params_hash)
      redirect_to "/shows/#{params[:id]}"
  end

  def destroy
    @show=Show.find(params[:id])
    if @show
      @show.destroy
    end
    redirect_to "/shows"
  end

  private

  def fill_params_hash
    @show_params_hash.each do |key, value|
      show_params_hash[key]=params[key]
    end
  end

end
