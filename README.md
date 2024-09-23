# naroureader

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# NarouReader(予定)
なろう小説のアプリ版っぽいものを作っています。実用性というより個人の学習用なので完全に自己満足です。将来的にはApp Storeに出す予定ですか、developerアカウントって高いのでだいぶ先になりそうです。
このアプリはなろう小説APIを使用しています。
URL(https://dev.syosetu.com/man/api/#link6)
↑公式ドキュメント
# このアプリで実装した機能
- 作品の検索
- 作品の詳細情報(タイトル、著者名、storyなど)
# まもなく利用可能
- ブックマーク機能
# このアプリで実装したい機能
- ダークモード
- webviewを使って検索した作品に直接飛べるようにする
- ホーム画面をダッシュボード機能を追加
- firebaseを利用した機能(クラウド同期とGoogleでサインイン)
- iOSウィジェット
- iPadOSに最適化されたUI
# ディレクトリのメモ
lib/
├── main.dart
├──database/
    └── savedList_model.dart
    └── savedList_helper.dart
├── models/
│   └── post.dart
├── services/
│   └── api_service.dart
└── screens/
    └── home_screen.dart
    └── detailPage.dart
    └──sacedListPage.dart



