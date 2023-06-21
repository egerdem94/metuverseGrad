import 'package:flutter/material.dart';
import 'package:metuverse/buttons/notification/controller/NotificationController.dart';
import 'package:metuverse/buttons/notification/model/Report.dart';

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
      appBar: AppBar(
        title: Text('Report List'),
      ),
      body: ListView.builder(
        itemCount: reports?.length ?? 0,
        itemBuilder: (context, index) {
          final report = reports![index];
          return ReportItem(report: report, notificationController: notificationController,);
        },
      ),
    );
  }
}

class ReportItem extends StatelessWidget {
  const ReportItem({
    super.key,
    required this.report, required this.notificationController,
  });

  final Report report;
  final NotificationController notificationController;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(report.profilePicture ??
            "https://www.birikikoli.com/mv_services/user/user_default_profile_picture.png"),
      ),
      title: Text(report.fullName ?? ''),
      subtitle: Text(notificationController.extractReportReason(report.reportReasonID!)),
      // You could navigate to a detailed page of each report
      onTap: () {},
    );
  }
}
