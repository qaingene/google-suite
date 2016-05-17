Feature: Login

### Scenario 1 - Done
  Scenario: User should be able to login with valid credentials
    When I press 'Sign In' button on [Index] page
    And I login as 'qa.in.gene@gmail.com/Great123' on [Login] page
    And I should be logged in as 'qa-in-gene' on [Dashboard] page


### Scenario 2
  Scenario: User should be able to sent email to himself
    When I login with 'qa.in.gene@gmail.com/Great123' credentials
    And I press 'Google tab' button on [Dashboard] page
    And I press 'Emails' service on [Dashboard] page
    And I press 'Compose' button on [Email] page
    And I send new emails with following data:
      | to                    | subject   | message                |
      | qa.in.gene@gmail.com  | TestEmail | Hi! This is test email |
    And I press 'Inbox' link on [Email] page
    Then I should see email with 'TestEmail' subject on [Email] page
    When I 'checked' email with 'TestEmail' subject on [Email] page
    And I press 'Delete' button on [Email] page
    And I should not see email with 'TestEmail' subject on [Email] page