// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'なろうリーダー';

  @override
  String get searchTab => '検索';

  @override
  String get feedTab => 'フィード';

  @override
  String get savedTab => '保存';

  @override
  String get settingsTab => '設定';

  @override
  String get searchTitle => '検索';

  @override
  String get searchHint => 'キーワードを入力';

  @override
  String get searchNoResults => '検索結果がありません';

  @override
  String searchError(Object error) {
    return 'エラーが発生しました: $error';
  }

  @override
  String get saveAction => '保存';

  @override
  String get savedListTitle => '保存リスト';

  @override
  String get savedListEmpty => '保存されたアイテムがありません。';

  @override
  String savedListError(Object error) {
    return 'エラー: $error';
  }

  @override
  String get settingsTitle => '設定';

  @override
  String get deleteAllTitle => '全てのデータを削除';

  @override
  String get deleteAllSubtitle => '保存リスト内のデータを全て削除します。削除したデータは元に戻せません。';

  @override
  String get deleteAllDialogTitle => '全てのデータを削除しますか？';

  @override
  String get deleteAllDialogContent => '保存した全てのデータが削除されます。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get ok => 'OK';

  @override
  String get detailTitle => '詳細ページ';

  @override
  String get saveSuccess => '正常に保存できました';

  @override
  String get saveFailed => 'もう一度試してください';

  @override
  String authorLabel(Object author) {
    return '作者: $author';
  }

  @override
  String urlLabel(Object ncode) {
    return 'URL: https://ncode.syosetu.com/$ncode';
  }

  @override
  String ncodeLabel(Object ncode) {
    return 'Ncode: $ncode';
  }

  @override
  String get savedItemDeleteConfirmTitle => 'このアイテムを削除しますか？';

  @override
  String get savedItemDeleteConfirmContent => 'このアイテムは削除されます。';

  @override
  String get delete => '削除';

  @override
  String openUrlFailed(Object url) {
    return 'URLを開けません: $url';
  }

  @override
  String operationError(Object error) {
    return 'エラーが発生しました: $error';
  }

  @override
  String get writerLabel => '著者';

  @override
  String get ncodeFieldLabel => 'Nコード';

  @override
  String get biggenreLabel => '大カテゴリ';

  @override
  String get genreLabel => 'カテゴリ';

  @override
  String get keywordsLabel => 'キーワード';

  @override
  String get novelTypeLabel => '種類';

  @override
  String get lengthLabel => '文字数';

  @override
  String get readTimeLabel => '読書時間';

  @override
  String get globalPointLabel => '総合評価ポイント';

  @override
  String get favNovelCuntLabel => 'ブックマーク数';

  @override
  String get firstUpLabel => '初回掲載日';

  @override
  String get lastUpLabel => '最終掲載日';

  @override
  String lengthValue(Object value) {
    return '$value字';
  }

  @override
  String readTimeValue(Object value) {
    return '$value分';
  }

  @override
  String globalPointValue(Object value) {
    return '${value}pt';
  }
}
