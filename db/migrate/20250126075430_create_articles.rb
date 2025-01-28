class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.integer    :category_id              , null: false
      t.integer    :status_id                , null: false
      t.integer    :cover_delivery_cost_id   , null: false
      t.integer    :prefecture_id            , null: false
      t.integer    :delivery_id              , null: false
      t.timestamps
    end
  end
end

