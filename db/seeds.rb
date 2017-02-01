user = User.create(
  email:                 'example@gmail.com',
  password:              '123123123',
  password_confirmation: '123123123'
)

mobile_dev_category      = Category.create title: 'Mobile development'
photo_category           = Category.create title: 'Photo'
web_design_category      = Category.create title: 'Web design'
web_development_category = Category.create title: 'Web development'


