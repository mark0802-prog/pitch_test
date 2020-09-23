# README

# テーブル設計

## usersテーブル

|Column|Type|Options|
|---|---|---|
|nickname|string|null: false, unique: true|
|password|string|null: false|
|password_confirmation|string|null: false|

### アソシエーション

- has_one :total_score
- has_many :daily_score

## total_scoresテーブル

|Column|Type|Options|
|---|---|---|
|user|references|null: false, foreign_key: true|
|total_correct_count|integer|null: false|
|total_wrong_count|integer|null: false|
|total_time|integer|null: false|

### アソシエーション

-belongs_to :user

### アソシエーション

- has_one :total_score
- has_many :daily_score

## daily_scoresテーブル

|Column|Type|Options|
|---|---|---|
|user|references|null: false, foreign_key: true|
|daily_correct_count|integer|null: false|
|daily_wrong_count|integer|null: false|
|daily_time|integer|null: false|

### アソシエーション

-belongs_to :user
