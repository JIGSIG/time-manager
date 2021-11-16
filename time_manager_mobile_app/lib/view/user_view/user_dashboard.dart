import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  List<_SalesData> data = [
    _SalesData('Jan', DateTime.parse("2021-11-13 20:57:43"), 35),
    _SalesData('Feb', DateTime.parse("2021-01-13 20:57:43"), 28),
    _SalesData('Mar', DateTime.parse("2021-05-13 20:57:43"), 34),
    _SalesData('Apr', DateTime.parse("2021-07-13 20:57:43"), 32),
    _SalesData('May', DateTime.parse("2021-09-13 20:57:43"), 40)
  ];
  List<_SalesData> data1 = [
    _SalesData('Jan', DateTime.parse("2021-11-13 20:57:43"), 35),
    _SalesData('Feb', DateTime.parse("2021-11-13 20:57:43"), 28),
    _SalesData('Mar', DateTime.parse("2021-11-13 20:57:43"), 34),
    _SalesData('Apr', DateTime.parse("2021-11-13 20:57:43"), 32),
    _SalesData('May', DateTime.parse("2021-11-13 20:57:43"), 40)
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: 'Half yearly sales analysis'),
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales',
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true))
                ]),
            SfCircularChart(series: <CircularSeries>[
              PieSeries<_SalesData, String>(
                dataSource: data,
                xValueMapper: (_SalesData data, _) => data.year,
                yValueMapper: (_SalesData data, _) => data.sales,
              )
            ]),
            SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                series: <ChartSeries>[
                  SplineAreaSeries<_SalesData, DateTime>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.dateTime,
                      yValueMapper: (_SalesData sales, _) => sales.sales),
                  SplineAreaSeries<_SalesData, DateTime>(
                      dataSource: data1,
                      xValueMapper: (_SalesData sales, _) => sales.dateTime,
                      yValueMapper: (_SalesData sales, _) => sales.sales),
                ]),
          ]),
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.dateTime, this.sales);

  final String year;
  final DateTime dateTime;
  final double sales;
}
