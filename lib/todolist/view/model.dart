class Task {
  final int? id;
  final String title;
  final String description;
  final String? image;
  final double? latitude;
  final double? longitude;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.image,
    this.latitude,
    this.longitude,
  });

  // Convert a Task instance into a map for SQLite operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Create a Task instance from a map retrieved from SQLite
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      image: map['image'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
