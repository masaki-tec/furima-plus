FactoryBot.define do
  factory :comment do
    text { 'サンプルコメント' }
    association :user
    association :item
  end
end
