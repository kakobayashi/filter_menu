import 'package:filter_menu/task.dart';
import 'package:flutter/material.dart';

List<Task> tasks = [
  Task(
    name: "Catch up with Brian",
    category: "Mobile Project",
    time: "5pm",
    color: Colors.orange,
    completed: false,
  ),
  Task(
    name: "Make new icons",
    category: "Web App",
    time: "3pm",
    color: Colors.cyan,
    completed: true,
  ),
  Task(
      name: "Design explorations",
      category: "Company Website",
      time: "2pm",
      color: Colors.pink,
      completed: false
  ),
  Task(
      name: "Lunch with Mary",
      category: "Grill House",
      time: "12pm",
      color: Colors.cyan,
      completed: true
  ),
  Task(
      name: "Teem Meeting",
      category: "Hangouts",
      time: "10am",
      color: Colors.cyan,
      completed: true
  ),
];
