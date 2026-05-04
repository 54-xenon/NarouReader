
// モデルクラス
class Novel {
  final String title; //作者名
  final String story; //作品のあらすじ
  final String writer; //作者名
  final String ncode; //Nコード
  final int biggenre; //大ジャンル
  final int genre; // ジャンル
  final String keywords; //キーワード。検索用の変数が同じ名前だから頭文字を変えた
  final int novelType; // 種類
  final int length; // 小説の文字数
  final int time; //読書の所要時間
  final int globalPoint; // 総合評価ポイント
  final int favNovelCunt; // ブックマーク数
  final DateTime generalFirstup; // 初回掲載日
  final DateTime generalLastup; // 最新掲載日



  Novel({
    required this.title,
    required this.story,
    required this.writer,
    required this.ncode,
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

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
      title: json['title'],
      story: json['story'],
      writer: json['writer'],
      ncode: json['ncode'],
      biggenre: json['biggenre'],
      genre: json['genre'],
      keywords: json['keyword'],
      novelType: json['novel_type'],
      length: json['length'],
      time: json['time'],
      globalPoint: json['global_point'],
      favNovelCunt: json["fav_novel_cnt"],
      generalFirstup: DateTime.parse(json['general_firstup']),
      generalLastup: DateTime.parse(json['general_lastup']),
    );
  }
}

