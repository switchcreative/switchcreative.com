require "boarding_pass"
require "lib/application_helper"
helpers ApplicationHelper

# activate :livereload

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

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

Time.zone = "America/Chicago"

activate :deploy do |deploy|
  deploy.method = :git
  # deploy.remote = "origin" # uses 'origin' by default
  # deploy.branch = "gh-pages" # uses 'gh-pages' by default
end

activate :blog do |blog|
  blog.default_extension = ".md"
  blog.sources   = ":title"
  blog.layout    = "portfolio_layout"
  blog.prefix    = "portfolio"
  blog.permalink = ":title"
  # Pagination
  blog.paginate = true
  blog.per_page = 10
  # blog.page_link = "p:num"
end

activate :directory_indexes


set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir, 'fonts'


# Build-specific configuration
configure :build do
  # activate :sprockets

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  activate :asset_hash
  activate :gzip

  # TODO necessary?
  compass_config do |config|
    config.sass_options = { :debug_info => false }
  end

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
