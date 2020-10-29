class ToDo {
  String id;
  String title;
  DateTime startTime;
  DateTime endTime;
  bool status;

  ToDo(
      {this.id, this.title, this.startTime, this.endTime, this.status = false});

  ToDo copyWith(
      {String id,
      String title,
      DateTime startTime,
      DateTime endTime,
      bool status}) {
    var state = ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
    );
    return state;
  }
}
