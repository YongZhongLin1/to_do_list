import 'package:bloc/bloc.dart';
import 'package:to_do_list/model/index.dart';
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
    } else if (event is HomeRefresh) {
      yield* _mapHomeRefresh(currentState).asStream();
    }
  }

  Future<HomeState> _mapFirstInit(HomeState state) async {
    try {
      return state.copyWith(
        toDoList: [ToDo(title: "Test")],
      );
    } catch (e) {
      print(e);
    }
    return state;
  }

  Future<HomeState> _mapHomeRefresh(HomeState state) async {
    try {
      return state.copyWith(
        toDoList: [],
      );
    } catch (e) {
      print(e);
    }
    return state;
  }
}
