class Show

  attr_accessor :id, :datetime, :artsists, :venue, :city, :region, :countrya

  def initialize(hash)
    @id = hash["id"]
    @datetime = hash["datetime"]
    @artsists = hash["artsists"]
    @venue = hash["venue"]
    @city = hash["city"]
    @region = hash["region"]
    @country = hash["country"]
  end

  def self.all
    shows = []
    shows_hashes = Unirest.get("http://localhost:3000/shows/index.json").body 
    shows_hashes.each do |show|
      shows << Show.new(show)
    end
    return shows
  end

  def self.find(id)
    Show.new( Unirest.get("http://localhost:3000/shows/#{id}.json").body )    
  end

  def create(hash)
    @show = Unirest.post("http://localhost:3000/shows.json", headers: {"Accept" => "application/json"}, 
      parameters: hash).body
  end

  def update(hash)
    @show = Unirest.patch("http://localhost:3000/shows/#{@id}.json", headers: {"Accept" => "application/json"}, 
      parameters: hash).body
  end

  def destroy
    @show = Unirest.delete("http://localhost:3000/shows/#{@id}.json", headers: {"Accept" => "application/json"}).body
  end

end