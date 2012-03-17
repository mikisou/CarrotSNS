FactoryGirl.define do
  factory :admin, class: User do
    sequence(:login) {|n| "admin#{n}" }
    sequence(:email) {|n| "carrot_admin_#{n}@example.com" }
    password_digest "$2a$10$Zgm0NTA2trNswDbKGlPz5OFhbp4zZmV5qR7nNDdt104BR2teRHJWi" # 'monkey'
    created_at Time.now
    updated_at Time.now
    profile { Factory(:admin_profile) }
  end

  factory :admin_profile, class: Profile do
    sequence(:nick_name) { "quentin#{n}" }
    locale 'ja'
    age 33
    comment 'one line comment.'
    created_at Time.now
    updated_at Time.now
  end


  factory :user, class: User do
    sequence(:login) {|n| "aaron#{n}" }
    sequence(:email) {|n| "carrot_user_#{n}@example.com" }
    password_digest "$2a$10$Zgm0NTA2trNswDbKGlPz5OFhbp4zZmV5qR7nNDdt104BR2teRHJWi" # 'monkey'
    created_at Time.now
    updated_at Time.now
    profile { Factory(:admin_profile) }
  end

  factory :user_profile, class: Profile do
    sequence(:nick_name) { "aaron#{n}" }
    locale 'ja'
    age 32
    comment 'one line comment.'
    created_at Time.now
    updated_at Time.now
  end
end