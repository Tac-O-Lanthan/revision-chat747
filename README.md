# 校正チャット
https://revision-chat747-33053on90.herokuapp.com/  
(このアプリは作成中です)

![メインページ](https://user-images.githubusercontent.com/75772499/109477950-fd2d2780-7abb-11eb-97db-11ef2e3ca774.png)

## 概要
- 校正チャットは、イラストや写真を修正・確認するやりとり（校正）に特化したチャットアプリです。  
シンプルなインタフェースのため、アプリ操作が苦手な方でもかんたんにご利用いただけます。
- 本アプリは、技術的なスキルアップのためのアプリです。

## ルームを管理する機能（開発中）
| 機能 | 概要 |
| :--- | :--- |
| ユーザー管理機能 | 本アプリにサインイン・ログイン・ログアウトできます |
| ルーム作成機能 | パスワードとメンバーを設定して、ルームを作成します |
| ルーム入室機能 | 専用ページでパスワードを入力し、ルームページへ遷移します |
| ルーム削除機能 | 入室しているルームを削除できます |
| メンバー招待機能 | 入室しているルームに、新しいメンバーを招待できます |
- メンバーの招待はユーザー名の完全一致入力でのみ可能で、予測検索はできません。  
- 入室パスワードや招待するユーザー名を、アプリの中で教え合う機能はありません。  
チャットで発言することはできますが、誤送信・悪意のアクセスを防止するため推奨されません。  

## チャットを利用する機能（開発中）
| 機能 | 概要 |
| :--- | :--- |
| チャット機能 | 非同期通信でチャット会話ができます |
| 画像アップロード機能 | ルーム単位で画像をアップロードできます |
- 画像には、「校正１回目」「２校」「Aパターン」など予め用意されたタグを付与できます。  
タグを付与した場合、画面左の操作メニューに画像を表示するリンクがタグ名で表示されます。

## 企画テーマ
- `業務効率化`  
非同期通信チャットによってメールよりも早いレスポンスが期待できます。  
資料はタグからすぐに確認できるので、紙媒体や別フォルダーから探す必要はなく、紛失の恐れもありません。
- `単純さ`  
アプリの使い方を覚えるのが苦手な方でも、使いやすいアプリが作れないかと考えました。  
フォントを大きく、説明を詳しく、機能をシンプルに作り、直感的な使いやすさを重視しました。  
- `PPAP対策`  
昨今のPPAP（ZIPデータのメール送信とパスワード後送）が抱えるセキュリティ問題への対策になります。  
「招待」と「入室」の二段階に認証を必要とするので、誤送信・悪意のアクセスを予防できます。

## 開発環境
| ソフトウェア |
| :--- |
| VScode |
| Ruby 2.6.5p114 |
| Rubygems 3.0.3 |
| Rails 6.0.3.4 |
| mysql2 0.5.3 |
| HTML/CSS |
| JavaScript |
| heroku 7.49.1 |
| git 2.24.3 |

# データベース設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| user_name          | string  | null: false, unique: true |
| full_name          | string  | null: false               |
| corp_name          | string  | null: false               |
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
