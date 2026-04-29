# NarouReader

NarouReader は「小説家になろう」の作品を読むための Flutter アプリです。
学習目的の個人プロジェクトとして、Narou API を使ったデータ取得や Flutter の実装パターンを試しています。

## 主な機能

- **作品情報の取得**: タイトルや作者などの情報を Narou API から取得
- **ブックマーク**: お気に入り作品を保存して一覧で確認
- **今後の拡張**: 追加予定の機能は Issues で管理
- **ダークモード**: 検索やフィード画面でもダークモードをサポートいています。スマートフォンの消費電力を抑え(OLEDのみ)、暗い場所でも快適に閲覧できます。

## 間も無く登場
次回バージョンにて、以下の機能を実装する予定。
- **フォード機能**: 新作の小説を簡単に確認
- **ランキング**: 人気小説をアプリから簡単に確認
- **検索**: 保存した小説を簡単に検索
- **ダッシュボード**: 最近保存したアイテム、フォードの一部、ランキングへと簡単にアクセス
 

## 使い始め方

### 前提条件

- Flutter SDK
- 対応プラットフォーム向けの開発環境（Android / iOS / Web など）

### セットアップ

```bash
flutter pub get
```

### 起動

```bash
flutter run
```

## ディレクトリ構成

```
lib/
├── main.dart
├── database/
│   └── post.dart
├── services/
│   └── api_service.dart
└── screens/
    ├── home_screen.dart
    ├── detailPage.dart
    ├── savedListPage.dart
    └── savedlistscreen_detailPage.dart
```

## 参考リンク

- Flutter 公式チュートリアル: https://docs.flutter.dev/get-started/codelab
- Flutter Cookbook: https://docs.flutter.dev/cookbook
- なろう小説APIの公式ドキュメント: https://dev.syosetu.com

## 使用パッケージ

### Dependencies

- http
- flutter_riverpod
- sqflite
- flutter_slidable
- url_launcher
- cupertino_icons

### Dev Dependencies

- flutter_test
- flutter_lints

