# encoding: utf-8
module ApplicationHelper
  def render_select(collection, selected, html_options = {})
    selected = selected.present? ? selected : nil
    html_options[:include_blank] = false
    html_options[:prompt] = "請選擇"
    select_tag html_options[:name], options_from_collection_for_select(collection, :id, :name, selected), html_options
  end
end
