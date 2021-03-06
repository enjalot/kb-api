
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!

require 'factory_girl_rails'
require 'json_spec'
require 'shoulda/matchers'


$sunspot_session = Sunspot.session


# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!


RSpec.configure do |config|

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Patch in custom matchers.
  config.include FactoryGirl::Syntax::Methods
  config.include SunspotMatchers

  # Mock the Solr service.
  config.before do
    Sunspot.session = Sunspot::Rails::StubSessionProxy.new($sunspot_session)
  end

  # After a test that hits Solr, clear the index.
  config.before(:each, :solr) do
    Sunspot.session = $sunspot_session
    Sunspot.remove_all!
  end

  # Swallow STDOUT and STDERR.
  config.around(:each, :quiet) do |test|
    silence_stream(STDERR) do
      silence_stream(STDOUT) do
        test.run
      end
    end
  end

  # Clear Neo4j.
  config.before(:each, :neo4j) do
    Graph::Person.delete_all
  end

  # Request JSON response.
  config.before(:each, :json) do
    request.headers["Accept"] = "application/json"
  end

  # Render views in controller specs.
  config.render_views

end


Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.library :rails
    with.test_framework :rspec
  end
end
