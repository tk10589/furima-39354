# README

* Ruby version
rails _6.0.0_

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false, unique: true |
| email              | string | null: false               |
| encrypted_password | string | null: false               |
| fname              | text   | null: false               |
| lname              | text   | null: false               |
| fname_kana         | text   | null: false               |
| lname_kana         | text   | null: false               |
| birthdate          | text   | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| item             | string     | null: false                    |
| item_description | text       | null: false                    |
| category         | text       | null: false                    |
| item_condition   | text       | null: false                    |
| shipbase         | text       | null: false                    |
| shiparea         | text       | null: false                    |
| shipdate         | text       | null: false                    |
| price            | text       | null: false                    |
| user_id          | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_many :orders

## orders テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user_id      | references | null: false, foreign_key: true |
| item_id      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :delivery

## deliverys テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postalCode       | string     | null: false                    |
| shipregion       | text       | null: false                    |
| shipcity         | text       | null: false                    |
| shipaddress      | text       | null: false                    |
| apartment        | text       | null: false                    |
| shiparea         | text       | null: false                    |
| shipdate         | text       | null: false                    |
| phone_number     | text       | null: false                    |
| user_id          | references | null: false, foreign_key: true |
| item_id          | references | null: false, foreign_key: true |

### Association

- belongs_to :order
