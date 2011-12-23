require "iconv"
class Importer
  def self.run
    self.new.cities_with_dists.each do |hash|
      city_name = hash[:city]
      city = City.find_by_name(city_name) || City.create(:name => city_name)
      city.enable
      hash[:dists].each do |dist_name|
        dist = Dist.find_by_name_and_city_id(dist_name, city.id) || Dist.create(:city=>city, :name => dist_name)
        dist.enable
      end
    end
  end
  
  def cities_with_dists
    cities = []
    array_cities.each do |city_name|
      dists = array_dists city_name
      cities << {:city => clean_name(city_name), :dists => dists}
    end
    cities
  end
  
  def array_dists city_name
    tmps = content.scan(/<tr align="center">.*?<td><b><a href="\/wiki\/[^"]+?" title="([^"]+)".+?<\/a>(.+?)<\/tr>/m)
    content = ""
    tmps.each do |tmp|
      if tmp[0] == city_name
        content = tmp[1]
      end
    end
    if content.size > 0
      dists = []
      content.scan(/title="([^"]+)"( class="mw\-redirect")*>([^<]+)<\/a>/m).each do |tmp|
        dists << clean_name(tmp[2].force_encoding("UTF-8"))
      end
      dists
    end
  end
  
  def array_cities
    cities = []
    scans = content.scan(/<td><b><a href="\/wiki\/[^"]+?" title="([^"]+)"( class="mw\-redirect")*>/m)
    # puts scans.inspect
    scans.each do |tmp|
      cities << ActiveSupport::JSON.decode("[\"#{tmp[0]}\"]").pop.force_encoding('UTF-8')
    end
    cities
  end
  
  def content
    if !@content
      url = "http://zh.wikipedia.org/wiki/%E4%B8%AD%E8%8F%AF%E6%B0%91%E5%9C%8B%E5%8F%B0%E7%81%A3%E5%9C%B0%E5%8D%80%E9%84%89%E9%8E%AE%E5%B8%82%E5%8D%80%E5%88%97%E8%A1%A8"
      @content = fetch(url).force_encoding('UTF-8')
    end
    @content
  end
  
  def fetch url
    response = Net::HTTP.get_response URI.parse(url)
    response.body
  end
  
  def clean_name name
    name.scan(/([^ \(]+)/)[0][0]
  end
end