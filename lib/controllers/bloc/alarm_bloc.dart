import 'package:alarmtogether/models/alarm.dart';
import 'package:bloc/bloc.dart';

class AlarmBloc extends Cubit<Map<String, dynamic>> {
  AlarmBloc(Alarm? alarm) : super((alarm ?? Alarm(time: DateTime.now())).toJson());

  Alarm get alarm => Alarm.fromJson(state);

  void changeField(String key, dynamic value) {
    state[key] = value;
    emit(state.map((key, value) => MapEntry(key, value)));
  }
}