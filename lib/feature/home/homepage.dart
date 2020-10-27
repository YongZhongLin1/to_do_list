import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/common/index.dart';
import 'package:to_do_list/model/index.dart';
import 'package:to_do_list/service/index.dart';
import 'package:to_do_list/service/navigationBloc/navigationEvent.dart';
import 'package:to_do_list/feature/home/bloc/bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _homeBloc.dispatch(HomeFirstInit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => _homeBloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildToDoList(state),
            floatingActionButton: _buildFloatingActionBtn(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.orange,
      title: Text(
        "To-Do List",
        style:
            TextStyle(color: Colors.black, fontSize: 3 * Config.textMultiplier),
      ),
    );
  }

  Widget _buildToDoList(HomeState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: state.toDoList.map((e) => _buildCard(e)).toList(),
    );
  }

  Widget _buildCard(ToDo toDo) {
    return Container(
      child: Text(toDo.title),
    );
  }

  Widget _buildFloatingActionBtn() {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<NavigatorBloc>(context).dispatch(NavigateToForm());
      },
      backgroundColor: Colors.deepOrange,
      child: Icon(Icons.add),
    );
  }
}
