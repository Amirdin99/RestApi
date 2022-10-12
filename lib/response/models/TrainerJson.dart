class TrainerJson {
  TrainerJson({
    required this.name,
    required this.surname,
    required this.salary,
    this.id,
  });

  factory TrainerJson.fromJson(Map<String, dynamic> json) {
    return TrainerJson(
      name: json['name'],
      surname: json['surname'],
      salary: json['salary'],
      id: json['id'],
    );
  }

  final String name;
  final String surname;
  final String salary;
  String? id;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = this.name;
    data['surname'] = this.surname;
    data['salary'] = this.salary;
    data['id'] = this.id;
    return data;
  }

  static listFromJson(dynamic json) {
    return (json as List).map((e) => TrainerJson.fromJson(e)).toList();
  }
}
