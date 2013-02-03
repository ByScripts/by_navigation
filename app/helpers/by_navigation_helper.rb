module ByNavigationHelper
  def navigation(id = :main)
    item = ByNavigation::Configuration.get_item(id)

    return "" if item.nil? || item.children.empty?

    navigation_for(item, item.id, {})
  end

private

  def navigation_for(item, layout, options)

    return "" if item.children.empty?

    render_params = {
      container: item,
      items: item.children,
      layout: layout,
      options: options
    }

    begin
      render("by_navigation/#{item.id}", render_params)
    rescue
      render("by_navigation/default", render_params)
    end
  end
end
