# Install testing frameworks
gem 'rspec',        :source => 'http://gemcutter.org', :lib => false, :env => :test
gem 'rspec-rails',  :source => 'http://gemcutter.org', :lib => false, :env => :test
gem 'webrat',       :source => 'http://gemcutter.org', :env => :test
gem 'cucumber',     :source => 'http://gemcutter.org', :env => :test
gem 'factory_girl', :source => 'http://gemcutter.org', :env => :test
gem 'shoulda',      :source => 'http://gemcutter.org', :env => :test

rake 'gems:install'

# Install JQuery
plugin 'jrails', :git => 'git://github.com/aaronchi/jrails.git'
rake 'jrails:js:scrub'

# Install Elastic CSS
plugin 'elastic_rails', :git => 'git://github.com/mexpolk/elastic_rails.git'
rake 'elastic:install'

generate :haml, '--rails'
generate :rspec
generate :cucumber

run 'ECHO > README'                                     
run 'rm public/index.html'                              
run 'cp config/database.yml config/sample_database.yml'

# Git initialization and configuration
file '.gitignore', <<-END
log/*
tmp/*
db/schema.rb
db/*.sqlite3
db/*.sqlite3-journal
config/database.yml
all.js
all.css
public/stylesheets/*css
END

run 'touch tmp/.gitignore'
run 'touch log/.gitignore'
run 'touch vendor/.gitignore'

git :init
git :add => '.'
git :commit => "-a -m 'initial commit'"
