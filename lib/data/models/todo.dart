
import 'package:flutter/material.dart';

class Todo {

  Todo({
    this.title,
    this.description,
    this.createdAt,
});

  final String? title;
  final String? description;
  final int? createdAt;

  // CONVERT FROM JSON MAP TO THIS OBJECT
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      description: json['description'],
      createdAt: json['created_at'],
    );
  }
}