# README

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| user_name           | string  | null: false, unique: true |
| full_name           | string  | null: false               |
| corp_name           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
<!-- user_nameは検索に用いるため一意性である -->
<!-- passwordは正規表現で英数6字〜20字程度を求める -->

### Association

- has_many :room_users
- has_many :rooms, through: :room_users

## rooms テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| room_name          | string  | null: false, unique: true |
| password_digest    | string  | null: false               |
<!-- room_nameは誤ったアクセスを防ぐため一意性である -->
<!-- has_secure_passwordを使って暗号化PWを使用する -->

### Association

- has_many :room_users, dependent: :destroy
- has_many :users, through: :room_users  

## room_users テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user

## massages テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| content            | text    | null: false               |
| user               | references | null: false, foreign_key: true |
| room               | references | null: false, foreign_key: true |
<!-- has_secure_passwordを使って暗号化PWを使用する -->
<!-- pdf画像の保存は追って実装 -->

### Association

- belongs_to :room
- belongs_to :user
