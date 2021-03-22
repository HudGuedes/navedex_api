FactoryBot.define do
  factory :project do
    name { 'Teste' }
    user { build :user }
  end
end