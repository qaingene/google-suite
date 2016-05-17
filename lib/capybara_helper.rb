module CapybaraHelper

  require 'rubygems'
  require 'active_support'

  mattr_accessor :random_string

  def unique_value(value)
    magic_word = 'pre-setup'
    if value.include? magic_word
      value.gsub("#{magic_word} ", '')
    elsif value.include? "empty"
      value.gsub("empty", '')
    else
      "#{value}-#{random_string}"
    end
  end

  def wait_until
    require "timeout"
    Timeout.timeout(Capybara.default_wait_time) do
      sleep(0.1) until value = yield
      value
    end
  end

  def element_visible?(xpath_locator)
    element_present?(xpath_locator) && element_displayed?(xpath_locator)
  end

  private

  def element_present?(xpath_locator)
    wait_until {
      begin
        page.evaluate_script('document.readyState === "complete"')
      rescue Timeout::Error
        puts "Time out to page load"
      rescue Selenium::WebDriver::Error::JavascriptError
        puts "Java script Error"
        retry
      end
       }
    page.has_xpath?(xpath_locator)
  end

  def element_displayed?(web_element_locator)
    find(:xpath, web_element_locator).visible?
  end

  def interact_with_checkbox(checkbox, action)
    if action == 'checked'
      check_checkbox(checkbox)
    else
      if action == 'unchecked'
        uncheck_checkbox(checkbox)
      end
    end
  end

  def check_checkbox(checkbox)
    if checkbox['checked'].nil?
      checkbox.click
    end
  end

  def uncheck_checkbox(checkbox)
    unless checkbox['checked'].nil?
      checkbox.click
    end
  end

end

