###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

data.shows.each do |show|
  proxy "/shows/#{show[0]}/index.html", "/shows/template.html", locals: { show: show[1] }, :ignore => true
end

data.teams.each do |team|
  proxy "/teams/#{team[0]}/index.html", "/teams/template.html", locals: { id: team[0], team: team[1] }, :ignore => true
end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  activate :minify_html

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
   activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :dotenv, env: 'deploy.env'

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method   = ENV["DEPLOY_METHOD"]
  deploy.host     = ENV["DEPLOY_HOST"]
  deploy.port     = ENV["DEPLOY_PORT"]
  deploy.path     = ENV["DEPLOY_PATH"]
  deploy.user     = ENV["DEPLOY_USER"]
  deploy.password = ENV["DEPLOY_PASSWORD"]
end
