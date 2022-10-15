import 'contacts.dart';

class Details {
  int? id;
  late String firstname;
  late String lastname;
  late String url;
  late String number;

  Details({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.number,
    required this.url,
  });

  Details.FromMap(Map<String, dynamic> map) {
    if (map[ColumnId] != null) {
      this.id = map[ColumnId];
    }
    this.firstname = map[ColumnFirst];
    this.lastname = map[ColumnLast];
    this.url = map[ColumnUrl];
    this.number = map[ColumnNumber];
  }

  Map<String, dynamic> tomap() {
    Map<String, dynamic> map = {};
    if (this.id != null) {
      map[ColumnId] = this.id;
    }
    map[ColumnFirst] = this.firstname;
    map[ColumnLast] = this.lastname;
    map[ColumnUrl] = this.url;
    map[ColumnNumber] = this.number;
    return map;
  }
}
