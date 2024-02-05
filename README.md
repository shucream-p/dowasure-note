# ど忘れノート
![ど忘れノートREADME](https://github.com/shucream-p/dowasure-note/assets/88083085/2998bf44-d6e9-472c-a1d5-3bead7c1c1cf)

## サービス概要
[ど忘れノート](https://dowasure-note.com/)は、ど忘れしやすい名前や名称を関連ワードと一緒に登録できるサービスです。  
名前が思い出せなくても関連ワードを入力することで、インクリメンタルサーチによるすばやい検索が可能です。

## サービスURL
https://dowasure-note.com/

## 使い方
### 1. メールアドレスでアカウント登録する。

<img width="30%" alt="メモ登録" src="https://github.com/shucream-p/dowasure-note/assets/88083085/50029cc6-81a2-4fee-9dcd-cf99edcaa0bd">

### 2. メモを新規登録する  
キーワードタグ欄には、その名前を思い出そうとする際に出てくる関連ワードを入力してください。  

<img width="30%" alt="メモ登録" src="https://github.com/shucream-p/dowasure-note/assets/88083085/4e89842d-9c2d-4655-b970-550791ffb1ff">

### 3. キーワードタグを入力して名前を検索する

<img width="30%" alt="メモ検索" src="https://github.com/shucream-p/dowasure-note/assets/88083085/3109dc7c-da57-401b-8b41-44da621cd5c7">

※名前であいまい検索も可能です。

## 使用技術
- Ruby 3.2.2
- Ruby on Rails 7.0.8
- Hotwire
- Tailwind CSS 3.3.3

## 開発環境構築
```
$ git clone https://github.com/shucream-p/dowasure-note.git
$ cd dowasure-note
$ bin/setup
```

## 起動
```
$ bin/dev
```

## Lint/Test
### Lint
```
$ bin/lint
```

実行されるlint
- Ruby
  - rubocop
  - slim-lint
- JavaScript
  - eslint
  - prettier

### Test
```
$ bundle exec rspec
```
