// データモデルの作成

class Item {
  final String title;
  final dynamic ncode;
  final String story;
  final int date;

  Item({
    required this.title,
    required this.ncode,
    required this.story,
    required this.date,
  });

  // データをMap関数に変換(SQL操作に必要)
  Map<String, dynamic> toMap() {
    return{
      'title': title,
      'ncode': ncode,
      'story': story,
      'date': date,
    };
  }
}

