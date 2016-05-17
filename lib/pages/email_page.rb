class EmailPage <SitePrism::Page

  element :compose_button, :xpath, "//*[text()='COMPOSE']"
  element :to_field, :xpath, "//*[@class='wO nr l1']/textarea"
  element :subject_field, :xpath, "//*[@name='subjectbox']"
  element :message_field, :xpath, "//*[@id=':jw']"
  element :send_button, :xpath, "//*[text()='Send']"
  element :inbox_button, :xpath, "//*[@class='aim ain']//*[contains(text(), 'Inbox')]"

end