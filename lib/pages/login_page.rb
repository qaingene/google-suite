class LoginPage < SitePrism::Page

  element :username_field, '#Email'
  element :next_button, '#next'
  element :password_field, '#Passwd'
  element :sign_in_button, '#signIn'

end