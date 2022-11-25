import 'dart:core';

class Task {
  final String id;
  final String name;
  final String date;
  final String startTime;
  final String endTime;
  final String category;
  final String colorCategory;
  final String priority;
  final String colorPriority;
  final String reminder;
  final String notes;

  Task({
    required this.id,
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.category,
    required this.colorCategory,
    required this.priority,
    required this.colorPriority,
    required this.reminder,
    required this.notes,
  });

  factory Task.fromJson(Map<String, dynamic> task) => Task(
    id: task['id'],
    name: task['name'],
    date: task['date'],
    startTime: task['startTime'],
    endTime: task['endTime'],
    category: task['category'],
    colorCategory: task['colorCategory'],
    priority: task['priority'],
    colorPriority: task['colorPriority'],
    reminder: task['reminder'],
    notes: task['notes'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'date': date,
    'startTime': startTime,
    'endTime': endTime,
    'category': category,
    'colorCategory': colorCategory,
    'priority': priority,
    'colorPriority': colorPriority,
    'reminder': reminder,
    'notes': notes,
  };
}
