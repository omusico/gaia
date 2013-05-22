class Area < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_uniqueness_of :name
  validates_presence_of :name
  scope :include_cities_and_dists, includes(:cities => [:name_aliases, { :dists => [:name_aliases] }])
  scope :include_cities, includes(:cities => :name_aliases)
  has_many :cities
  has_many :dists

  def to_api_vars(with: [])
    vars = { 
      :id => id,
      :name => name,
      :name_en => name_en
    }
    vars[:cities] = cities.map{ |c| c.to_api_vars(:with => [:name_aliases]) } if with.include?(:cities)
    vars[:cities] = cities.map{ |c| c.to_api_vars(:with => [:name_aliases, :dists]) } if with.include?(:cities_and_dists)
    vars
  end

end
