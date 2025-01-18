# テーブル設計

## users テーブル

| Column              | Type   | Options                   |
| ------------------- | ------ | --------------------------|
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| last_name           | string | null: false               |
| first_name          | string | null: false               |
| last_name_furigana  | string | null: false               |
| first_name_furigana | string | null: false               |
| birth               | date   | null: false               |

### Association

- has_many :items
- has_many :buys


## items テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| name                   | string     | null: false                    |
| product_description    | text       | null: false                    |
| category_id            | integer    | null: false                    |
| status_id              | integer    | null: false                    |
| cover_delivery_cost_id | integer    | null: false                    |
| region_id              | integer    | null: false                    |
| delivery_id            | integer    | null: false                    |
| price                  | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- has_one    :buys

## buys テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items
- has_one    :deliverys

## deliverys テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| post_code           | string     | null: false                    |
| prefecture          | string     | null: false                    |
| municipality        | string     | null: false                    |
| street_address      | string     | null: false                    |
| building_name       | string     |                                |
| telephone_number    | string     | null: false                    |
| buy                 | references | null: false, foreign_key: true |

### Association

- belongs_to :buys