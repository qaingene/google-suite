$: << File.dirname(__FILE__)+'/../lib'

ENVIRONMENT = (ENV['ENVIRONMENT'] || 'production').to_sym
Dir::mkdir('report') unless File.directory?('report')
raise "You need to create a configuration file named '#{ENVIRONMENT}.yml' under lib/config" unless File.exists? "#{File.dirname(__FILE__)}/../../lib/config/#{ENVIRONMENT}.yml"

require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'site_prism'
require 'env_config'
require 'googleSuite'
require 'pages'
require 'support/string'
require 'capybara_helper'
require 'active_support/all'
require 'rspec'

World(CapybaraHelper)

Capybara.configure do |config|
  config.default_driver = :selenium
  config.javascript_driver = :selenium

  config.run_server = EnvConfig.get :run_server
  config.default_selector = EnvConfig.get :default_selector
  config.default_wait_time = EnvConfig.get :wait_time

  #capybara 2.5.0 config options
  config.match = EnvConfig.get :match
  config.ignore_hidden_elements = EnvConfig.get :ignore_hidden_elements
end

Capybara.register_driver :selenium do |app|
  chromedriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"chromedriver.exe")
  Selenium::WebDriver::Chrome::Service.executable_path = chromedriver_path
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

def generate_random_string(length=6)
  string = ""
  chars = ("a".."z").to_a
  length.times do
    string << chars[rand(chars.length-1)]
  end
  string
end

Before do
  CapybaraHelper.random_string = generate_random_string
  page.driver.browser.manage.window.maximize
end

After do |scenario|
  if scenario.failed?
    screenshot = "./report/FAILED_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}.png"
    begin
      page.driver.save_screenshot(screenshot)
    rescue Errno::ECONNREFUSED
      puts "no connection after"
      Capybara.reset_sessions!
    end
    embed screenshot, 'image/png'
  end
end
