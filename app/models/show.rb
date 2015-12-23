class Show

  attr_accessor :id, :datetime, :artsists, :venue, :city, :region, :country

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
    shows_hashes = Unirest.get("#{ENV['API_BASE_URL']}shows.json", headers: {"X-User-Email": "yo@yo.yo", "Authorization": "Token token=ABC123"}).body 
    shows_hashes.each do |show|
      shows << Show.new(show)
    end
    return shows
  end

  def self.find(id)
    Show.new( Unirest.get("#{ENV['API_BASE_URL']}shows/#{id}.json", headers: {"X-User-Email": "yo@yo.yo", "Authorization": "Token token=ABC123"}).body )    
  end

  def create(hash)
    @show = Unirest.post("#{ENV['API_BASE_URL']}shows.json", headers: {"X-User-Email": "yo@yo.yo", "Authorization": "Token token=ABC123"}, 
      parameters: hash).body
  end

  def update(hash)
    @show = Unirest.patch("#{ENV['API_BASE_URL']}shows/#{@id}.json", headers: {"X-User-Email": "yo@yo.yo", "Authorization": "Token token=ABC123"}, 
      parameters: hash).body
  end

  def destroy
    @show = Unirest.delete("#{ENV['API_BASE_URL']}shows/#{@id}.json", headers: {"X-User-Email": "yo@yo.yo", "Authorization": "Token token=ABC123"}).body
  end

end