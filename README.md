# 課題プロダクト

## お題: MUSIC SNS!!

iTunseAPI を使った投稿型 SNS サービス

## 出題形式

難易度を basic / standard / advanced の 3 つの段階に分けて出題します

### basic

- https://la-musicsns-basic.herokuapp.com/
- iTunseAPI を使ってユーザーに紐づいた投稿ができる（1:n, 外部 API）
- 最低限クリアしてほしいレベルです。期日中に絶対終わらせてきてください。

### standard

- https://la-musicsns-standard.herokuapp.com/
- いいね機能（n:n）
- スクールメンターとして多対多は理解してほしいので、期日までに終わらなくても、研修が終わるまでには絶対に終わらせてほしいレベル感
- ただ、ショッピングで多対多を学ぶのはかなり難しいので、この課題のいいね機能を使って多対多を理解しよう

### advanced

- https://la-musicsns-advanced.herokuapp.com/
- フォロー機能（n:n）
- Twitter 認証（できる人のみ）

# 設計

## UI 設計（ページ,コンポーネント設計）

- `layout.erb`
  - [ ] ナビゲーションバー
    - [ ] ログイン状態に合わせた表示
    - [ ] プロフィール画像の表示
  - [ ] yield を使った表示
- `index.erb`
  - [ ] 全ての投稿の一覧表示
  - [ ] 投稿のなかにアーティスト名やユーザー名，コメントを表示
  - [ ] ユーザーのログインフォーム
  - [ ] 新規登録リンク（できる人は Twitter 認証に置き換え）
- `sign_up.erb`
  - [ ] ユーザーの新規登録のフォーム
- `search.erb`
  - [ ] 音楽検索フォーム
  - [ ] 検索結果一覧の表示
    - [ ] 検索結果に合わせた表示
  - [ ] コメントフォーム
  - [ ] 投稿の新規作成ボタンが作れているか
    - [ ] input:type ＝ hidden
- `home.erb`
  - [ ] ユーザーに紐づいた投稿の一覧表示
  - [ ] 投稿の削除リンク
  - [ ] 投稿の編集リンク
- `edit.erb`
  - [ ] 投稿の編集フォーム
    - [ ] placeholder に編集前の内容を表示

## URI 設計（コントローラ）

- `get "/"`
  - [ ] 投稿の取得
  - [ ] 投稿の一覧表示機能が出来ている（`index.erb`）
- `get "/sign_up"`
  - [ ] ユーザーの新規登録フォームの表示（`sign_up.erb`）
- `post "/sign_up"`
  - [ ] ユーザーの新規登録機能ができている
  - [ ] 画像のアップロードができている
  - [ ] アップロードした画像 URL を保存できている
- `post "/sign_in"`
  - [ ] ユーザーのログイン機能ができている（session）
    - [ ] `/top`と`/home`はログインしていない場合、`/sing_up`へリダイレクトする
    - [ ] `helper`を使ってユーザーのログイン状態の管理をしている
- `get "/search"`
  - [ ] 検索フォームと検索一覧の表示（`search.erb`）
- `post "/search"`
  - [ ] API 検索機能
    - [ ] JSON を適切に操作する
- `post "/new"`
  - [ ] 投稿の新規作成機能
- `get "/home"`
  - [ ] ユーザーに紐づいた投稿の表示（`home.erb`）
- `get "/edit/:id"`
  - [ ] 投稿の編集フォームが表示できている（`edit.erb`）
- `post "/update/:id"`
  - [ ] 投稿の更新機能
- `post "/delete/:id"`
  - [ ] 投稿の削除機能

## 実装の参考に

### 準備

- 必要な gem は Gemfile に記述してあります
- 最低限の HTML, CSS は準備してあります
- 必要に応じて seed データを用意してください
- [ ] rake コマンドが使えるようになっているか
  - [ ] Rakefile の作成
  - [ ] models.rb の作成
- [ ] マイグレーションファイルを設計の通り作れているか
- [ ] 投稿用のモデルおよびデータベースのテーブルが作れているか
- [ ] ユーザー用のモデルおよびデータベースのテーブルが作れているか
- [ ] 投稿モデルとユーザーモデルの連携が出来ているか

### デザイン

- [ ] ナビゲーションバー
  - [ ] プロフィール画像の border-radius を指定できているか（丸くする）
  - [ ] img タグを適切に使えているか
- [ ] `index.erb`にファーストビューを作れているか
  - [ ] background-size: cover;
  - [ ] background-repeat: no-repeat;
- [ ] flexbox を使って中央揃えができているか
  - [ ] flex-direction: column;
  - [ ] justify-content: center;
- [ ] webfont を使って font-family を設定できているか
