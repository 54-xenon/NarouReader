
// モデルクラス
class Novel {
  final String title; //作者名
  final String story; //作品のあらすじ
  final String writer; //作者名
  final String ncode; //Nコード


  Novel({
    required this.title,
    required this.story,
    required this.writer,
    required this.ncode,
  });

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
      title: json['title'],
      story: json['story'],
      writer: json['writer'],
      ncode: json['ncode'],
    );
  }
}

