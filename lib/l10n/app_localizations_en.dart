// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Narou Reader';

  @override
  String get searchTab => 'Search';

  @override
  String get feedTab => 'Feed';

  @override
  String get savedTab => 'Saved';

  @override
  String get settingsTab => 'Settings';

  @override
  String get searchTitle => 'Search';

  @override
  String get searchHint => 'Enter a keyword';

  @override
  String get searchNoResults => 'No search results';

  @override
  String searchError(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String get saveAction => 'Save';

  @override
  String get savedListTitle => 'Saved list';

  @override
  String get savedListEmpty => 'No saved items.';

  @override
  String savedListError(Object error) {
    return 'Error: $error';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get deleteAllTitle => 'Delete all data';

  @override
  String get deleteAllSubtitle =>
      'Delete all data in the saved list. Deleted data cannot be restored.';

  @override
  String get deleteAllDialogTitle => 'Delete all data?';

  @override
  String get deleteAllDialogContent => 'All saved data will be deleted.';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get detailTitle => 'Detail';

  @override
  String get saveSuccess => 'Saved successfully';

  @override
  String get saveFailed => 'Please try again';

  @override
  String authorLabel(Object author) {
    return 'Author: $author';
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
  String get savedItemDeleteConfirmTitle => 'Delete this item?';

  @override
  String get savedItemDeleteConfirmContent => 'This item will be deleted.';

  @override
  String get delete => 'Delete';

  @override
  String openUrlFailed(Object url) {
    return 'Cannot open URL: $url';
  }

  @override
  String operationError(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String get writerLabel => 'Author';

  @override
  String get ncodeFieldLabel => 'Ncode';

  @override
  String get biggenreLabel => 'Category';

  @override
  String get genreLabel => 'Genre';

  @override
  String get keywordsLabel => 'Keywords';

  @override
  String get novelTypeLabel => 'Type';

  @override
  String get lengthLabel => 'Length';

  @override
  String get readTimeLabel => 'Reading time';

  @override
  String get globalPointLabel => 'Rating';

  @override
  String get favNovelCuntLabel => 'Bookmarks';

  @override
  String get firstUpLabel => 'First published';

  @override
  String get lastUpLabel => 'Last updated';

  @override
  String lengthValue(Object value) {
    return '$value chars';
  }

  @override
  String readTimeValue(Object value) {
    return '$value min';
  }

  @override
  String globalPointValue(Object value) {
    return '${value}pt';
  }
}
