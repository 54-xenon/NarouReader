import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Narou Reader'**
  String get appTitle;

  /// No description provided for @searchTab.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTab;

  /// No description provided for @feedTab.
  ///
  /// In en, this message translates to:
  /// **'Feed'**
  String get feedTab;

  /// No description provided for @savedTab.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get savedTab;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a keyword'**
  String get searchHint;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No search results'**
  String get searchNoResults;

  /// No description provided for @searchError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String searchError(Object error);

  /// No description provided for @saveAction.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveAction;

  /// No description provided for @savedListTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved list'**
  String get savedListTitle;

  /// No description provided for @savedListEmpty.
  ///
  /// In en, this message translates to:
  /// **'No saved items.'**
  String get savedListEmpty;

  /// No description provided for @savedListError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String savedListError(Object error);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @deleteAllTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get deleteAllTitle;

  /// No description provided for @deleteAllSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all data in the saved list. Deleted data cannot be restored.'**
  String get deleteAllSubtitle;

  /// No description provided for @deleteAllDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all data?'**
  String get deleteAllDialogTitle;

  /// No description provided for @deleteAllDialogContent.
  ///
  /// In en, this message translates to:
  /// **'All saved data will be deleted.'**
  String get deleteAllDialogContent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @detailTitle.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get detailTitle;

  /// No description provided for @saveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get saveSuccess;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get saveFailed;

  /// No description provided for @authorLabel.
  ///
  /// In en, this message translates to:
  /// **'Author: {author}'**
  String authorLabel(Object author);

  /// No description provided for @urlLabel.
  ///
  /// In en, this message translates to:
  /// **'URL: https://ncode.syosetu.com/{ncode}'**
  String urlLabel(Object ncode);

  /// No description provided for @ncodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Ncode: {ncode}'**
  String ncodeLabel(Object ncode);

  /// No description provided for @savedItemDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this item?'**
  String get savedItemDeleteConfirmTitle;

  /// No description provided for @savedItemDeleteConfirmContent.
  ///
  /// In en, this message translates to:
  /// **'This item will be deleted.'**
  String get savedItemDeleteConfirmContent;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @openUrlFailed.
  ///
  /// In en, this message translates to:
  /// **'Cannot open URL: {url}'**
  String openUrlFailed(Object url);

  /// No description provided for @operationError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String operationError(Object error);

  /// No description provided for @writerLabel.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get writerLabel;

  /// No description provided for @ncodeFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Ncode'**
  String get ncodeFieldLabel;

  /// No description provided for @biggenreLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get biggenreLabel;

  /// No description provided for @genreLabel.
  ///
  /// In en, this message translates to:
  /// **'Genre'**
  String get genreLabel;

  /// No description provided for @keywordsLabel.
  ///
  /// In en, this message translates to:
  /// **'Keywords'**
  String get keywordsLabel;

  /// No description provided for @novelTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get novelTypeLabel;

  /// No description provided for @lengthLabel.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get lengthLabel;

  /// No description provided for @readTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Reading time'**
  String get readTimeLabel;

  /// No description provided for @globalPointLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get globalPointLabel;

  /// No description provided for @favNovelCuntLabel.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get favNovelCuntLabel;

  /// No description provided for @firstUpLabel.
  ///
  /// In en, this message translates to:
  /// **'First published'**
  String get firstUpLabel;

  /// No description provided for @lastUpLabel.
  ///
  /// In en, this message translates to:
  /// **'Last updated'**
  String get lastUpLabel;

  /// No description provided for @lengthValue.
  ///
  /// In en, this message translates to:
  /// **'{value} chars'**
  String lengthValue(Object value);

  /// No description provided for @readTimeValue.
  ///
  /// In en, this message translates to:
  /// **'{value} min'**
  String readTimeValue(Object value);

  /// No description provided for @globalPointValue.
  ///
  /// In en, this message translates to:
  /// **'{value}pt'**
  String globalPointValue(Object value);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
