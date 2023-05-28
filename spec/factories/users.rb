FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    fname                 { person.first.kanji }
    lname                 { person.last.kanji }
    fname_kana            { person.first.katakana }
    lname_kana            { person.last.katakana }
    birthdate             { Faker::Date.birthday }
  end
end
