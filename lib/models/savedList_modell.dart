// models/item.dart
class Item {
  final int? id;
  final String title;         // 小説のタイトル
  final String ncode;         // ncode
  final String story;         // 小説のあらすじ
  final String writer;        // 作者名
  final int biggenre;         // 大ジャンル
  final int genre;            // ジャンル
  final String keywords;      // キーワード
  final int novelType;        // 種類（連載/短編）
  final int length;           // 文字数
  final int time;             // 読書時間（分）
  final int globalPoint;      // 総合評価ポイント
  final int favNovelCunt;     // ブックマーク数
  final String generalFirstup; // 初回掲載日（ISO8601文字列）
  final String generalLastup;  // 最新掲載日（ISO8601文字列）

  Item({
    this.id,
    required this.title,
    required this.ncode,
    required this.story,
    required this.writer,
    required this.biggenre,
    required this.genre,
    required this.keywords,
    required this.novelType,
    required this.length,
    required this.time,
    required this.globalPoint,
    required this.favNovelCunt,
    required this.generalFirstup,
    required this.generalLastup,
  });

  // MapからItemオブジェクトを作成
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      title: map['title'],
      ncode: map['ncode'],
      story: map['story'],
      writer: map['writer'],
      biggenre: map['biggenre'],
      genre: map['genre'],
      keywords: map['keywords'],
      novelType: map['novel_type'],
      length: map['length'],
      time: map['time'],
      globalPoint: map['global_point'],
      favNovelCunt: map['fav_novel_cnt'],
      generalFirstup: map['general_firstup'],
      generalLastup: map['general_lastup'],
    );
  }

  // ItemオブジェクトをMapに変換
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ncode': ncode,
      'story': story,
      'writer': writer,
      'biggenre': biggenre,
      'genre': genre,
      'keywords': keywords,
      'novel_type': novelType,
      'length': length,
      'time': time,
      'global_point': globalPoint,
      'fav_novel_cnt': favNovelCunt,
      'general_firstup': generalFirstup,
      'general_lastup': generalLastup,
    };
  }
}
