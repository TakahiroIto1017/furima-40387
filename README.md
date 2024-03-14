# 機能

| 機能        | コントローラー | アクション    | ビュー     |
| ----------- | ------------- | ------------ | --------- |
| ユーザー管理 | users         | show         | (device)  |
| 商品出品     | items         | new, create  | new       |
| 商品一覧表示 | items         | index        | index     |
| 商品詳細表示 | items         | show         | show      |
| 商品情報編集 | items         | edit, update | show, edit |
| 商品削除     | items         | destroy      | show       |
| 商品購入     | orders        | create       |            |

# テーブル設計

## items テーブル

| Column          | Type       | Options, Memo                  |
| --------------- | ---------- | ------------------------------ |
| image           | ////////// | ActiveStorage, 入力必須         |
| title           | string     | null: false, limit: 40         |
| description     | text       | null: false, limit: 1000       |
| category        | ////////// | ActiveHash, 入力必須            |
| condition       | ////////// | ActiveHash, 入力必須            |
| shipping_cost   | ////////// | ActiveHash, 入力必須            |
| shipping_origin | ////////// | ActiveHash, 入力必須            |
| shipping_date   | ////////// | ActiveHash, 入力必須            |
| price           | decimal    | null: false, 300~9999999       |
| user_id         | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_one :order

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_guide   | string | null: false               |
| last_name_guide    | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :orders


## orders テーブル

| Column           | Type   | Options             |
| ---------------- | ------ | ------------------- |
| postal_code      | string | null: false         |
| prefectures      | ////// | ActiveHash, 入力必須 |
| Municipality     | string | null: false         |
| house_number     | string | null: false         |
| building_name    | string |                     |
| telephone_number | string | null: false         |

### Association

- belongs_to :user
- belongs_to :item



