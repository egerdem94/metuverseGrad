import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/buttons/notification/controller/NotificationController.dart';
import 'package:metuverse/buttons/notification/model/Report.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellNotificationPage.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/TransportationNotificationPage.dart';
import 'package:metuverse/screens/sport/sport_main/view/SportNotificationPage.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/WhisperNotificationPage.dart';
import 'package:metuverse/widgets/GeneralBottomNavigation.dart';
import 'package:metuverse/widgets/LoadingIndicator.dart';

class ReportPage extends StatefulWidget {
  const ReportPage();

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  NotificationController notificationController = NotificationController();
  List<Report>? reports;
  @override
  void initState() {
    super.initState();
    notificationController.getReports().then((_) {
      setState(() {
        reports = notificationController.reportList?.items;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text(
          "Report List",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
      ),
      body: reports == null
          ? LoadingIndicator() // Display loading indicator when reports are null
          : ListView.builder(
        itemCount: reports?.length ?? 0,
        itemBuilder: (context, index) {
          final report = reports![index];
          return ReportItem(
            report: report,
            notificationController: notificationController,
            onTap: () {
              if(report.pageID == 1){
                Get.to(WhisperNotificationPage(notificationID: report.postID!.toString()));
              }
              else if(report.pageID == 201 || report.pageID == 202){
                var buyOrSell = report.pageID == 201?'s':'b';
                Get.to(BuySellNotificationPage(buyOrSell: buyOrSell, postID: report.postID!));
              }
              else if(report.pageID == 301 || report.pageID == 302){
                var customerOrDriver = report.pageID == 301?'c':'d';
                Get.to(TransportationNotificationPage(customerOrDriver: customerOrDriver, postID: report.postID!));
              }
              else if(report.pageID == 4){
                Get.to(SportNotificationPage(notificationPostID: report.postID!.toString(),));
              }
            },
          );
        },
      ),
      bottomNavigationBar: GeneralBottomNavigation(pageIndex: 0,),
    );
  }
}
class ReportItem extends StatefulWidget {
  final Function onTap;
  final Report report;
  final NotificationController notificationController;

  const ReportItem({
    Key? key,
    required this.onTap,
    required this.report,
    required this.notificationController,
  }) : super(key: key);

  @override
  _ReportItemState createState() => _ReportItemState();
}
class _ReportItemState extends State<ReportItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.report.profilePicture ?? "https://www.birikikoli.com/mv_services/user/user_default_profile_picture.png"),
      ),
      title: Text(
        widget.report.fullName ?? '',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        widget.notificationController.extractReportReason(widget.report.reportReasonID!),
        style: TextStyle(color: Colors.white),
      ),
      // You could navigate to a detailed page of each report
      onTap: () => widget.onTap(),
      tileColor: Colors.black,
    );
  }
}