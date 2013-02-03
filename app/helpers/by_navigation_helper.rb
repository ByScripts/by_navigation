module ByNavigationHelper
  def navigation(id = :main_nav, options = {})
    item = ByNavigation::Configuration.get_item(id)

    return "" if item.nil? || item.children.empty?

    options[:except] = Array(options[:except])
    options[:only] = Array(options[:only])
    options[:nav_id] = id

    to_regex = lambda do |x|

      next x if x.is_a?(Regexp)

      x = "#{id}_#{x}".to_sym unless x.to_s.start_with?(id.to_s)

      Regexp.new("^#{x}")
    end

    options[:except].collect!(&to_regex)
    options[:only].collect!(&to_regex)

    navigation_for(item, item.id, options)
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
      render("by_navigation/#{item.id}/container", render_params)
    rescue
      render("by_navigation/default/container", render_params)
    end
  end

  def navigation_item_for(item, layout, options)

    if item.id == options[:nav_id]
      go_further = true
    else
      go_further = options[:only].empty?

      options[:only].each do |only|
        break go_further = true if only =~ item.id
      end

      options[:except].each do |except|
        break go_further = false if except =~ item.id
      end
    end

    return "" unless go_further


    render_params = {
      item: item,
      layout: layout,
      options: options
    }
    begin
      render("by_navigation/#{item.id}/item", render_params)
    rescue
      render("by_navigation/default/item", render_params)
    end
  end
end
