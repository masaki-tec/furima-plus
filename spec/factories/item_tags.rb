FactoryBot.define do
  factory :item_tag do
    name { '時計' }
    product_description { '壁掛け時計' }
    status_id { 2 }
    cover_delivery_cost_id { 2 }
    prefecture_id { 2 }
    delivery_id { 2 }
    price { 1000 }
    tag_name { '新品,春物' }
    user_id { FactoryBot.create(:user).id }

    category_id do
      grandchild_category = FactoryBot.create(:category,
                                              parent: FactoryBot.create(:category, parent: FactoryBot.create(:category)))
      grandchild_category.id
    end

    image do
      Rack::Test::UploadedFile.new(Rails.root.join('public/images/test_image.png'), 'image/png')
    end
  end
end
