import 'package:flutter/material.dart';
import 'package:metuverse/Chat/components/widgets/messageScreenAppBar.dart';

import '../../../constants.dart';
import 'components/messageBody.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MessageAppBar(),
      body: MessageBody(),
    );
  }
}
