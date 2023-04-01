import 'package:sqflite/sqflite.dart';

class DatabaseHelperParent {
  final databaseName = "Metuverse.db";
  int databaseVersion = 1;
  late Database db;
  Future<void> init() async{

  }
}