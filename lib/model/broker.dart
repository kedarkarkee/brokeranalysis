class Broker {
  final num code;
  final String name;

  Broker(this.code, this.name);

  factory Broker.fromMap(Map<String, dynamic> map) {
    return Broker(map['code'], map['name']);
  }
}
