# Global Guardfile (more info at https://github.com/guard/guard#readme)

if Gem.available? 'guard-sass'
  guard 'sass', :output => 'public/stylesheets' do
    watch(%r{^public/stylesheets/sass/(.+\.s[ac]ss)$})
  end
end

if Gem.available? 'guard-livereload'
  guard 'livereload' do
    # omit files starting with a dot (to prevent double reloads)
    watch(%r{^app/([a-zA-Z0-9_-]+/)+[^\.]+(\.html)*\.(erb|haml)})
    watch(%r{^app/helpers/([a-zA-Z0-9_-]+/)*[^\.]+\.rb})
    watch(%r{^(public/|app/assets/)([a-zA-Z0-9_-]+/)*[^\.]+\.(css|js|html)})
    watch(%r{^config/locales/([a-zA-Z0-9_-]+/)*[^\.]+\.yml})
    # the rest
    watch(%r{^(app/assets/.+\.css)\.scss})  { |m| m[1] }
    watch(%r{^(app/assets/.+\.js)\.coffee}) { |m| m[1] }
  end
end

if Gem.available? 'guard-bundler'
  guard 'bundler' do
    watch('Gemfile')
  end
end

if Gem.available? 'guard-shell'
  guard 'shell' do
    # Restart passenger
    watch('Gemfile.lock')       { |m| `touch tmp/restart.txt` }
    watch(%r{^(config|lib)/.*}) { |m| `touch tmp/restart.txt` }
  end
end

if Gem.available? 'guard-rspec'
  guard 'rspec', :version => 2 do
    # Global
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')  { "spec" }

    # Rails specific
    watch(%r{^app/(.+)\.rb$})                          { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^lib/(.+)\.rb$})                          { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
    watch(%r{^spec/support/(.+)\.rb$})                 { "spec" }
    watch('config/routes.rb')                          { "spec/routing" }
    watch('app/controllers/application_controller.rb') { "spec/controllers" }

    # Capybara request specs
    watch(%r{^app/views/(.+)/.*\.(erb|haml)$})         { |m| "spec/requests/#{m[1]}_spec.rb" }

    # Controller specs for views
    watch(%r{^app/views/(.+)/.*\.(erb|haml)$})         { |m| "spec/controllers/#{m[1]}_spec.rb" }
  end
end

if Gem.available? 'guard-test'
  guard 'test' do
    watch(%r{^lib/(.+)\.rb$})     { |m| "test/#{m[1]}_test.rb" }
    watch(%r{^test/.+_test\.rb$})
    watch('test/test_helper.rb')  { "test" }

    # Rails example
    watch(%r{^app/models/(.+)\.rb$})                   { |m| "test/unit/#{m[1]}_test.rb" }
    watch(%r{^app/controllers/(.+)\.rb$})              { |m| "test/functional/#{m[1]}_test.rb" }
    watch(%r{^app/views/.+\.rb$})                      { "test/integration" }
    watch('app/controllers/application_controller.rb') { ["test/functional", "test/integration"] }
  end
end