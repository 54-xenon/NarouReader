// models/item.dart
class Item {
  final int? id;
  final String title;  // 小説のタイトル
  final String ncode;  // 小説コード
  final String story;  // 小説のあらすじ

  Item({
    this.id,
    required this.title,
    required this.ncode,
    required this.story,
  });

  // MapからItemオブジェクトを作成
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      title: map['title'],
      ncode: map['ncode'],
      story: map['story'],
    );
  }

  // ItemオブジェクトをMapに変換
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ncode': ncode,
      'story': story,
    };
  }
}
