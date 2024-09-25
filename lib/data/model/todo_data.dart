class TodoData {
  final int? id;
  final String name;
  final String date;
  final String category;
  final String importance;
  final String setAlarm;
  final String color;

  TodoData(
    {
      this.id,
      required this.name,
      required this.date,
      required this.category,
      required this.importance,
      required this.setAlarm,
      required  this.color
    }
  );

  factory TodoData.fromJson(Map<String, dynamic> json){
    return TodoData(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      category: json['category'],
      importance: json['importance'],
      setAlarm: json['setAlarm'],
      color: json['color']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'date': date,
      'category': category,
      'importance': importance,
      'setAlarm': setAlarm,
      'color': color
    };
  }
}