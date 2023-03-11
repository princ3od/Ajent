class Resource {
  final String id;
  final String name;
  final String description;
  final String url;
  final String owner;
  final DateTime createdAt;
  final String type;

  Resource({
    this.id,
    this.name,
    this.description,
    this.url,
    this.createdAt,
    this.owner,
    this.type,
  });

  factory Resource.fromJson(String id, Map<String, dynamic> json) {
    return Resource(
      id: id,
      name: json['name'],
      description: json['description'],
      url: json['url'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      owner: json['owner'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'url': url,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'owner': owner,
      'type': type,
    };
  }

  Future<Resource> copyWith({
    String id,
    String name,
    String description,
    String url,
    String owner,
    DateTime createdAt,
    String type,
  }) async {
    return Resource(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      owner: owner ?? this.owner,
      type: type ?? this.type,
    );
  }

  String get fileType {
    if (type == 'pdf') return type;
    return 'image';
  }
}
