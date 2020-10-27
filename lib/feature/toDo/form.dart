import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/common/index.dart';
import 'package:to_do_list/service/index.dart';

class ToDoForm extends StatefulWidget {
  @override
  _ToDoFormState createState() => _ToDoFormState();
}

class _ToDoFormState extends State<ToDoForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.orange,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          BlocProvider.of<NavigatorBloc>(context)
              .dispatch(NavigatorActionPop());
        },
      ),
      title: Text(
        "Add new To-Do List",
        style:
            TextStyle(color: Colors.black, fontSize: 3 * Config.textMultiplier),
      ),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}
