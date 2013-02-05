module ByNavigation
  class ItemAlias
    attr_reader :title
    def initialize(origin_id, title)
      raise TypeError unless origin_id.is_a?(Symbol)
      @parent = nil
      @title = title
      @origin_id = origin_id
    end

    def parent=(parent)
      @parent = parent
    end

    def origin
      ByNavigation::Configuration.get_item_by_id(@origin_id)
    end

    def id
      self.origin.id
    end

    def title
      @title || self.origin.title
    end

    def html_class
      self.origin.html_class
    end

    def html_id
      self.origin.html_id
    end

    def url
      self.origin.url
    end

    def params
      self.origin.params
    end

    def param(key)
      self.origin.param(key)
    end

    def has_param(key)
      self.origin.has_param(key)
    end

    def has_link
      self.origin.has_link
    end

    def children
      []
    end

    def depth
      @parent ? @parent.depth + 1 : 0
    end
  end
end
