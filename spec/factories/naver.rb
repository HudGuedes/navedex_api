FactoryBot.define do
  factory :naver do
    name { 'Teste' }
    user { build(:user) }
    birthdate { '1990-01-01' }
    admission_date { '1990-01-01' }
    job_role { 'Development' }
  end
end