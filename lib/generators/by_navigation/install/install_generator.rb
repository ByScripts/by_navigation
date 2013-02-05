class ByNavigation::InstallGenerator < Rails::Generators::Base

  #desc "install NAVIGATION_ID", "Generates and copy an initializer file"
  #argument :name, desc: "Name of your navigation root"
  argument :name, banner: "<layout_name>", desc: "My description", type: :string

  def create_initializer
    puts "Creating initializer for #{self.name}..."
#     initializer "by_navigation/#{nav_name}.rb", <<-CODE
# ByNavigation::Navigation.configure :#{nav_name} do
#   # item "Label", :identifier
# end
# CODE
  end
end
