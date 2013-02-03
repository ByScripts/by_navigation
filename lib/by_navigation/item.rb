module ByNavigation
  class Item

    attr_reader :depth, :children
    attr_accessor :title, :parent, :no_link

    def initialize(id, title, options = {}, &block)

      raise TypeError unless id.is_a?(Symbol)

      @id = id
      @html_class = @id.to_s.dasherize
      @html_id = @html_class
      @title = title
      @params = {}
      @params_propagated = {}
      @parent = nil
      @url = nil
      @slug = title.to_url
      @children = []
      ByNavigation::DSL.new(self, options, &block) if block_given?
    end

    def id
      [@parent && @parent.id, @id].compact.join('_').to_sym
    end

    def add_child(item)
      item.parent = self
      @children << item
    end

    def html_class
      [@parent && @parent.html_class, @html_class].compact.join(' ')
    end

    def html_class=(name)
      @html_class = name
    end

    def html_id
      [@parent && @parent.html_id, @html_id].compact.join('-')
    end

    def html_id=(id)
      @html_id = id
    end

    def url
      "/#{@url || [@parent && @parent.url, @slug].join("/")}".gsub(/\/+/, "/")
    end

    def slug=(slug)
      @slug = slug
    end

    def url=(url)
      @url = url
    end

    def set_param(key, value, propagate)
      @params[key] = value
      @params_propagated[key] = value if propagate
    end

    def params_propagated
      parent_params = (@parent && @parent.params_propagated) || {}
      parent_params.merge(@params_propagated).delete_if { |k, v| v.nil? }
    end

    def params
      (@parent && @parent.params_propagated).merge(@params).delete_if { |k, v| v.nil? }
    end

    def param(key)
      self.params[key]
    end

    def has_param(key)
      params.has_key?(key)
    end

    def has_link
      not @no_link
    end

    def depth
      @parent ? @parent.depth + 1 : 0
    end

    def to_s
      @title
    end
  end
end
