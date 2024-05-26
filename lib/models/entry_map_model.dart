class Entry {
  String date;
  String? description;
  String? image;
  List<String>? properties;
  int? value;

  Entry(this.date, this.description, this.image) : value = 1;
}

class EntryMap {
  Map<String, List<Entry>> map;

  EntryMap() : map = {};

  List<Entry>? getEntries(String date) {
    return map[date];
  }

  void add(
      {String? description,
      String? image,
      int? value,
      List<String>? properties,
      required String date}) {
    Entry entry = Entry(date, description, image);
    if (map.containsKey(date)) {
      map[date]!.add(entry);
    } else {
      map[date] = [entry];
    }
  }
}
