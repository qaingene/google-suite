When(/^I press '(.*)' button on \[Index\] page$/) do | buttonName |
  @googleSuite = GoogleSuite.new
  visit "#{EnvConfig.get :google_url}"
  @googleSuite.Index_Page.sign_in_button.click if buttonName=='Sign In'
end

When(/^I login as '(.*)' on \[Login\] page$/) do | credentials |
  usernameAndPassword = credentials.split('/')
  @googleSuite.Login_Page.username_field.set usernameAndPassword[0]
  @googleSuite.Login_Page.next_button.click
  @googleSuite.Login_Page.password_field.set usernameAndPassword[1]
  @googleSuite.Login_Page.sign_in_button.click
end

When(/^I login with '(.*)' credentials$/) do | credentials |
  step "I press 'Sign In' button on [Index] page"
  step "I login as '#{credentials}' on [Login] page"
end


When(/^I should be logged in as '(.*)' on \[Dashboard\] page$/) do | username |
  actualUsername = @googleSuite.Dashboard_Page.username_label.text
  expect(actualUsername).to eq(username), "Username is incorrect.  \n Expected: #{username}  \n Actual: #{actualUsername}"
end