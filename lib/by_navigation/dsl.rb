module ByNavigation
  class DSL
    def initialize(item, options, &block)
      @item = item
      instance_eval(&block)
    end

    def item_alias(origin_id, title = nil)
      @item.add_child(ByNavigation::ItemAlias.new(origin_id, title))
    end

    def item(id, title, options = {}, &block)
      @item.add_child(ByNavigation::Item.new(id, title, options, &block))
    end

    def title(title)
      @item.title = title
    end

    def html_class(html_class)
      @item.html_class = html_class
    end

    def slug(slug)
      @item.slug = slug
    end

    def url(url)
      @item.url = url
    end

    def html_id(html_id)
      @item.html_id = html_id
    end

    def param(key, value, propagate = false)
      @item.set_param(key, value, propagate)
    end

    def no_link
      @item.no_link = true
    end
  end
end
