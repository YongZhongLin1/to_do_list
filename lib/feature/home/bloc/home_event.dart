import 'package:flutter/material.dart';
import 'package:to_do_list/model/index.dart';

abstract class HomeEvent {}

class HomeFirstInit extends HomeEvent {
  HomeFirstInit();
}

class HomeSubmitForm extends HomeEvent {
  final ToDo toDo;
  final bool isNew;
  final GlobalKey<FormState> formKey;
  HomeSubmitForm(
      {@required this.toDo, @required this.isNew, @required this.formKey});
}

class HomeTickCard extends HomeEvent {
  final String id;
  HomeTickCard({@required this.id});
}
