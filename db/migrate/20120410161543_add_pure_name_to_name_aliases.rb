# encoding: utf-8
class AddPureNameToNameAliases < ActiveRecord::Migration
  def change
    Dist.find_each do |dist|
      pure_name = dist.pure_name
      unless ['中山','中正','信義','東','南','西','北','仁愛','八德','復興','永和','中和','延平','金城','成功','大同'].include?(pure_name)
        dist.name_aliases.create(:name => pure_name, :is_enabled => true)
      end
    end
  end
end
