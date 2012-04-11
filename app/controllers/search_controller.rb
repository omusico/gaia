class SearchController < ApplicationController
  
  def index
    matches = get_matches(params[:text])
    respond_as_api(render_values(matches))
  end
  
  private
  
  def check_duplicate_matches(matches)
    if matches[:dists].size > 1 && matches[:dists].map(&:name).uniq.size < matches[:dists].size
      cities_ids = matches[:cities].map(&:id)
      matches[:dists].reject!{ |dist| !cities_ids.include?(dist.city_id) } if cities_ids.size > 0
    end
    matches
  end
  
  def get_matches text
    matches = {:cities => [], :dists => []}
    City.api_includes.enabled.each do |city|
      matches[:cities] << city if city.match?(text)
      city.dists.each do |dist|
        matches[:dists] << dist if dist.match?(text)
      end
    end
    check_duplicate_matches matches
  end

  def render_values values
    {
      :cities => values[:cities].map {|city|
        {:id => city.id,
         :name => city.name,
         :name_aliases => city.name_aliases.map {|name_alias|
           name_alias.name
         }
        }
      },
      :dists => values[:dists].map{|dist|
        {:id => dist.id,
         :name => dist.name,
         :name_aliases => dist.name_aliases.map {|name_alias|
           name_alias.name
         },
         :city => {
           :id => dist.city.id, 
           :name => dist.city.name
         }
        }
      }
    }
  end
  
end
