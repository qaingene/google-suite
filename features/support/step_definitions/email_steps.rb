When(/^I press '(.*)' (?:button|service) on \[Dashboard\] page$/) do | button |
  @googleSuite.Dashboard_Page.menu_button.click if button=='Google tab'
  @googleSuite.Dashboard_Page.email_tab.click if button=='Google tab'
end

When(/^I press '(.*)' (?:button|link) on \[Email\] page$/) do | button |
  @googleSuite.Email_Page.compose_button.click if button=='Compose'
  @googleSuite.Email_Page.compose_button.click if button=='Inbox'
end

When(/^I send new emails with following data:$/) do | table |

  table.hashes.each do | email |
    to = email[:to]
    subject = email[:subject]
    message = email[:message]

    @googleSuite.Email_Page.to_field.set to
    @googleSuite.Email_Page.subject_field.set unique_value(subject)
    @googleSuite.Email_Page.message_field.set message
    @googleSuite.Email_Page.send_button.click
  end
end

When(/^I should see email with '(.*)' subject on \[Email\] page$/) do | subject|
  expect(@ac9.contact_profile_page.keywords_field).to have_content(keywords) if keywords
  expect(actualUsername).to eq(username), "Username is incorrect.  \n Expected: #{username}  \n Actual: #{actualUsername}"
end

