FactoryBot.define do
  factory :item do
    name                     { '時計' }
    product_description      { '壁掛け時計' }
    status_id                { 2 }
    cover_delivery_cost_id   { 2 }
    prefecture_id            { 2 }
    delivery_id              { 2 }
    price                    { 1000 }

    association :user

    association :category, factory: :category

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
