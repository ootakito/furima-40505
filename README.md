今回フリマアプリのモデリングを行います。初めてなのでご指摘の程よろしくお願いします。

　　〜DB設計の大まかな概要です。〜

　　　　🔸ユーザー管理機能（users table）
　　　　　・名前登録
　　　　　・Eメール登録
　　　　　・パスワード設定

　　　　🔸商品出品機能 （products table）

　　　　　　・商品名
　　　　　　・商品説明欄
　　　　　　・値段
　　　　　　・商品画像
　　　　　　・お客様と商品を関連付けるキー
　　　　
　　　　🔸商品購入機能 （orders table）

　　　　　・購入の為にユーザーと関連付けるキー
　　　　　・出品された物を購入する為のキー
　　　　　・数量
　　　　　・総額
　　　　　・注文

ER.dioにてt.timestamps以外は各テーブル事に上から羅列して行き必要な場合は追記で書きます。
アソシエーションはbelongs_to has_many で表現します。

DB設計をします。

## users table

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| id                 | integer| null: false, primary_key: true|
| username           | string | null: false |
| email              | string | null: false, unique: true |
| password_digest    | string | null: false |
| created_at         | datetime| null: false |
| updated_at         | datetime| null: false |

### Association

- has_many :products, dependent: :destroy 
- has_many :orders, dependent: :destroy    

## products table

| Column             | Type    | Options                        |
| ------------------ | ------- | ------------------------------ |
| id                 | integer | null: false, primary_key: true|
| name               | string  | null: false                    |
| description        | text    |                                |
| price              | integer | null: false                    |
| image_url          | string  |                                |
| user_id            | integer | null: false, foreign_key: true |
| created_at         | datetime| null: false                    |
| updated_at         | datetime| null: false                    |

### Association

- belongs_to :user 
- has_many :orders, dependent: :destroy 

## orders table

| Column             | Type    | Options                        |
| ------------------ | ------- | ------------------------------ |
| id                 | integer | null: false, primary_key: true|
| user_id            | integer | null: false, foreign_key: true |
| product_id         | integer | null: false, foreign_key: true |
| quantity           | integer |                                |
| total_price        | decimal | precision: 10, scale: 2        |
| status             | string  | null: false                    |
| created_at         | datetime| null: false                    |
| updated_at         | datetime| null: false                    |

### Association

- belongs_to :user    
- belongs_to :product 





　　　　
　
　　　　　