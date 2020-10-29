import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_list/locator.dart';
import 'package:to_do_list/model/index.dart';
import 'package:to_do_list/service/index.dart';
import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeState.initial();

  @override
  void onTransition(Transition<HomeEvent, HomeState> transition) {
    //print(transition);
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeFirstInit) {
      yield* _mapFirstInit(currentState).asStream();
    } else if (event is HomeTickCard) {
      yield* _mapHomeTickCard(currentState, event.id).asStream();
    } else if (event is HomeSubmitForm) {
      yield* _mapHomeUpdateCard(
              currentState, event.toDo, event.formKey, event.isNew)
          .asStream();
    }
  }

  Future<HomeState> _mapFirstInit(HomeState state) async {
    try {
      return state.copyWith(
        toDoList: [
          ToDo(
              id: "0",
              title:
                  "Test fwef  few  wf wf fwefw wf wef wffef wef wew wf wfew fwef deq rwfre gergrerfre r rwf wf we fwfewf we fwf wfw fw"),
          ToDo(id: "1", title: "Test1"),
          ToDo(id: "2", title: "Test2"),
          ToDo(id: "3", title: "Test3"),
          ToDo(id: "4", title: "Test4"),
          ToDo(id: "5", title: "Test5"),
        ],
      );
    } catch (e) {
      print(e);
    }
    return state;
  }

  Future<HomeState> _mapHomeTickCard(HomeState state, String id) async {
    try {
      state.toDoList.where((element) => element.id == id).first.status =
          !state.toDoList.where((element) => element.id == id).first.status;
      // state.toDoList.sort((a, b) {
      //   if (a.status)
      //     return 1;
      //   else
      //     return -1;
      // });
      return state.copyWith(
        toDoList: state.toDoList,
      );
    } catch (e) {
      print(e);
    }
    return state;
  }

  Future<HomeState> _mapHomeUpdateCard(HomeState state, ToDo toDo,
      GlobalKey<FormState> formKey, bool isNew) async {
    var navigator = locator<NavigationService>();
    try {
      if (formKey.currentState.validate()) {
        if (isNew) {
          ///Create New Entry
          state.toDoList.length == 0
              ? toDo.id = "1"
              : toDo.id = (int.parse(state.toDoList.last.id) + 1).toString();
          state.toDoList.add(toDo);
        } else {
          ///Update Current Entry
          state.toDoList[state.toDoList
              .indexWhere((element) => element.id == toDo.id)] = toDo;
        }
        navigator.pop();
        return state.copyWith(toDoList: state.toDoList);
      }
    } catch (e) {
      print(e);
    }
    return state;
  }
}
