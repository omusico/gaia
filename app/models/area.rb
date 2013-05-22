class Area < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_uniqueness_of :name
  validates_presence_of :name
  scope :full_includes, includes([{ :cities => [:name_aliases, { :dists => [:name_aliases] }] }])
  has_many :cities
  has_many :dists

  def to_api_vars(with: [])
    vars = { 
      :id => id,
      :name => name,
      :name_en => name_en
    }
    vars[:cities] = cities.map{ |c| c.to_api(:with => [:name_aliases, :dists]) } if with.include?(:cities)
    # vars[:dists] = dists.map{ |d| d.to_api(:with => [:name_aliases, :city]) } if with.include?(:dists)
    vars
  end

end
