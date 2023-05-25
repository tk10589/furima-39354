# README

* Ruby version
rails _6.0.0_

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| fname              | string | null: false               |
| lname              | string | null: false               |
| fname_kana         | string | null: false               |
| lname_kana         | string | null: false               |
| birthdate          | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| item             | string     | null: false                    |
| item_description | text       | null: false                    |
| category_id      | integer    | null: false                    |
| item_condition_id| integer    | null: false                    |
| shipbase_id      | integer    | null: false                    |
| shiparea_id      | integer    | null: false                    |
| shipdate_id      | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :delivery

## deliveries テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postalcode       | string     | null: false                    |
| shiparea_id      | integer    | null: false                    |
| shipcity         | string     | null: false                    |
| shipaddress      | string     | null: false                    |
| apartment        | string     |                                |
| phone_number     | string     | null: false                    |
| order            | references | null: false, foreign_key: true |

### Association

- belongs_to :order
