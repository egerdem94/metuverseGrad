//import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:path_provider/path_provider.dart';

abstract class DatabaseHelper {
  final databaseName = "Metuverse.db";
  int databaseVersion = 1;
  late Database db;

}