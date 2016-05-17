class DashboardPage < SitePrism::Page

  element :username_label, :xpath, "//span[@class='gb_P gb_R']"
  element :menu_button, :xpath, "//*[@class='gb_b gb_Qb']"
  element :email_tab, :xpath, "//*[@href='https://mail.google.com/mail/?tab=wm']"
end