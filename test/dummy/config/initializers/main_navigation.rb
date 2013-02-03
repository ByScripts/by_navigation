ByNavigation::Configuration.new :main do

  item :page_1, "Page 1"
  item :page_2, "Page 2" do
    no_link
    item :page_2_1, "Page 2.1"
    item :page_2_2, "Page 2.2"
  end
  item :page_3, "Page 3"
end
