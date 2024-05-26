# README

## users テーブル : device 使用

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| read_first         | string | null: false               |
| read_last          | string | null: false               |
| birthday           | date   | null: false               |

has_many : items
has_many : transactions

## items テーブル (出品情報)

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| item_name        | string     | null: false                    |
| item_description | text       | null: false                    |
| category_id      | integer    | null: false                    |
| condition_id     | integer    | null: false                    |
| burden_id        | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| days_id          | integer    | null: false                    |
| price            | integer    | null: false                    |

belongs_to : user
has_one : transaction
has_one_attached : image (Active Storage)

## transactions テーブル (購入履歴)

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

belongs_to : user
belongs_to : item
has_one : address

## addresses テーブル (受取先情報)

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| transaction    | references | null: false, foreign_key: true |
| postcode       | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| municipalities | string     | null: false                    |
| address        | string     | null: false                    |
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |

belongs_to : transaction

※未設定（フリマの見本アプリ反映未確認）
コメント
ブランド
お気に入り
etc…
