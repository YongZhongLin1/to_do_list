import 'package:to_do_list/model/index.dart';

class HomeState {
  final List<ToDo> toDoList;

  HomeState({this.toDoList});

  factory HomeState.initial() {
    return HomeState(toDoList: []);
  }

  HomeState copyWith({List<ToDo> toDoList}) {
    var state = HomeState(toDoList: toDoList ?? this.toDoList);
    return state;
  }
}
