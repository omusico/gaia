class ZipcodeParser
  
  def self.parse_zipcode
    tmps = ActiveSupport::JSON.decode Net::HTTP.get(URI.parse("http://medusa.marsz.tw/crawler/fetch.json?url=http://www.cnrc.idv.tw/space/dargon129031/tnbs0L/0010401.htm&options[encoding]=big5&token=ji3g42841p4204"))
    content = tmps["data"]
    static_zips = {"香山" => 300, "滿州" => 947, "烈嶼" => 894, "通霄" => 357, "峨眉" => 315}
    Dist.where('zipcode is null').each do |dist|
      static_zips.each do |search, zipcode|
        if dist.name.index(search)
          dist.update_column(:zipcode, zipcode)
          break
        end
      end
      if dist.city.name == "新竹市"
        dist.update_column(:zipcode, 300)
      end
      next if dist.zipcode
      
      names = [ dist.name ] + dist.name_aliases.map(&:name)
      names.each do |name|
        tmps = content.scan(/<font face="cursive" size="4">#{name}.*?<\/td>.+?<td.+?>([0-9]+)<\/font>/mi)
        if tmps.size > 1
          if dist.city.name.index("北")
            tmps = tmps.select{ |zipcode| zipcode[0][0] == "1" }
          else
            tmps = tmps.select{ |zipcode| zipcode[0][0] != "1" }
          end
          if dist.city.name.index("臺南")
            tmps = tmps.select{ |zipcode| zipcode[0][0] == "7" }
          else
            tmps = tmps.select{ |zipcode| zipcode[0][0] != "7" }
          end
        end
        if tmps.size == 1
          dist.update_column(:zipcode, tmps[0][0].to_i) 
          break
        elsif tmps.size > 1
          puts dist.city.name
          puts dist.name
          puts tmps.inspect
        end
      end
    end
    nil
  end
  
end