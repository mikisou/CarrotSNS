FactoryGirl.define do
  factory :admin, class: User do
    login 'Administrator'
    email  'admin@localhost.local'
    password_digest "$2a$10$Zgm0NTA2trNswDbKGlPz5OFhbp4zZmV5qR7nNDdt104BR2teRHJWi" # 'monkey'
    created_at Time.now
    updated_at Time.now
    profile { Factory(:admin_profile) }
  end

  factory :admin_profile, class: Profile do
    nick_name 'quentin'
    locale 'ja'
    age 33
    comment 'one line comment.'
    created_at Time.now
    updated_at Time.now
  end
end