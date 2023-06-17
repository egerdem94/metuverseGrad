import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/backend/BackendHelperSellBuy.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/db/DatabaseHelperSellBuy.dart';
import 'package:metuverse/screens/sport/sport_main/model/SportPost.dart';

class SportPostHandler{
  final dbHelper = DatabaseHelperSellBuy();
  final backendHelper = BackendHelperSellBuy();
  bool initialized = false;
  bool ready = false;

  SportPostList sportPostList = SportPostList.defaults();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dbHelper.init();
    initialized = true;
  }
}