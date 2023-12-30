// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDosAdapter extends TypeAdapter<ToDos> {
  @override
  final int typeId = 1;

  @override
  ToDos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDos(
      priority: fields[0] as int?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      isCompleted: fields[3] == null ? false : fields[3] as bool?,
      isHistory: fields[4] == null ? false : fields[4] as bool?,
      createDate: fields[5] as DateTime?,
      completionDate: fields[6] as DateTime?,
      hide: fields[7] as bool?,
      category: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ToDos obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.priority)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.isHistory)
      ..writeByte(5)
      ..write(obj.createDate)
      ..writeByte(6)
      ..write(obj.completionDate)
      ..writeByte(7)
      ..write(obj.hide)
      ..writeByte(8)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SettingsDataAdapter extends TypeAdapter<SettingsData> {
  @override
  final int typeId = 2;

  @override
  SettingsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsData(
      isStarted: fields[0] as bool,
      notification: fields[1] as bool,
      name: fields[2] as String,
      password: fields[4] as String,
      lock: fields[3] as bool,
      biometric: fields[5] as bool,
      language: fields[6] as String,
      firstDayOfWeek: fields[7] as String?,
      timeFormat: fields[8] as int,
      dataFormat: fields[9] as int,
      sortedTodo: fields[10] as int,
      hideCompletedTodo: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsData obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.isStarted)
      ..writeByte(1)
      ..write(obj.notification)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.lock)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.biometric)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.firstDayOfWeek)
      ..writeByte(8)
      ..write(obj.timeFormat)
      ..writeByte(9)
      ..write(obj.dataFormat)
      ..writeByte(10)
      ..write(obj.sortedTodo)
      ..writeByte(11)
      ..write(obj.hideCompletedTodo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryTodoAdapter extends TypeAdapter<CategoryTodo> {
  @override
  final int typeId = 3;

  @override
  CategoryTodo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryTodo(
      name: fields[0] as String?,
      id: fields[1] as int?,
      hide: fields[2] as bool,
      lock: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryTodo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.hide)
      ..writeByte(3)
      ..write(obj.lock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryTodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NotificationSettingsAdapter extends TypeAdapter<NotificationSettings> {
  @override
  final int typeId = 4;

  @override
  NotificationSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationSettings(
      isShowTitle: fields[0] as bool?,
      isShowDescription: fields[1] as bool?,
      silent: fields[2] as bool?,
      hideAlarmIcon: fields[3] as bool?,
      snooze: fields[4] as int?,
      taskReminderDefault: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationSettings obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isShowTitle)
      ..writeByte(1)
      ..write(obj.isShowDescription)
      ..writeByte(2)
      ..write(obj.silent)
      ..writeByte(3)
      ..write(obj.hideAlarmIcon)
      ..writeByte(4)
      ..write(obj.snooze)
      ..writeByte(5)
      ..write(obj.taskReminderDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
