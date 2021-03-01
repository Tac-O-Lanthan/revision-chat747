# 校正チャット

![メインページ](https://user-images.githubusercontent.com/75772499/109477950-fd2d2780-7abb-11eb-97db-11ef2e3ca774.png)

### 概要
- 校正チャットは、イラストや写真を修正・確認するやりとり（校正）に特化したチャットアプリです。
シンプルなインタフェースのため、アプリ操作が苦手な方でもかんたんにご利用いただけます。

### 機能
- 画面上部のヘッダーから、ユーザーのログイン・ログアウトができます。
- 画面左の操作メニューから、チャットルームが作成できます。
- 画面右のルーム一覧から、チャットルーム（専用ページ）へ入室できます。
入室には、ルーム作成時に決められたパスワードが必要です。
- 入室時はチャットの他、ルームの削除、メンバーの招待、画像のアップロード・削除ができます。
- 画像には、「校正１回目」「２校」「Aパターン」など予め用意されたタグを付与できます。
タグを付与した場合、画面左に画像を表示するリンクがタグ名で表示されます。

### 企画
- 多機能アプリが使いこなせない方でも、アプリを利用した業務効率化ができないかと考えました。
フォントを大きく、機能ごとの説明を詳しく、機能をシンプルに作り、直感的な使いやすさを重視しました。
- 昨今のPPAP（ZIPデータのメール送信とパスワード後送）が抱えるセキュリティ問題への対策になります。
「招待」と「入室」の二段階に認証を必要とするので、誤送信・悪意のアクセスを予防できます。
- 非同期通信チャットによってメールよりも早いレスポンスが期待できます。
資料はタグからすぐに確認できるので、紙媒体や別フォルダーから探す必要はなく、紛失の恐れもありません。


# データベース

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
