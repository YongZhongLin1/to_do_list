import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/common/index.dart';
import 'package:to_do_list/feature/home/bloc/bloc.dart';
import 'package:to_do_list/locator.dart';
import 'package:to_do_list/model/index.dart';
import 'package:to_do_list/service/index.dart';

class ToDoForm extends StatefulWidget {
  final ToDo toDo;

  const ToDoForm({Key key, this.toDo}) : super(key: key);
  @override
  _ToDoFormState createState() => _ToDoFormState();
}

class _ToDoFormState extends State<ToDoForm> {
  FocusNode _focusNode = FocusNode();
  HomeBloc _homeBloc;
  final _formKey = new GlobalKey<FormState>();
  TextEditingController titleController;
  TextEditingController startTimeController;
  TextEditingController endTimeController;
  ToDo entry;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    entry = widget.toDo == null ? ToDo() : widget.toDo;
    titleController = TextEditingController(text: widget?.toDo?.title ?? "");
    startTimeController = TextEditingController(
        text: widget?.toDo?.startTime != null
            ? DateFormat('yyyy-MM-dd').format(widget?.toDo?.startTime)
            : "");
    endTimeController = TextEditingController(
        text: widget?.toDo?.endTime != null
            ? DateFormat('yyyy-MM-dd').format(widget?.toDo?.endTime)
            : "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
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
          locator<NavigationService>().pop();
        },
      ),
      title: Text(
        widget.toDo != null ? "Edit" : "Add new To-Do List",
        style:
            TextStyle(color: Colors.black, fontSize: 3 * Config.textMultiplier),
      ),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          new Expanded(flex: 4, child: _buildForm()),
          GestureDetector(
            onTap: () {
              _homeBloc.dispatch(HomeSubmitForm(
                  isNew: widget.toDo == null, formKey: _formKey, toDo: entry));
            },
            child: Container(
              color: Colors.black,
              height: 7 * Config.textMultiplier,
              width: MediaQuery.of(context).size.width,
              child: Text(
                widget.toDo == null ? "Create New" : "Save",
                style: TextStyle(
                    color: Colors.white, fontSize: 3 * Config.textMultiplier),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            _buildTitleField(),
            _buildStartTimeField(),
            _buildEndTimeField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 50, 25, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "To-Do Title",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                  fontSize: 2.5 * Config.textMultiplier),
            ),
          ),
          TextFormField(
            style: TextStyle(fontSize: 2 * Config.textMultiplier),
            focusNode: _focusNode,
            maxLines: 5,
            controller: titleController,
            onChanged: (text) => entry.title = text,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Please key in your To-Do title here",
                hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 2 * Config.textMultiplier)),
            validator: (text) {
              if (text.isEmpty) return "Please enter a title.";
              return null;
            },
          )
        ],
      ),
    );
  }

  Widget _buildStartTimeField() {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Start Date:",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 2.5 * Config.textMultiplier),
            ),
          ),
          TextFormField(
            style: TextStyle(fontSize: 2 * Config.textMultiplier),
            readOnly: true,
            controller: startTimeController,
            onTap: () {
              DatePicker.showDatePicker(context, onConfirm: (time) {
                startTimeController.text =
                    DateFormat('yyyy-MM-dd').format(time);
                entry.startTime = time;
              });
            },
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.keyboard_arrow_down),
                border: OutlineInputBorder(),
                hintText: "Select a date",
                hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 2 * Config.textMultiplier)),
          )
        ],
      ),
    );
  }

  Widget _buildEndTimeField() {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Estimate End Date:",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 2.5 * Config.textMultiplier),
            ),
          ),
          TextFormField(
            style: TextStyle(fontSize: 2 * Config.textMultiplier),
            readOnly: true,
            controller: endTimeController,
            onTap: () {
              DatePicker.showDatePicker(context, onConfirm: (time) {
                endTimeController.text = DateFormat('yyyy-MM-dd').format(time);
                entry.endTime = time;
              });
            },
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.keyboard_arrow_down),
                border: OutlineInputBorder(),
                hintText: "Select a date",
                hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 2 * Config.textMultiplier)),
          )
        ],
      ),
    );
  }
}
