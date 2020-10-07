# README

# アプリケーション名

<h1><b>Pitch_test</b></h1>

# アプリケーション概要

<b>＊＊注意：このアプリでは音がでます＊＊</b><br>
音程当てクイズに挑戦することができます。<br>
また、音当てクイズに挑戦する前に、音程の確認をすることもできます。<br>
ユーザ登録をすることで、正解数、正答率、正解までにかかった時間の平均が記録され、ランキングに参加することができます。<br>
ランキングは全6種類です。<br>
正解数、正答率、正解までにかかった時間の平均ごとにランキングがあり、それぞれの項目に対し、累計値のランキングと今日のランキングが存在します。<br>

# URL

https://pitch-test.herokuapp.com/

# テスト用アカウント

ニックネーム：sample<br>
パスワード：123456<br>

# 目指した課題解決

「メロディを聴いただけで、楽器で再現ができるようになりたい」、「音名を言われた時に、すぐにその音を歌えるようになりたい」といった、音感を身に付けたい方を対象にこのアプリを開発しました。<br>
また、音感は一朝一夕では身に付けられません。日々のモチベーションを維持するために、ランキング機能を実装しました。<br>
今までの努力を可視化するために、累計値のランキングを、日課にすることができるように、今日のランキングを実装しています。<br>

# 洗い出した要件

|機能|目的|詳細|
|---|---|---|
|音程確認機能|ユーザが正しいピッチを知ることができるようにするため。|音を指定することで、マイクから指定された音を出力する。音の指定方法は、ボタンにする。現在は1オクターブを実装。実装はtone.jsを使用。|
|クイズ機能|ランダムで出力された音の音名を考えることで、音感を鍛えるため|ランダムで出力された音がどの音かをボタンで指定する。解答に合わせて、正誤の表示とチャイムを鳴らす。|
|ユーザ登録機能|ユーザごとにクイズのスコアを記録するため。|トップページからユーザ登録をできるようにする。登録済みのユーザは、クイズ時に、正答率を記録する。登録するのは、ユーザ名とパスワードのみ。|
|スコア管理機能|ユーザごとのクイズのスコアを記録するため。|クイズをするたびに、正解数・誤答数・正答率・累計時間・正解までにかかった時間の平均を更新する。また、ユーザ登録からの累計と、日毎のデータの2種類を保存・表示する。|
|ランキング機能|ユーザ全体の記録を確認するため|トップページで正解数、正答率、正解までにかかった時間の平均に関するランキングを見ることができる。ユーザ登録から今までの累計のランキング、その日のランキングを表示する。|

# 利用方法

# 今後の予定

- 音色の追加
- 音域の追加
- 基準周波数の変更機能の追加
- viewの編集
- ユーザごとのProgressChart表示機能の追加

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
|user|references|null: false, foreign_key: true, index: {unique: true}|
|total_correct_count|integer|null: false|
|total_wrong_count|integer|null: false|
|total_correct_rate|integer|null: false|
|total_time|float|null: false|
|total_average_time|float|null: false|

### アソシエーション

- belongs_to :user

### アソシエーション

- has_one :total_score
- has_many :daily_score

## daily_scoresテーブル

|Column|Type|Options|
|---|---|---|
|user|references|null: false, foreign_key: true|
|daily_correct_count|integer|null: false|
|daily_wrong_count|integer|null: false|
|daily_correct_rate|integer|null: false|
|daily_time|float|null: false|
|daily_average_time|float|null: false|

### アソシエーション

- belongs_to :user

# ローカルでの動作方法

## 環境

ruby 2.6.6<br>
rails 6.0.3.3<br>

## 使用したJavaScriptライブラリ

Tone.js

## コマンド

`git clone https://github.com/mark0802-prog/pitch_test.git`
`cd pitch_test`
`bundle install`
`yarn install`
`rails db:create`
`rails db:migrate`
`rails s`
http://localhost:3000 にアクセス<br>

### 補足

- Tone.jsのダウンロードは、以下のコマンドで実施できます。<br>
npm install tone

- Tone.jsのurl
https://tonejs.github.io/
