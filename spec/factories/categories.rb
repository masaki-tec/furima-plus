FactoryBot.define do
  factory :category do
    name { '親カテゴリ' }
    ancestry { nil } # 親カテゴリはancestryなし

    # 子カテゴリ
    factory :child_category do
      name { '子カテゴリ' }
      ancestry { nil } # 後で親IDをセット
      after(:create) do |child, evaluator|
        # 親カテゴリを作成してancestryを設定
        parent = create(:category)
        child.update(ancestry: parent.id.to_s)
      end
    end

    # 孫カテゴリ
    factory :grandchild_category do
      name { '孫カテゴリ' }
      ancestry { nil } # 後で親/子IDをセット
      after(:create) do |grandchild, evaluator|
        # 親と子を作成
        parent = create(:category)
        child = create(:category, ancestry: parent.id.to_s)
        grandchild.update(ancestry: child.id.to_s)
      end
    end
  end
end
