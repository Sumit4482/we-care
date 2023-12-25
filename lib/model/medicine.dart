class Medicine {
  final String name;
  final String time;

  Medicine({required this.name, required this.time});

  // Convert Medicine object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
    };
  }

  // Create Medicine object from JSON
  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'],
      time: json['time'],
    );
  }
}
