import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/common/index.dart';
import 'package:to_do_list/locator.dart';
import 'package:to_do_list/model/index.dart';
import 'package:to_do_list/service/index.dart';
import 'package:to_do_list/feature/home/bloc/bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _homeBloc,
      builder: (context, state) {
        return Scaffold(
          /// UI of the bar at the top of the app
          appBar: _buildAppBar(),

          /// UI for the To-Do list
          body: _buildToDoList(state),

          /// UI of the button to add a new To-Do card
          floatingActionButton: _buildFloatingActionBtn(),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.amberAccent[700],
      title: Text(
        "To-Do List",
        style:
            TextStyle(color: Colors.black, fontSize: 3 * Config.textMultiplier),
      ),
    );
  }

  Widget _buildToDoList(HomeState state) {
    /// Use ListView.separated instead of ListView.builder
    /// to separate the card with some spacing
    return ListView.separated(
        controller: ScrollController(),
        padding: EdgeInsets.symmetric(vertical: 20.0),
        itemBuilder: (context, index) {
          var e = state.toDoList[index];

          /// UI of To-Do card widget
          return _buildCard(e);
        },
        separatorBuilder: (context, index) {
          return Container();
        },
        itemCount: state.toDoList.length);
  }

  Widget _buildCard(ToDo toDo) {
    return GestureDetector(
      ///Go to form page to edit this To-Do item
      onTap: () => locator<NavigationService>().navigateToForm(toDo: toDo),
      child: Container(
        padding: EdgeInsets.all(1.3 * Config.textMultiplier),
        child: Card(
          elevation: 15.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ///This is the title of the card
              Container(
                  padding: EdgeInsets.fromLTRB(25, 25, 50, 10),
                  child: Text(
                    toDo.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 2.5 * Config.textMultiplier,
                    ),
                  )),

              ///This is all of the timing in the card
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Start Date",
                              style: TextStyle(
                                fontSize: 2 * Config.textMultiplier,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            toDo.startTime is DateTime
                                ? DateFormat('dd MMM yyyy')
                                    .format(toDo.startTime)
                                : "-",
                            style: TextStyle(
                                fontSize: 2 * Config.textMultiplier,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("End Date",
                              style: TextStyle(
                                fontSize: 2 * Config.textMultiplier,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            toDo.endTime is DateTime
                                ? DateFormat('dd MMM yyyy').format(toDo.endTime)
                                : "-",
                            style: TextStyle(
                                fontSize: 2 * Config.textMultiplier,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Time Left",
                              style: TextStyle(
                                fontSize: 2 * Config.textMultiplier,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          toDo.startTime is DateTime &&
                                  toDo.endTime is DateTime &&
                                  DateTime(
                                              toDo.endTime.year,
                                              toDo.endTime.month,
                                              toDo.endTime.day)
                                          .difference(DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day,
                                              23,
                                              59,
                                              59))
                                          .inSeconds <
                                      0
                              ? CountdownTimer(
                                  endTime: toDo.endTime.millisecondsSinceEpoch *
                                      60 *
                                      60,
                                  widgetBuilder: (_, time) {
                                    return Text(
                                      DateTime(
                                                      toDo.endTime.year,
                                                      toDo.endTime.month,
                                                      toDo.endTime.day)
                                                  .difference(DateTime(
                                                      DateTime.now().year,
                                                      DateTime.now().month,
                                                      DateTime.now().day))
                                                  .inDays <
                                              0
                                          ? "-"
                                          : DateTime(
                                                          toDo.endTime.year,
                                                          toDo.endTime.month,
                                                          toDo.endTime.day)
                                                      .difference(DateTime(
                                                          DateTime.now().year,
                                                          DateTime.now().month,
                                                          DateTime.now().day))
                                                      .inDays ==
                                                  0
                                              ? "${time?.hours ?? 0} h ${time?.min ?? 0} m"
                                              : DateTime(
                                                          toDo.endTime.year,
                                                          toDo.endTime.month,
                                                          toDo.endTime.day)
                                                      .difference(DateTime(
                                                          DateTime.now().year,
                                                          DateTime.now().month,
                                                          DateTime.now().day))
                                                      .inDays
                                                      .toString() +
                                                  " d  ${time?.hours ?? 0} h",
                                      style: TextStyle(
                                          fontSize: 2 * Config.textMultiplier,
                                          fontWeight: FontWeight.w700),
                                    );
                                  },
                                )
                              : Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 2 * Config.textMultiplier,
                                      fontWeight: FontWeight.w700),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///This is the status and tickbox in the card
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.brown[100],
                ),
                padding: EdgeInsets.only(left: 25, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Status  ",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w700,
                          fontSize: 2 * Config.textMultiplier),
                    ),
                    Text(
                      toDo.status == true ? "Completed" : "Incomplete",
                      style: TextStyle(
                          fontSize: 2 * Config.textMultiplier,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "Tick if completed",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 2 * Config.textMultiplier),
                    ),
                    Checkbox(
                      value: toDo.status,
                      onChanged: (checked) {
                        BlocProvider.of<HomeBloc>(context)
                            .dispatch(HomeTickCard(id: toDo.id));
                      },
                      checkColor: Colors.green,
                      activeColor: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionBtn() {
    return FloatingActionButton(
      elevation: 20.0,

      ///Go to form page to add new To-Do item
      onPressed: () => locator<NavigationService>().navigateToForm(),
      backgroundColor: Colors.deepOrange,
      child: Icon(Icons.add),
    );
  }
}
