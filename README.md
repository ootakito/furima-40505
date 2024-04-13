今回フリマアプリのモデリングを行います。初めてなのでご指摘の程よろしくお願いします。

　

ER.dioにてt.timestamps以外は各テーブル事に上から羅列して行き必要な場合は追記で書きます。
アソシエーションはbelongs_to has_many has_oneで表現します。

DB設計をします。

## users table

| Column          | Type    | Options               |
| --------------- | ------- | --------------------- |
| nickname        | string  | null: false           |
| last_name       | string  | null: false           |
| first_name      | string  | null: false           |
| last_name_kana  | string  | null: false           |
| first_name_kana | string  | null: false           |
| email           | string  | null: false   unique: true        |
| encrypted_password | string  | null: false           |
| birthdate       | date    | null: false           |

### Association

- has_many :items, dependent: :destroy 
- has_many :orders, dependent: :destroy    

## items table

| Column               | Type    | Options               |
| -------------------- | ------- | --------------------- |
| name                 | string  | null: false           |
| description          | text    | null: false           |
| category_id          | integer | null: false           |
| condition_id         | integer | null: false           |
| shipping_cost_burden_id | integer | null: false           |
| shipping_region_id   | integer | null: false           |
| shipping_duration_id | integer | null: false           |
| price                | integer | null: false           |


### Association

- belongs_to :user 
- has_one :orders, dependent: :destroy 

## orders table

| Column          | Type    | Options               |
| --------------- | ------- | --------------------- |
| item_name       | string  | null: false           |
| item_price      | integer | null: false           |
| shipping_cost   | string  | null: false           |
| total_price     | integer | null: false           |
| credit_card_info| string  | null: false           |
| expiration_date | string  | null: false           |
| security_code   | string  | null: false           |
| postal_code     | string  | null: false           |
| prefecture      | string  | null: false           |
| city            | string  | null: false           |
| address         | string  | null: false           |
| building        | string  |                       |
| phone_number    | string  | null: false           |
| user_id         | integer | null: false, foreign_key: true |
| item_id         | integer | null: false, foreign_key: true |

### Association

- belongs_to :user    
- belongs_to :item

## addresses table


| Column        | Type    | Options                         |
| ------------- | ------- | ------------------------------- |
| postal_code   | string  | null: false                     |
| prefecture_id | integer | null: false, foreign_key: true  |
| city          | string  | null: false                     |
| address       | string  | null: false                     |
| building      | string  |                                 |
| phone_number  | string  | null: false                     |
| order_id      | integer | null: false, foreign_key: true  |


### Association
- belongs_to :order








