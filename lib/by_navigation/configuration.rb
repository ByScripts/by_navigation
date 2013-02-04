module ByNavigation
  class Configuration
    @@registered_by_id = {}
    @@registered_by_url = {}

    def initialize(id, &block)
      register(ByNavigation::Item.new(id, "", {}, &block))
    end

    def register(item)
      @@registered_by_id[item.id] = item
      @@registered_by_url[item.url] = item
      item.children.each { |c| self.register(c) }
    end

    def self.registered_by_id
      @@registered_by_id
    end

    def self.get_item(id_or_url = :main)
      id_or_url = "/#{id_or_url}" if id_or_url.is_a?(String) && !id_or_url.start_with?('/')
      id_or_url.is_a?(Symbol) ? get_item_by_id(id_or_url) : get_item_by_url(id_or_url)
    end

    def self.get_item_by_id(id)
      @@registered_by_id[id]
    end

    def self.get_item_by_url(url)
      @@registered_by_url[url]
    end
  end
end
