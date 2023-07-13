class Store {
  String id;
  String name;
  String address;
  String location;

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
  });

  Store.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        address = json['address'] as String,
        location = json['location'] as String;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'address': address,
      'location': location,
    };
  }
}
