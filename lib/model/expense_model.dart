import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Categories { food, travel, leisure, work }

const categoriesIcon = {
  Categories.food: Icons.fastfood,
  Categories.work: Icons.card_travel,
  Categories.travel: Icons.directions_bus,
  Categories.leisure: Icons.movie,
};

class Expenses {
  Expenses({
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.categories,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final Categories categories;

  String get dateFormat => "$dateTime".substring(0, 10);
}
