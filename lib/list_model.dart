
import 'package:filter_menu/task.dart';
import 'package:flutter/material.dart';

class ListModel {
  final GlobalKey<AnimatedListState> listKey;
  final List<Task> items;

  ListModel(this.listKey, items): this.items = new List.of(items);

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, Task item) {
    items.insert(index, item);
    _animatedList.insertItem(index);
  }

  Task remoteAt(int index) {
    final Task removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index, (context, animation) => Container());
    }
    return removedItem;
  }

  int get length => items.length;

  Task operator [](int index) => items[index];

  int indexOf(Task item) => items.indexOf(item);
}