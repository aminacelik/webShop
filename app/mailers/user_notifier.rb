class UserNotifier < MandrillMailer::TemplateMailer
  default from: "abhshoes@abhshoes.com", from_name: 'AbhShoes'
  
  def welcome(user)
    mandrill_mail template: 'UserRegistrationMail',
    subject: 'Wellcome to AbhShoes',
    to: { email: user.email, name: user.name },
    vars: { 'USER_NAME' => user.name},
    important: true,
    inline_css: true,
    async: true
  end
  
  
end
